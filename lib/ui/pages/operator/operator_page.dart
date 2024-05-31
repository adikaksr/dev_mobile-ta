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
                      TextEditingController nipController =
                          TextEditingController();
                      return AlertDialog(
                        title: Text('Create Mahasiswa Account'),
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
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Submit'),
                            onPressed: () {
                              String nip = nipController.text;
                              Navigator.of(context).pop();
                              // Pass the NIP to the next page
                              Navigator.of(context).pushNamed(
                                  '/create-mahasiswa-account',
                                  arguments: nip);
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
                child: Text('Create Mahasiswa Account'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      TextEditingController nipController =
                          TextEditingController();
                      return AlertDialog(
                        title: Text('Create Mahasiswa Account'),
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
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Submit'),
                            onPressed: () {
                              String nip = nipController.text;
                              Navigator.of(context).pop();
                              // Pass the NIP to the next page
                              Navigator.of(context).pushNamed(
                                  '/create-mahasiswa-account',
                                  arguments: nip);
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
