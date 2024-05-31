import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OperatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Operator Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Welcome, Operator!'),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: ElevatedButton(
                child: Text('Create Mahasiswa Account'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      TextEditingController nimController =
                          TextEditingController();
                      TextEditingController nameController =
                          TextEditingController();
                      return AlertDialog(
                        title: Text('Create Mahasiswa Account'),
                        content: Column(
                          children: <Widget>[
                            Text('Please enter the NIM:'),
                            TextField(
                              controller: nimController,
                              decoration: InputDecoration(
                                hintText: 'NIM',
                              ),
                            ),
                            TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                hintText: 'name',
                              ),
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Submit'),
                            onPressed: () async {
                              String nim = nimController.text;
                              String name = nameController.text;

                              // Check if a document with the specified 'nimNip' already exists
                              var query = await FirebaseFirestore.instance
                                  .collection('Mahasiswa')
                                  .where('nimNip', isEqualTo: nim)
                                  .get();

                              if (query.docs.isNotEmpty) {
                                // If the query returns any documents, show a popup
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Error'),
                                      content: Text('Nim sudah digunakan'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('OK'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                // If the query doesn't return any documents, add a new document
                                await FirebaseFirestore.instance
                                    .collection('Mahasiswa')
                                    .add({
                                  'nimNip': nim,
                                  'name':
                                      name, // Add 'nimNip' field with the value of 'nim'
                                  'password':
                                      nim, // Add 'password' field with the same value as 'nim'
                                });

                                // Use Future.delayed to delay the showing of the dialog
                                await Future.delayed(Duration.zero);

                                // Show a popup indicating success
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Success'),
                                      content: Text('Akun berhasil dibuat'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('OK'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            if (Navigator.canPop(context)) {
                                              Navigator.of(context).pop();
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: ElevatedButton(
                child: Text('Create Dosen Account'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      TextEditingController nipController =
                          TextEditingController();
                      return AlertDialog(
                        title: Text('Create Dosen Account'),
                        content: Column(
                          children: <Widget>[
                            Text('Please enter the NIP:'),
                            TextField(
                              controller: nipController,
                              decoration: InputDecoration(
                                hintText: 'NIP',
                              ),
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Submit'),
                            onPressed: () async {
                              String nip = nipController.text;

                              // Check if a document with the specified 'nimNip' already exists
                              var query = await FirebaseFirestore.instance
                                  .collection('Dosen')
                                  .where('nimNip', isEqualTo: nip)
                                  .get();

                              if (query.docs.isNotEmpty) {
                                // If the query returns any documents, show a popup
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Error'),
                                      content: Text('Nim sudah digunakan'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('OK'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                // If the query doesn't return any documents, add a new document
                                await FirebaseFirestore.instance
                                    .collection('Dosen')
                                    .add({
                                  'nimNip':
                                      nip, // Add 'nimNip' field with the value of 'nip'
                                  'password':
                                      nip, // Add 'password' field with the same value as 'nip'
                                });

                                // Use Future.delayed to delay the showing of the dialog
                                await Future.delayed(Duration.zero);

                                // Show a popup indicating success
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Success'),
                                      content: Text('Akun berhasil dibuat'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('OK'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            if (Navigator.canPop(context)) {
                                              Navigator.of(context).pop();
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
