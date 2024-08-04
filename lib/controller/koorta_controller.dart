import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class KoortaController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Future<DocumentSnapshot<Map<String, dynamic>>> getMahasiswa() async {
  //   CollectionReference mahasiswa = firestore.collection("Mahasiswa");
  //   late String mahasiswaID;

  //   QuerySnapshot mahasiswaSnapshot = await mahasiswa.get();

  //   for (var doc in mahasiswaSnapshot.docs) {
  //     QuerySnapshot berkasSnapshot = await firestore
  //         .collection("Mahasiswa")
  //         .doc(doc.id)
  //         .collection('berkas')
  //         .get();

  //     // for (var berkasDoc in berkasSnapshot.docs) {
  //     //   print(berkasDoc.data());
  //     // }
  //     // print('Ini FILENYA : ${berkasSnapshot.docs.length}');

  //     if (berkasSnapshot.docs.isNotEmpty) {
  //       // print('Mahasiswa ID: ${doc.id}');
  //       // print('Ini FILENYA : ${berkasSnapshot.docs.length}');
  //       mahasiswaID = doc.id;
  //       for (var berkasDoc in berkasSnapshot.docs) {
  //         // print('Berkas ID: ${berkasDoc.id}');
  //         // print(berkasDoc.data());
  //       }
  //     }
  //   }
  //   final Future<DocumentSnapshot<Map<String, dynamic>>> getBerkasMahasiswa =
  //       firestore.collection("Mahasiswa").doc(mahasiswaID).get();

  //   return getBerkasMahasiswa;

  //   // mahasiswaSnapshot.docs.forEach((element) {
  //   //   print(element.data());
  //   // });
  // }
  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getMahasiswa() async {
    CollectionReference<Map<String, dynamic>> mahasiswa =
        firestore.collection("Mahasiswa");

    QuerySnapshot<Map<String, dynamic>> mahasiswaSnapshot =
        await mahasiswa.get();
    List<DocumentSnapshot<Map<String, dynamic>>> mahasiswaWithBerkas = [];

    for (var doc in mahasiswaSnapshot.docs) {
      QuerySnapshot<Map<String, dynamic>> berkasSnapshot = await firestore
          .collection("Mahasiswa")
          .doc(doc.id)
          .collection('berkas')
          .get();

      if (berkasSnapshot.docs.isNotEmpty) {
        mahasiswaWithBerkas.add(doc);
      }
    }
    print(mahasiswaWithBerkas);
    return mahasiswaWithBerkas;
  }
}
