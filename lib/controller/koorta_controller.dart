import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class KoortaController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getMahasiswa() async {
    CollectionReference<Map<String, dynamic>> mahasiswa =
        firestore.collection("Mahasiswa");

    QuerySnapshot<Map<String, dynamic>> mahasiswaSnapshot =
        await mahasiswa.get();
    List<Map<String, dynamic>> mahasiswaWithBerkas = [];

    for (var doc in mahasiswaSnapshot.docs) {
      QuerySnapshot<Map<String, dynamic>> berkasSnapshot = await firestore
          .collection("Mahasiswa")
          .doc(doc.id)
          .collection('berkas')
          .get();

      // berkas.add(doc);
      // if (berkasSnapshot.docs.isNotEmpty) {
      //   var dataMahasiswa = doc.data();
      //   var dataBerkas =
      //       berkasSnapshot.docs.map((berkasDoc) => berkasDoc.data()).toList();

      //   // Combine dataDoc and dataBeras into one variable
      //   var combinedData = {
      //     ...dataMahasiswa,
      //     'berkas': dataBerkas,
      //   };

      //   mahasiswaWithBerkas.add(combinedData);
      // }
      if (berkasSnapshot.docs.isNotEmpty) {
        var dataMahasiswa = doc.data();
        var dataBerkas = berkasSnapshot.docs.map((berkasDoc) {
          var berkasData = berkasDoc.data();
          berkasData['id'] = berkasDoc.id; // Add document ID to the data
          return berkasData;
        }).toList();

        var combinedData = {
          ...dataMahasiswa,
          'berkas': dataBerkas,
        };

        mahasiswaWithBerkas.add(combinedData);
      }
    }

    return mahasiswaWithBerkas;
  }
}
