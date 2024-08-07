import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easkripsi/controller/koorta_controller.dart';
import 'package:easkripsi/ui/pages/akun_page.dart';
import 'package:easkripsi/ui/pages/bimbingan_page.dart';
import 'package:easkripsi/ui/pages/koordinator%20ta/daftar_berkas_mahasiswa_page.dart';
import 'package:easkripsi/ui/pages/koordinator%20ta/pilih_seminar_mahasiswa_page.dart';
import 'package:easkripsi/ui/widgets/mahasiswa_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../controller/text_controller.dart';
import '../../../shared/theme.dart';
import '../../widgets/berkas_mahasiswa.dart';

class HomePageOperator extends StatefulWidget {
  const HomePageOperator({super.key});

  @override
  State<HomePageOperator> createState() => _HomePageOperatorState();
}

class _HomePageOperatorState extends State<HomePageOperator> {
  final TextController textController = Get.put(TextController());
  final KoortaController koortaController = Get.find<KoortaController>();
  final firestore = FirebaseFirestore.instance;
  final storage = new FlutterSecureStorage();
  Map<String, dynamic> userData = {};
  String collectedDosen = '';

  @override
  void initState() {
    super.initState();
    _readData().then((data) {
      setState(() {
        userData = data;
        textController.updateDosen(data['nimNip']);
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
    Widget header() {
      return Container(
        margin: const EdgeInsets.only(
          left: 24,
          right: 24,
          top: 30,
        ),
        child: Row(
          children: [
            Expanded(
              child: FutureBuilder<Map<String, dynamic>>(
                future: _readData(), // Read the data from secure storage
                builder: (BuildContext context,
                    AsyncSnapshot<Map<String, dynamic>> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error.toString()}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Show a loading spinner while waiting for the data
                  }

                  Map<String, dynamic> data = snapshot.data ?? {};
                  String dosenName = data['name'] ?? 'No name';
                  collectedDosen = dosenName;

                  return Container(
                    child: Text(
                      'Hello,\n$dosenName',
                      style: blackTextStyle.copyWith(
                        fontSize: 24,
                        fontWeight: semiBold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AkunPage()),
                );
              },
              child: Container(
                width: 45,
                height: 45,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/image_avatar.png'),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget bimbinganCard() {
      return Container(
        margin: const EdgeInsets.only(
          left: 24,
          right: 24,
          top: 23,
        ),
        width: 300,
        height: 170,
        decoration: BoxDecoration(
          color: kCardColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Text(
                        'Daftarkan akun\nmahasiswa dan\ndosen',
                        style: blackTextStyle.copyWith(
                          fontSize: 19,
                          fontWeight: semiBold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 25,
                  ),
                  height: 120,
                  width: 120,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/card_image.png'),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }

    Widget listPembimbing() {
      return Container(
        margin: const EdgeInsets.only(
          top: 30,
          left: 24,
          right: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daftar Akun',
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            //Daftar Akun Mahasiswa
            Container(
              margin: EdgeInsets.only(top: 10),
              child: ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      TextEditingController nimController =
                          TextEditingController();
                      TextEditingController nameController =
                          TextEditingController();
                      return AlertDialog(
                        title: Text('Daftar Akun Mahasiswa'),
                        content: SingleChildScrollView(
                          child: SizedBox(
                            height: 100, // Adjust the height as needed
                            child: Column(
                              children: <Widget>[
                                TextField(
                                  controller: nimController,
                                  decoration: InputDecoration(
                                    hintText: 'NIM',
                                  ),
                                ),
                                TextField(
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    hintText: 'Nama',
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                icon: Icon(
                  Icons.add,
                  color: Colors.blue,
                ),
                label: Text(
                  'Daftar Akun Mahasiswa',
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                ),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(
                      Size(double.infinity, 60)), // Adjust the size as needed
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  side: MaterialStateProperty.all<BorderSide>(
                    BorderSide(
                        color: Colors.blue,
                        width: 2), // Set the border color and width
                  ),
                  elevation:
                      MaterialStateProperty.all<double>(0), // Remove the shadow
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            //Daftar Akun Dosen
            Container(
              margin: EdgeInsets.only(top: 10),
              child: ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      TextEditingController nipController =
                          TextEditingController();
                      TextEditingController nameController =
                          TextEditingController();
                      return AlertDialog(
                        title: Text('Daftar Akun Dosen'),
                        content: SingleChildScrollView(
                          child: SizedBox(
                            height: 100, // Adjust the height as needed
                            child: Column(
                              children: <Widget>[
                                TextField(
                                  controller: nipController,
                                  decoration: InputDecoration(
                                    hintText: 'NIP',
                                  ),
                                ),
                                TextField(
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    hintText: 'Nama',
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                              String nip = nipController.text;
                              String name = nameController.text;

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
                                      content: Text('NIP sudah digunakan'),
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
                                  'nimNip': nip,
                                  'name':
                                      name, // Add 'nimNip' field with the value of 'nim'
                                  'password':
                                      nip, // Add 'password' field with the same value as 'nim'
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
                icon: Icon(
                  Icons.add,
                  color: Colors.blue,
                ),
                label: Text(
                  'Daftar Akun Dosen',
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                ),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(
                      Size(double.infinity, 60)), // Adjust the size as needed
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  side: MaterialStateProperty.all<BorderSide>(
                    BorderSide(
                        color: Colors.blue,
                        width: 2), // Set the border color and width
                  ),
                  elevation:
                      MaterialStateProperty.all<double>(0), // Remove the shadow
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBGColor2,
      body: SafeArea(
        child: ListView(
          children: [
            header(),
            bimbinganCard(),
            listPembimbing(),
          ],
        ),
      ),
    );
  }
}
