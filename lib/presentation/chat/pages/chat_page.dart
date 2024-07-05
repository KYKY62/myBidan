import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybidan/core/assets/assets.gen.dart';
import 'package:mybidan/core/components/custom_card.dart';
import 'package:mybidan/core/components/custom_text_field.dart';
import 'package:mybidan/core/constants/colors.dart';
import 'package:mybidan/core/constants/text_style.dart';
import 'package:mybidan/presentation/chat/controller/chat_controller.dart';
import 'package:mybidan/presentation/home/controller/main_controller.dart';

class ChatPage extends StatelessWidget {
  final chatC = Get.put(ChatController());
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
            padding: const EdgeInsets.all(25),
            child: Text(
              'Layanan Konsultasi',
              style: CustomTextStyle.primaryText.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListView.builder(
            itemCount: chatC.bidan.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                mainC.currentIndex.value = 5;
                chatC.nameBidan.value = chatC.bidan[index];
              },
              child: CustomCard(
                name: 'Bidan ${chatC.bidan[index]}',
                description: 'Dermatology & Leprosy',
                dateOperational: '13:00 - 13:00',
                timeOperational: '13:00 - 13:00',
                image: Assets.images.doctor.path,
                horizontalGap: 12,
                backgroundColor: const Color(0xfff5faf6),
                backgroundImageColor: AppColors.neon,
                isChatPage: true,
              ),
            ),
          )
        ],
      ),
    );
  }
}
