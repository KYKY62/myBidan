import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mybidan/core/components/custom_text_field.dart';
import 'package:mybidan/core/components/item_chat.dart';
import 'package:mybidan/core/constants/colors.dart';
import 'package:mybidan/presentation/chat/controller/chat_controller.dart';

class PrivateChatPage extends StatelessWidget {
  final String nameBidan;
  final dynamic backToOntap;
  final dynamic hideFloating;

  final chatC = Get.put(ChatController());
  PrivateChatPage({
    super.key,
    required this.nameBidan,
    required this.backToOntap,
    required this.hideFloating,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7FD),
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: backToOntap,
          child: const Icon(
            Icons.arrow_back,
            size: 24.0,
          ),
        ),
        title: Text(nameBidan),
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.primary,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarDividerColor: AppColors.primary,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              child: ListView.builder(
                itemCount: chatC.chatList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment:
                          chatC.chatList[index]['isSender'] == true
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.end,
                      children: [
                        ItemChat(
                          chat: chatC.chatList[index]['chat'],
                          isSender: chatC.chatList[index]['isSender'],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          GestureDetector(
            onTap: hideFloating,
            child: Container(
              margin: EdgeInsets.only(bottom: context.mediaQueryPadding.bottom),
              width: Get.width,
              // color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: chatC.chatBidan,
                        label: 'Ketik Pesan',
                        keyboardType: TextInputType.text,
                        inputColor: Colors.black,
                        textStyle: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const CircleAvatar(
                      maxRadius: 30,
                      backgroundColor: AppColors.primary,
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
