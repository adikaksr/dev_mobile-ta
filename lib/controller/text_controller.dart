import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextController extends GetxController {
  //Define the variables RXString
  var nipDospem1 = ''.obs;
  var nipDospem2 = ''.obs;
  var nimMahasiswa = ''.obs;

  // Function to update the value of myData
  void updateData(String collectedNim) {
    nimMahasiswa.value = collectedNim;
  }
}
