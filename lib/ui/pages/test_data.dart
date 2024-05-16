import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TestDataPage extends StatefulWidget {
  @override
  _TestDataPageState createState() => _TestDataPageState();
}

class _TestDataPageState extends State<TestDataPage> {
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Data Page'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('tes').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error.toString()}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          // New code to print the documents
          snapshot.data!.docs.forEach((doc) {
            print(doc.data());
          });

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return ListTile(
                title: Text(data['opet']),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
