// import 'dart:async';
// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';

// class ChatRoomDosenController extends GetxController {
//   var isShowEmoji = false.obs;
//   int total_unread = 0;

//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   FirebaseStorage storage = FirebaseStorage.instance;

//   late FocusNode focusNode;
//   late TextEditingController chatC;
//   late ScrollController scrollC;

//   XFile? pickedFile = null;

//   Stream<QuerySnapshot<Map<String, dynamic>>> streamChats(String chatId) {
//     CollectionReference chats = firestore.collection("chats");
//     return firestore
//         .collection("chats")
//         .doc(chatId)
//         .collection("chat")
//         .orderBy("time", descending: false)
//         .snapshots();
//   }

//   void addEmojiToChat(Emoji emoji) {
//     chatC.text = chatC.text + emoji.emoji;
//   }

//   void deleteEmoji() {
//     chatC.text = chatC.text.substring(0, chatC.text.length - 2);
//   }

//   // void uploadImage() async {
//   //   Reference storageRef = storage.ref();
//   //   File file = File(pickedFile!.path);

//   //   try {
//   //     final dataUpload = await storageRef.putFile(file);
//   //   } catch (e) {
//   //     print(e);
//   //   }
//   // }
//   Future<void> uploadImage(
//       String chatId, String nimNip, String nipDosen) async {
//     if (pickedFile == null) {
//       print("No file selected");
//       return;
//     }

//     File file = File(pickedFile!.path);
//     String fileName =
//         DateTime.now().millisecondsSinceEpoch.toString() + "_" + nimNip;
//     String filePath = 'chat_images/$chatId/$fileName';

//     try {
//       // Upload file to Firebase Storage
//       Reference storageRef = storage.ref().child(filePath);
//       UploadTask uploadTask = storageRef.putFile(file);
//       TaskSnapshot taskSnapshot = await uploadTask;

//       // Get download URL
//       String downloadURL = await taskSnapshot.ref.getDownloadURL();

//       // Save file metadata in the chat room on Firestore
//       String date = DateTime.now().toIso8601String();
//       CollectionReference chats = firestore.collection("chats");
//       // CollectionReference Mahasiswa = firestore.collection("Mahasiswa");
//       // CollectionReference Dosen = firestore.collection("Dosen");

//       await chats.doc(chatId).collection("chat").add({
//         "pengirim": nimNip,
//         "penerima": nipDosen,
//         "imageUrl": downloadURL,
//         "time": date,
//         "isRead": false,
//         "type": "image", // Indicate this is an image message
//         "groupTime": DateFormat.yMMMMd('en_US').format(DateTime.parse(date)),
//       });

//       // Optionally, update last message info for chat overview
//       // This step depends on your app's specific requirements

//       print("Image uploaded and metadata saved to Firestore");
//     } catch (e) {
//       print(e);
//     }
//   }

//   void newChat(
//       String nimMahasiswa, String nimNip, String chatId, String chat) async {
//     if (chat != "") {
//       CollectionReference chats = firestore.collection("chats");
//       CollectionReference Mahasiswa = firestore.collection("Mahasiswa");
//       CollectionReference Dosen = firestore.collection("Dosen");

//       String date = DateTime.now().toIso8601String();

//       await chats.doc(chatId).collection("chat").add({
//         "pengirim": nimNip,
//         "penerima": nimMahasiswa,
//         "msg": chat,
//         "time": date,
//         "isRead": false,
//         "groupTime": DateFormat.yMMMMd('en_US').format(DateTime.parse(date)),
//       });

//       Timer(
//         Duration.zero,
//         () => scrollC.jumpTo(scrollC.position.maxScrollExtent),
//       );

//       chatC.clear();

//       QuerySnapshot dosenSnapshot = await firestore
//           .collection('Dosen')
//           .where('nimNip', isEqualTo: nimNip)
//           .get();

//       await Dosen.doc(dosenSnapshot.docs[0].id)
//           .collection("chats")
//           .doc(chatId)
//           .update({
//         "lastTime": date,
//         "last_chat": chat,
//       });

//       QuerySnapshot mahasiswaSnapshot = await firestore
//           .collection('Mahasiswa')
//           .where('nimNip', isEqualTo: nimMahasiswa)
//           .get();

//       final checkChatsMahasiswa = await Dosen.doc(mahasiswaSnapshot.docs[0].id)
//           .collection("chats")
//           .doc(chatId)
//           .get();

//       if (checkChatsMahasiswa.exists) {
//         final checkTotalUnread = await chats
//             .doc(chatId)
//             .collection("chat")
//             .where("isRead", isEqualTo: false)
//             .where("pengirim", isEqualTo: nimMahasiswa)
//             .get();

//         //total unread for mahasiswa
//         total_unread = checkTotalUnread.docs.length;

//         //update for mahasiswa
//         await Mahasiswa.doc(mahasiswaSnapshot.docs[0].id)
//             .collection("chats")
//             .doc(chatId)
//             .update({
//           "lastTime": date,
//           "total_unread": total_unread,
//           "last_chat": chat,
//         });
//         print(chatId);
//       } else {
//         //new for mahasiswa
//         await Mahasiswa.doc(mahasiswaSnapshot.docs[0].id)
//             .collection("chats")
//             .doc(chatId)
//             .set({
//           "connection": nimNip,
//           "lastTime": date,
//           "total_unread": total_unread,
//           "last_chat": chat,
//         });
//       }
//     }
//   }

//   @override
//   void onInit() {
//     chatC = TextEditingController();
//     scrollC = ScrollController();
//     focusNode = FocusNode();
//     focusNode.addListener(() {
//       if (focusNode.hasFocus) {
//         isShowEmoji.value = false;
//       }
//     });
//     super.onInit();
//   }

//   @override
//   void onClose() {
//     chatC.dispose();
//     scrollC.dispose();
//     focusNode.dispose();
//     super.onClose();
//   }
// }
