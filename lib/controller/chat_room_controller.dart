import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatRoomController extends GetxController {
  var isShowEmoji = false.obs;
  int total_unread = 0;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late FocusNode focusNode;
  late TextEditingController chatC;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamChats(String chatId) {
    CollectionReference chats = firestore.collection("chats");
    return firestore
        .collection("chats")
        .doc(chatId)
        .collection("chat")
        .orderBy("time", descending: false)
        .snapshots();
  }

  void addEmojiToChat(Emoji emoji) {
    chatC.text = chatC.text + emoji.emoji;
  }

  void deleteEmoji() {
    chatC.text = chatC.text.substring(0, chatC.text.length - 2);
  }

  void newChat(
      String nimNip, String nipDosen, String chatId, String chat) async {
    CollectionReference chats = firestore.collection("chats");
    CollectionReference Mahasiswa = firestore.collection("Mahasiswa");
    CollectionReference Dosen = firestore.collection("Dosen");

    String date = DateTime.now().toString();

    await chats.doc(chatId).collection("chat").add({
      "pengirim": nimNip,
      "penerima": nipDosen,
      "msg": chat,
      "time": date,
      "isRead": false,
    });

    QuerySnapshot mahasiswaSnapshot = await firestore
        .collection('Mahasiswa')
        .where('nimNip', isEqualTo: nimNip)
        .get();

    await Mahasiswa.doc(mahasiswaSnapshot.docs[0].id)
        .collection("chats")
        .doc(chatId)
        .update({
      "lastTime": date,
      "last_chat": chat,
    });

    QuerySnapshot dosenSnapshot = await firestore
        .collection('Dosen')
        .where('nimNip', isEqualTo: nipDosen)
        .get();

    final checkChatsDosen = await Dosen.doc(dosenSnapshot.docs[0].id)
        .collection("chats")
        .doc(chatId)
        .get();

    if (checkChatsDosen.exists) {
      final checkTotalUnread = await chats
          .doc(chatId)
          .collection("chat")
          .where("isRead", isEqualTo: false)
          .where("pengirim", isEqualTo: nimNip)
          .get();

      //total unread for dosen
      total_unread = checkTotalUnread.docs.length;

      //update for dosen
      await Dosen.doc(dosenSnapshot.docs[0].id)
          .collection("chats")
          .doc(chatId)
          .update({
        "lastTime": date,
        "total_unread": total_unread,
        "last_chat": chat,
      });
      print(chatId);
    } else {
      //new for dosen
      await Dosen.doc(dosenSnapshot.docs[0].id)
          .collection("chats")
          .doc(chatId)
          .set({
        "connection": nimNip,
        "lastTime": date,
        "total_unread": total_unread,
        "last_chat": chat,
      });
    }
    chatC.clear();
  }

  @override
  void onInit() {
    chatC = TextEditingController();
    focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        isShowEmoji.value = false;
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    chatC.dispose();
    focusNode.dispose();
    super.onClose();
  }
}
