import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easkripsi/ui/pages/chat_room_page.dart';
import 'package:get/get.dart';

// import '../../../routes/app_pages.dart';

class BimbinganController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> dataChatDosen() {
    return firestore.collection('Dosen').snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> friendStream(String email) {
    return firestore.collection('users').doc(email).snapshots();
  }

  void goToChatRoom(
      String chatId, String dosenName, String nimNip, String nipDosen) async {
    CollectionReference chats = firestore.collection('chats');
    CollectionReference Mahasiswa = firestore.collection('Mahasiswa');

    final updateStatusChat = await chats
        .doc(chatId)
        .collection("chat")
        .where("isRead", isEqualTo: false)
        .where("penerima", isEqualTo: nimNip)
        .get();

    updateStatusChat.docs.forEach((element) async {
      await chats
          .doc(chatId)
          .collection("chat")
          .doc(element.id)
          .update({"isRead": true});
    });

    QuerySnapshot mahasiswaSnapshot = await firestore
        .collection('Mahasiswa')
        .where('nimNip', isEqualTo: nimNip)
        .get();

    await Mahasiswa.doc(mahasiswaSnapshot.docs[0].id)
        .collection("chats")
        .doc(chatId)
        .update({"total_unread": 0});

    Get.to(() => ChatRoomPage(
          chatId: chatId,
          chatName: dosenName,
          nipDosen: nipDosen,
        ));

    //   // Get.toNamed(
    //   //   Routes.CHAT_ROOM,
    //   //   arguments: {
    //   //     "chatId": chatId,
    //   //     "friendEmail": friendEmail,
    //   //   },
    //   // );
  }
}
