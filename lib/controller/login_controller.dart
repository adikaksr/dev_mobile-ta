import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginController {
  final storage = new FlutterSecureStorage();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<bool> login(String nimNip, String password, String role) async {
    try {
      // final docSnapshot = await _firestore.collection(role).doc('nimNip').get();
      final docSnapshot = await _firestore
          .collection(role)
          .where('nimNip', isEqualTo: nimNip)
          .where('password', isEqualTo: password);

      Future<bool> checkDataExists() {
        return docSnapshot.get().then((QuerySnapshot querySnapshot) async {
          for (var doc in querySnapshot.docs) {
            final data = doc.data() as Map<String, dynamic>;
            if (data.isNotEmpty) {
              String jsonData = jsonEncode(data); // Convert data to JSON string
              await storage.write(key: 'user', value: jsonData);
              return true;
            }
          }
          return false;
        });
      }

      return checkDataExists();
    } catch (e) {
      // Handle any errors
      print(e);
      return false;
    }
  }

  Future<void> logout() async {
    await storage.delete(key: 'user');
  }
}
