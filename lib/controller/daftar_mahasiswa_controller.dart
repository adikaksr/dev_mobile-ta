import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class DaftarMahasiswaController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> getMahasiswa(
    String nipDosen,
  ) async {
    CollectionReference dosen = firestore.collection('Dosen');

    QuerySnapshot dosenSnapshot = await firestore
        .collection('Dosen')
        .where('nimNip', isEqualTo: nipDosen)
        .get();

    var chatMahasiswa =
        await dosen.doc(dosenSnapshot.docs[0].id).collection("chats").get();

    // return chatMahasiswa.docs.map((e) => e.data()).toList();
    return chatMahasiswa;
  }
}
