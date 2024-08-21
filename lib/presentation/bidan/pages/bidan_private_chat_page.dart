import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mybidan/core.dart';
import 'package:mybidan/presentation/bidan/controller/bidan_private_chat_controller.dart';

class BidanPrivateChatPage extends StatelessWidget {
  final bidanPrivateC = Get.put(BidanPrivateChatController());
  final String nameBidan;
  final String chatId;
  final String penerima;
  BidanPrivateChatPage({
    super.key,
    required this.nameBidan,
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
          onTap: () => Get.back(),
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
                  stream: bidanPrivateC.streamChats(chatId),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const SizedBox();
                    }
                    var allChat = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: allChat.length,
                      itemBuilder: (context, index) {
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
                                timeChat: DateTime.parse(allChat[index]['time'])
                                    .toFormattedInHours(),
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
                        controller: bidanPrivateC.chatBidan,
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
                        bidanPrivateC.newChat(
                          email: bidanPrivateC.currentUser.email!,
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
