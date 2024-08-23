import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mybidan/core/components/custom_text_field.dart';
import 'package:mybidan/core/components/item_chat.dart';
import 'package:mybidan/core/constants/colors.dart';
import 'package:mybidan/core/extension/date_time_ext.dart';
import 'package:mybidan/presentation/chat/controller/chat_controller.dart';
import 'package:mybidan/presentation/chat/controller/private_chat_controller.dart';

class PrivateChatPage extends StatelessWidget {
  final String nameBidan;
  final String chatId;
  final String penerima;
  final dynamic backToOntap;
  final dynamic hideFloating;

  final chatC = Get.put(ChatController());
  final privateC = Get.put(PrivateChatController());
  PrivateChatPage({
    super.key,
    required this.nameBidan,
    required this.backToOntap,
    required this.hideFloating,
    required this.chatId,
    required this.penerima,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7FD),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffF7F7FD),
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
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: privateC.streamChats(chatId),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const SizedBox();
                    }
                    var allChat = snapshot.data!.docs;
                    Timer(
                      Duration.zero,
                      () => privateC.scrollC
                          .jumpTo(privateC.scrollC.position.maxScrollExtent),
                    );
                    return ListView.builder(
                      controller: privateC.scrollC,
                      itemCount: allChat.length,
                      itemBuilder: (context, index) {
                        Timestamp timestamp = allChat[index]['groupTime'];
                        DateTime groupTime = timestamp.toDate();
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment:
                                allChat[index]['penerima'] == penerima
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                            children: [
                              ItemChat(
                                chat: allChat[index]['msg'],
                                isSender:
                                    allChat[index]['penerima'] == penerima,
                                timeChat: groupTime.toFormattedInHours(),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }),
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
                        controller: privateC.chatBidan,
                        label: 'Ketik Pesan',
                        keyboardType: TextInputType.text,
                        inputColor: Colors.black,
                        textStyle: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        privateC.newChat(
                          email: privateC.currentUser.email!,
                          chatId: chatId,
                          penerima: penerima,
                        );
                      },
                      child: const CircleAvatar(
                        maxRadius: 30,
                        backgroundColor: AppColors.primary,
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
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
