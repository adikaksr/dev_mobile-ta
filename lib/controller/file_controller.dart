import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:get/get.dart';

class FileController extends GetxController {
  var fileName = ''.obs;
  // var displayName = ''.obs;

  void uploadFile(String fileType, RxString name) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);

      fileName.value = result.files.single.name;

      try {
        await firebase_storage.FirebaseStorage.instance
            .ref('uploads/$fileType/${fileName.value}')
            .putFile(file);
        name.value = fileName.value;
        print(fileName);
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
