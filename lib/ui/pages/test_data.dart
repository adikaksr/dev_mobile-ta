import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class TestDataPage extends StatefulWidget {
  @override
  _TestDataPageState createState() => _TestDataPageState();
}

class _TestDataPageState extends State<TestDataPage> {
  final firestore = FirebaseFirestore.instance;
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _storeData();
  }

  Future<void> _storeData() async {
    final snapshots = await firestore
        .collection('Mahasiswa')
        .where('nimNip', isEqualTo: '1808107010056');
    snapshots.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        final data = doc.data() as Map<String, dynamic>; // Get data from doc
        String jsonData = jsonEncode(data); // Convert data to JSON string
        await storage.write(key: 'user', value: jsonData);
      });
    });
  }

  Future<Map<String, dynamic>> _readData() async {
    String value = await storage.read(key: 'user') ?? '{}';
    try {
      Map<String, dynamic> data = jsonDecode(value);
      return data;
    } catch (e) {
      print('Error parsing JSON: $e');
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Data Page'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _readData(),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error.toString()}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Show a loading spinner while waiting for the data
          }

          Map<String, dynamic> data = snapshot.data ?? {};
          String name = data['name'] ?? 'No name';
          String password = data['password'] ?? 'No password';
          String nimNip = data['nimNip'] ?? 'No nimNip';

          return Text('Name: $name\nPassword: $password\nNimNip: $nimNip');
        },
      ),
    );
  }
}
