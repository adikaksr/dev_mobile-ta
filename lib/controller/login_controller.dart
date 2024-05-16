import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginController {
  // Future<String> login(String nimNip, String password, String role) async {
  //   // Load the JSON file
  //   String jsonString = await rootBundle.loadString('assets/login.json');

  //   // Decode the JSON data
  //   Map<String, dynamic> jsonData = jsonDecode(jsonString);

  //   // Check if the provided NIM/NIP and password match any user
  //   for (var user in jsonData['users']) {
  //     if (user['nimNip'] == nimNip &&
  //         user['password'] == password &&
  //         user['role'] == role) {
  //       return user['role'];
  //     }
  //   }

  //   // If no match is found, throw an exception
  //   Get.snackbar('Error', 'Failed to login');
  //   throw Exception('Failed to login');
  // }
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<bool> login(String nimNip, String password, String role) async {
    try {
      // final docSnapshot = await _firestore.collection(role).doc('nimNip').get();
      final docSnapshot = await _firestore
          .collection(role)
          .where('nimNip', isEqualTo: nimNip)
          .where('password', isEqualTo: password);

      Future<bool> checkDataExists() {
        return docSnapshot.get().then((QuerySnapshot querySnapshot) {
          for (var doc in querySnapshot.docs) {
            final data = doc.data() as Map<String, dynamic>;
            if (data.isNotEmpty) {
              return true;
            }
          }
          return false;
        });
      }

      return checkDataExists();

      // print('nim' + nimNip);
      // print('password' + password);
      // print(docSnapshot);
      // print(role);

      // if (docSnapshot.exists) {
      //   final data = docSnapshot.data() as Map<String, dynamic>;
      //   // if (data['password'] == password) {
      //   //   // Passwords match, return the user's role
      //   //   return data['role'];
      //   // } else {
      //   //   // Passwords don't match
      //   //   print('Wrong password provided for that user.');
      //   //   return '';
      //   // }

      // return '';
      // } else {
      //   // User not found
      //   print('No user found for that nip.');
      //   return '';
      // }
    } catch (e) {
      // Handle any errors
      print(e);
      return false;
    }
  }

  Future<void> logout() async {
    // Since your login system doesn't seem to involve any kind of session or
    // token management, this method might not need to do anything.

    // If you add session or token management in the future, you would clear
    // the session or token here.
  }
}
