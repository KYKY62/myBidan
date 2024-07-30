import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final TextEditingController searchBidan = TextEditingController();
  final TextEditingController chatBidan = TextEditingController();

  final bool isSender = false;

  RxString nameBidan = ''.obs;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot>? getBidan() =>
      db.collection('bidan').orderBy('timestamp', descending: true).snapshots();

  List bidan = [
    'Saefudin',
    'Dono',
    'Indro',
    'Kasino',
    'Danang',
  ];

  List<Map<String, dynamic>> chatList = [
    {
      'chat':
          'Halo, saya Sarah. Baru saja melahirkan dan rasanya mood saya seperti naik turun roller coaster. Apakah ada yang bisa membantu?',
      'isSender': false
    },
    {
      'chat':
          'Halo Sarah, saya senang Anda mencari bantuan. Saya adalah konselor di Holo Pablues. Ceritakan lebih lanjut, apa yang membuat suasana hati Anda berubah-ubah?',
      'isSender': true
    },
    {
      'chat':
          'Rasanya seperti saya berada dalam gelembung perasaan. Kadang-kadang saya bahagia, tapi kemudian tiba-tiba saya merasa cemas dan sedih. Saya khawatir ini akan berdampak pada hubungan saya dengan bayi saya.',
      'isSender': false
    },
    {
      'chat':
          'Terima kasih telah berbagi, Sarah. Anda tidak sendirian dalam perasaan ini. Bagaimana jika kita mencoba menjelajahi perasaan dan pengalaman Anda lebih dalam?',
      'isSender': true
    },
    {
      'chat':
          'Terima kasih telah berbagi, Sarah. Anda tidak sendirian dalam perasaan ini. Bagaimana jika kita mencoba menjelajahi perasaan dan pengalaman Anda lebih dalam?',
      'isSender': true
    }
  ];
}
