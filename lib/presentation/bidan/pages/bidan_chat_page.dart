import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mybidan/core.dart';
import 'package:mybidan/presentation/bidan/controller/bidan_chat_controller.dart';

class BidanChatPage extends StatelessWidget {
  final bidanC = Get.find<BidanChatController>();
  final authC = Get.find<LoginController>();

  BidanChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.primary,
        title: Text(
          'Layanan Konsultasi',
          style: CustomTextStyle.primaryText.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.primary,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarDividerColor: AppColors.primary,
        ),
        actions: [
          IconButton(
            onPressed: () => authC.logOut(),
            icon: const Icon(
              Icons.exit_to_app,
              size: 24.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: bidanC.getListChatBidan(),
            builder: (context, snapshot) {
              // jika collection belum ada dan datanya gadak
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const SizedBox();
              }
              if (snapshot.connectionState == ConnectionState.active) {
                var allChatsBidan = snapshot.data!.docs;
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: allChatsBidan.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16.0),
                  itemBuilder: (context, index) => StreamBuilder<
                          DocumentSnapshot<Map<String, dynamic>>>(
                      stream: bidanC
                          .getProfileUsers(allChatsBidan[index]['connection']),
                      builder: (context, snapshotProfile) {
                        DateTime lastTime = DateTime.parse(
                            "${allChatsBidan[index]['lastTime']}");
                        if (snapshotProfile.connectionState ==
                            ConnectionState.active) {
                          var data = snapshotProfile.data!.data();
                          return GestureDetector(
                            onTap: () => bidanC.goToPrivateChat(
                              chatId: allChatsBidan[index].id,
                              namaBidan: data['name'],
                              penerimaEmail: allChatsBidan[index]['connection'],
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 28,
                                    backgroundColor: const Color(0xfff5faf6),
                                    child: Image.network(
                                      data!['photoUrl'],
                                      width: 41,
                                    ),
                                  ),
                                  const SizedBox(width: 12.0),
                                  Expanded(
                                    child: SizedBox(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data['name'],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: CustomTextStyle.primaryText
                                                .copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 8.0),
                                          StreamBuilder<
                                                  QuerySnapshot<
                                                      Map<String, dynamic>>>(
                                              stream: bidanC.historyChat(
                                                  chatId:
                                                      allChatsBidan[index].id),
                                              builder:
                                                  (context, snapshotHistory) {
                                                if (!snapshotHistory.hasData ||
                                                    snapshotHistory
                                                        .data!.docs.isEmpty) {
                                                  return const Text('');
                                                }
                                                var data =
                                                    snapshotHistory.data!.docs;
                                                return Text(
                                                  data[0]['msg'],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                );
                                              }),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        lastTime.toFormattedInHours(),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: CustomTextStyle.smallerText
                                            .copyWith(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      allChatsBidan[index]['total_unread'] == 0
                                          ? const SizedBox(
                                              width: 10,
                                              height: 20,
                                            )
                                          : CircleAvatar(
                                              radius: 10,
                                              backgroundColor: AppColors.green,
                                              child: Text(
                                                allChatsBidan[index]
                                                        ['total_unread']
                                                    .toString(),
                                                style: CustomTextStyle.smText,
                                              ),
                                            ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        return const Center(child: CircularProgressIndicator());
                      }),
                );
              }
              return const Center(child: CircularProgressIndicator());
            }),
      )),
    );
  }
}
