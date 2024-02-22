import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginController {
  Future<String> login(String nimNip, String password, String role) async {
    // Load the JSON file
    String jsonString = await rootBundle.loadString('assets/login.json');

    // Decode the JSON data
    Map<String, dynamic> jsonData = jsonDecode(jsonString);

    // Check if the provided NIM/NIP and password match any user
    for (var user in jsonData['users']) {
      if (user['nimNip'] == nimNip &&
          user['password'] == password &&
          user['role'] == role) {
        return user['role'];
      }
    }

    // If no match is found, throw an exception
    Get.snackbar('Error', 'Failed to login');
    throw Exception('Failed to login');
  }

  Future<void> logout() async {
    // Since your login system doesn't seem to involve any kind of session or
    // token management, this method might not need to do anything.

    // If you add session or token management in the future, you would clear
    // the session or token here.
  }
}
