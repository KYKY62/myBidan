import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mybidan/core/assets/assets.gen.dart';
import 'package:mybidan/core/components/custom_card.dart';
import 'package:mybidan/core/components/custom_text_field.dart';
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
      body: ListView(
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
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
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

                        String dateTimeAwal =
                            timeAwalstampConvert.toDate().toFormattedInHours();
                        String dateTimeAkhir =
                            timeAkhirstampConvert.toDate().toFormattedInHours();
                        return GestureDetector(
                          onTap: () {
                            mainC.currentIndex.value = 5;
                            chatC.nameBidan.value = bidanData[index]['name'];
                          },
                          child: CustomCard(
                            padding: const EdgeInsets.only(
                                left: 16, top: 16, bottom: 16, right: 80),
                            name: bidanData[index]['name'],
                            description: bidanData[index]['specialistBidan'],
                            dateOperational: '',
                            timeOperational: '$dateTimeAwal - $dateTimeAkhir',
                            image: bidanData[index]['photoBidan'],
                            horizontalGap: 12,
                            backgroundColor: const Color(0xfff5faf6),
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
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: chatC.bidan.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16.0),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                mainC.currentIndex.value = 5;
                chatC.nameBidan.value = chatC.bidan[index];
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: const Color(0xfff5faf6),
                      child: Image.asset(
                        Assets.images.doctor.path,
                        width: 41,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "H&M Official Store",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: CustomTextStyle.primaryText.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              chatC.chatList[index]['chat'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "09.22",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: CustomTextStyle.smallerText.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: AppColors.green,
                          child: Text(
                            "1",
                            style: CustomTextStyle.smText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 46.0),
        ],
      ),
    );
  }
}
