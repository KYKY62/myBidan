import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mybidan/core.dart';
import 'package:mybidan/presentation/bidan/controller/bidan_controller.dart';

class BidanPage extends StatelessWidget {
  final bidanC = Get.find<BidanController>();
  final authC = Get.find<LoginController>();

  BidanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: bidanC.getListChatUser(),
        builder: (context, snapshot) {
          // jika collection belum ada dan datanya gadak
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const SizedBox();
          }
          if (snapshot.connectionState == ConnectionState.active) {
            var allChatsUser = snapshot.data!.docs;
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: allChatsUser.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 16.0),
              itemBuilder: (context, index) => StreamBuilder<
                      DocumentSnapshot<Map<String, dynamic>>>(
                  stream:
                      bidanC.getProfileUsers(allChatsUser[index]['connection']),
                  builder: (context, snapshotProfile) {
                    DateTime lastTime =
                        DateTime.parse("${allChatsUser[index]['lastTime']}");
                    if (snapshotProfile.connectionState ==
                        ConnectionState.active) {
                      var data = snapshotProfile.data!.data();
                      return GestureDetector(
                        onTap: () {
                          // bidanC.chatPageValue.value = {
                          //   'name': data['name'],
                          //   'chat_id': allChatsUser[index].id,
                          //   'penerima': allChatsUser[index]['connection'],
                          // };
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundColor: const Color(0xfff5faf6),
                                child: Image.network(
                                  data!['photoBidan'],
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
                                      const Text(
                                        "tes",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
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
                                    style: CustomTextStyle.smallerText.copyWith(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  allChatsUser[index]['total_unread'] == 0
                                      ? const SizedBox(
                                          width: 10,
                                          height: 20,
                                        )
                                      : CircleAvatar(
                                          radius: 10,
                                          backgroundColor: AppColors.green,
                                          child: Text(
                                            allChatsUser[index]['total_unread']
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
        });
  }
}
