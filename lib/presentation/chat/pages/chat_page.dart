import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mybidan/core/components/custom_card.dart';
import 'package:mybidan/core/components/custom_text_field.dart';
import 'package:mybidan/core/components/premium_action.dart';
import 'package:mybidan/core/constants/colors.dart';
import 'package:mybidan/core/constants/text_style.dart';
import 'package:mybidan/core/extension/date_time_ext.dart';
import 'package:mybidan/presentation/chat/controller/chat_controller.dart';
import 'package:mybidan/presentation/home/controller/main_controller.dart';

class ChatPage extends StatelessWidget {
  final chatC = Get.find<ChatController>();
  final mainC = Get.find<MainController>();
  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.primary,
        toolbarHeight: 100,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.primary,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarDividerColor: AppColors.primary,
        ),
        title: CustomTextField(
          controller: chatC.searchBidan,
          label: 'Search for seller & message',
          textStyle: const TextStyle(color: Colors.grey),
          inputColor: Colors.black,
          filled: true,
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.grey,
          ),
          keyboardType: TextInputType.text,
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<bool>(
          stream: chatC.checkAccountPremium(),
          builder: (context, snapshotIsPremium) {
            if (snapshotIsPremium.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            print(snapshotIsPremium.data);
            return snapshotIsPremium.data == true
                ? ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          'Layanan Konsultasi',
                          style: CustomTextStyle.primaryText.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          height: 198,
                          child: StreamBuilder(
                              stream: chatC.getBidan(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.docs.isEmpty) {
                                  return Text(
                                    "Belum Ada Bidan",
                                    style: CustomTextStyle.bigText.copyWith(
                                      color: Colors.white,
                                    ),
                                  );
                                }
                                var bidanData = snapshot.data!.docs;
                                return ListView.builder(
                                  itemCount: bidanData.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    Timestamp timeAwalstampConvert =
                                        bidanData[index]['jamAwalKerja'];
                                    Timestamp timeAkhirstampConvert =
                                        bidanData[index]['jamAkhirKerja'];

                                    String dateTimeAwal = timeAwalstampConvert
                                        .toDate()
                                        .toFormattedInHours();
                                    String dateTimeAkhir = timeAkhirstampConvert
                                        .toDate()
                                        .toFormattedInHours();
                                    return GestureDetector(
                                      onTap: () => chatC.addNewConnection(
                                        bidanEmail: bidanData[index]['email'],
                                      ),
                                      child: CustomCard(
                                        padding: const EdgeInsets.only(
                                            left: 16,
                                            top: 16,
                                            bottom: 16,
                                            right: 80),
                                        name: bidanData[index]['name'],
                                        description: bidanData[index]
                                            ['specialistBidan'],
                                        dateOperational: '',
                                        timeOperational:
                                            '$dateTimeAwal - $dateTimeAkhir',
                                        image: bidanData[index]['photoBidan'],
                                        horizontalGap: 12,
                                        backgroundColor:
                                            const Color(0xfff5faf6),
                                        backgroundImageColor: AppColors.neon,
                                        isChatPage: true,
                                      ),
                                    );
                                  },
                                );
                              }),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: chatC.getListChatUser(),
                          builder: (context, snapshot) {
                            // jika collection belum ada dan datanya gadak
                            if (!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty) {
                              return const SizedBox();
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.active) {
                              var allChatsUser = snapshot.data!.docs;
                              return ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: allChatsUser.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 16.0),
                                itemBuilder: (context, index) => StreamBuilder<
                                        DocumentSnapshot<Map<String, dynamic>>>(
                                    stream: chatC.getProfileBidan(
                                        allChatsUser[index]['connection']),
                                    builder: (context, snapshotProfile) {
                                      DateTime lastTime = DateTime.parse(
                                          "${allChatsUser[index]['lastTime']}");
                                      if (snapshotProfile.connectionState ==
                                          ConnectionState.active) {
                                        var data = snapshotProfile.data!.data();
                                        return GestureDetector(
                                          onTap: () {
                                            mainC.currentIndex.value = 5;
                                            chatC.chatPageValue.value = {
                                              'name': data['name'],
                                              'chat_id': allChatsUser[index].id,
                                              'penerima': allChatsUser[index]
                                                  ['connection'],
                                            };
                                            chatC.goToPrivateChat(
                                              chatId: allChatsUser[index].id,
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 28,
                                                  backgroundColor:
                                                      const Color(0xfff5faf6),
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
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          data['name'],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style: CustomTextStyle
                                                              .primaryText
                                                              .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 8.0),
                                                        StreamBuilder<
                                                                QuerySnapshot<
                                                                    Map<String,
                                                                        dynamic>>>(
                                                            stream: chatC
                                                                .historyChat(
                                                              chatId:
                                                                  allChatsUser[
                                                                          index]
                                                                      .id,
                                                            ),
                                                            builder: (context,
                                                                snapshotHistory) {
                                                              if (!snapshotHistory
                                                                      .hasData ||
                                                                  snapshotHistory
                                                                      .data!
                                                                      .docs
                                                                      .isEmpty) {
                                                                return const Text(
                                                                    '');
                                                              }
                                                              var data =
                                                                  snapshotHistory
                                                                      .data!
                                                                      .docs;
                                                              return Text(
                                                                data[0]['msg'],
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 1,
                                                              );
                                                            }),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      lastTime
                                                          .toFormattedInHours(),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: CustomTextStyle
                                                          .smallerText
                                                          .copyWith(
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    allChatsUser[index][
                                                                'total_unread'] ==
                                                            0
                                                        ? const SizedBox(
                                                            width: 10,
                                                            height: 20,
                                                          )
                                                        : CircleAvatar(
                                                            radius: 10,
                                                            backgroundColor:
                                                                AppColors.green,
                                                            child: Text(
                                                              allChatsUser[
                                                                          index]
                                                                      [
                                                                      'total_unread']
                                                                  .toString(),
                                                              style:
                                                                  CustomTextStyle
                                                                      .smText,
                                                            ),
                                                          ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }

                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }),
                              );
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          }),
                      const SizedBox(height: 46.0),
                    ],
                  )
                : PremiumAction();
          }),
    );
  }
}
