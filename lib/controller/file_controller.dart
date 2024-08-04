import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easkripsi/controller/text_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:get/get.dart';

class FileController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final textController = Get.find<TextController>();
  var fileName = ''.obs;
  var downloadUrl = ''.obs;

  // var displayName = ''.obs;

  void uploadFile(String fileType, RxString name) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    CollectionReference Mahasiswa = firestore.collection("Mahasiswa");

    if (result != null) {
      File file = File(result.files.single.path!);

      fileName.value = result.files.single.name;

      try {
        final storageRef = firebase_storage.FirebaseStorage.instance
            .ref('uploads/$fileType/${fileName.value}');
        // Upload the file
        await storageRef.putFile(file);
        name.value = fileName.value;

        // Get the download URL
        final url = await storageRef.getDownloadURL();
        downloadUrl.value = url;

        QuerySnapshot mahasiswaSnapshot = await firestore
            .collection('Mahasiswa')
            .where('nimNip', isEqualTo: textController.nimMahasiswa.value)
            .get();

        String customDocId = fileType; // Replace with your custom logic

        await firestore
            .collection('Mahasiswa')
            .doc(mahasiswaSnapshot.docs[0].id)
            .collection("berkas")
            .doc(customDocId)
            .set({
          'fileName': fileName.value,
          'downloadUrl': downloadUrl.value,
        });

        print('File uploaded successfully. Download URL: $url');
      } on firebase_storage.FirebaseStorage catch (e) {
        print(e);
      }
    } else {
      // User canceled the picker
    }
  }

  void storeData() {
    // Store data to firestore
  }
}
