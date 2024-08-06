import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easkripsi/ui/pages/chat_room_page.dart';
import 'package:easkripsi/ui/pages/dosen/chat_room_page_dosen.dart';
import 'package:get/get.dart';

// import '../../../routes/app_pages.dart';

class BimbinganDosenController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> dataChatDosen() {
    return firestore.collection('Dosen').snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> friendStream(String email) {
    return firestore.collection('users').doc(email).snapshots();
  }

  void goToChatRoom(String chatId, String mahasiswaName, String nimNip,
      String nipDosen) async {
    CollectionReference chats = firestore.collection('chats');
    CollectionReference Dosen = firestore.collection('Dosen');

    final updateStatusChat = await chats
        .doc(chatId)
        .collection("chat")
        .where("isRead", isEqualTo: false)
        .where("penerima", isEqualTo: nipDosen)
        .get();

    updateStatusChat.docs.forEach((element) async {
      await chats
          .doc(chatId)
          .collection("chat")
          .doc(element.id)
          .update({"isRead": true});
    });

    QuerySnapshot dosenSnapshot = await firestore
        .collection('Dosen')
        .where('nimNip', isEqualTo: nipDosen)
        .get();

    await Dosen.doc(dosenSnapshot.docs[0].id)
        .collection("chats")
        .doc(chatId)
        .update({"total_unread": 0});

    Get.to(() => ChatRoomPageDosen(
          chatId: chatId,
          chatName: mahasiswaName,
          nimMahasiswa: nimNip,
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
