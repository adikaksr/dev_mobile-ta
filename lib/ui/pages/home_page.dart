import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easkripsi/controller/text_controller.dart';
import 'package:easkripsi/ui/pages/akun_page.dart';
import 'package:easkripsi/ui/pages/bimbingan_page.dart';
import 'package:easkripsi/ui/widgets/dosen_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import '../../shared/theme.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class Dosen {
  final String nimNip;
  final String name;

  Dosen({
    required this.nimNip,
    required this.name,
  });
}

class _HomePageState extends State<HomePage> {
  final TextController textController = Get.put(TextController());
  Dosen? currentDosen;
  Dosen? currentDosen2;
  final firestore = FirebaseFirestore.instance;
  final storage = new FlutterSecureStorage();
  Map<String, dynamic> userData = {};

  @override
  void initState() {
    super.initState();
    _readData().then((data) {
      _readDospem1(data['nimNip']).then((data) {
        print(data['nimNip']);
        setState(() {
          if (data.isNotEmpty) {
            currentDosen = Dosen(
              nimNip: data['nimNip'],
              name: data['name'],
            );
          }
        });
      });
      _readDospem2(data['nimNip']).then((data) {
        print(data['nimNip']);
        setState(() {
          if (data.isNotEmpty) {
            currentDosen2 = Dosen(
              nimNip: data['nimNip'],
              name: data['name'],
            );
          }
        });
      });
      setState(() {
        userData = data;
        textController.updateData(data['nimNip']);
      });
    });
  }

  Future<Map<String, dynamic>> _readDospem1(String mahasiswaNim) async {
    QuerySnapshot querySnapshot = await firestore
        .collection('Mahasiswa')
        .where('nimNip', isEqualTo: mahasiswaNim)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot doc = querySnapshot.docs.first;
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      if (data.containsKey('dospem_1')) {
        return data['dospem_1'] as Map<String, dynamic>;
      } else {
        print('dospem_1 does not exist');
        return {};
      }
    } else {
      print('Document does not exist');
      return {};
    }
  }

  Future<Map<String, dynamic>> _readDospem2(String mahasiswaNim) async {
    QuerySnapshot querySnapshot = await firestore
        .collection('Mahasiswa')
        .where('nimNip', isEqualTo: mahasiswaNim)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot doc = querySnapshot.docs.first;
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      if (data.containsKey('dospem_2')) {
        return data['dospem_2'] as Map<String, dynamic>;
      } else {
        print('dospem_2 does not exist');
        return {};
      }
    } else {
      print('Document does not exist');
      return {};
    }
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

  void getDosen(String nimNip) async {
    // Fetch the dosen data using the nip...
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
                  String mahasiswaName = data['name'] ?? 'No name';

                  return Container(
                    child: Text(
                      'Hello,\n$mahasiswaName',
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
                        'Siap selesaikan\nskripsimu?',
                        style: blackTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: semiBold,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 25),
                        width: 150,
                        height: 38,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BimbinganPage()),
                            );
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: kWhiteColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                          child: Text(
                            'Mulai Bimbingan',
                            style: blueTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: semiBold,
                            ),
                          ),
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
              'Dosen Pembimbing',
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
            currentDosen == null
                ? Container(
                    margin: EdgeInsets.only(top: 16),
                    height: 70,
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: Colors.blue, // Set border color
                        width: 2, // Set border width
                      ),
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            String nimNip = '';
                            return AlertDialog(
                              title: Text('Masukkan NIP'),
                              content: TextFormField(
                                decoration: InputDecoration(labelText: 'NIP'),
                                onChanged: (value) {
                                  nimNip = value;
                                  print(nimNip);
                                },
                              ),
                              actions: [
                                TextButton(
                                  child: Text('Cancel'),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    final query = firestore
                                        .collection('Dosen')
                                        .where('nimNip', isEqualTo: nimNip);
                                    query
                                        .get()
                                        .then((QuerySnapshot querySnapshot) {
                                      querySnapshot.docs.forEach((doc) {
                                        final data = doc.data() as Map<String,
                                            dynamic>; // Get data from doc
                                        setState(() {
                                          currentDosen = Dosen(
                                            nimNip: data['nimNip'],
                                            name: data['name'],
                                          );
                                        });

                                        // Get the currently logged in Mahasiswa's nim
                                        final mahasiswaNim =
                                            userData['nimNip'] ?? 'Unknown Nim';

                                        print('mahasiswaNim' + mahasiswaNim);

                                        firestore
                                            .collection('Mahasiswa')
                                            .where('nimNip',
                                                isEqualTo: mahasiswaNim)
                                            .get()
                                            .then(
                                                (QuerySnapshot querySnapshot) {
                                          querySnapshot.docs.forEach((doc) {
                                            doc.reference.update({
                                              'dospem_1': {
                                                'name': data['name'],
                                                'nimNip': data['nimNip'],
                                                'status': false,
                                              },
                                              // Update other fields as needed
                                            }).then((_) {
                                              print("Dosen Pembimbing Updated");
                                            }).catchError((error) {
                                              print(
                                                  "Failed to update Dosen Pembimbing: $error");
                                            });

                                            final dosenId =
                                                doc.id; // Store the document ID

                                            // Create a new chat document with the mahasiswa and dosen as participants
                                            firestore.collection('chats').add({
                                              'connections': [
                                                mahasiswaNim,
                                                data['nimNip']
                                              ],
                                            }).then((docRef) {
                                              print(
                                                  "Chat created with ID: ${docRef.id}");

                                              // Create a new chat document in the 'chats' subcollection of the Mahasiswa document
                                              doc.reference
                                                  .collection('chats')
                                                  .doc(docRef.id)
                                                  .set({
                                                'connection': data['nimNip'],
                                                'lastTime': DateTime.now()
                                                    .toIso8601String(),
                                                'total_unread': 0,
                                              }).then((_) {
                                                print(
                                                    "Chat created in Mahasiswa's chats with ID: ${docRef.id}");
                                              }).catchError((error) {
                                                print(
                                                    "Failed to create chat in Mahasiswa's chats: $error");
                                              });

                                              // // Create a new chat document in the 'chats' subcollection of the Dosen document
                                              firestore
                                                  .collection('Dosen')
                                                  .where('nimNip',
                                                      isEqualTo: data['nimNip'])
                                                  .get()
                                                  .then((QuerySnapshot
                                                      querySnapshot) {
                                                querySnapshot.docs
                                                    .forEach((dosenDoc) {
                                                  // Create a new chat document in the 'chats' subcollection of the Dosen document
                                                  dosenDoc.reference
                                                      .collection('chats')
                                                      .doc(docRef.id)
                                                      .set({
                                                    'connection':
                                                        mahasiswaNim, // Store the Mahasiswa's nim
                                                    'lastTime': DateTime.now()
                                                        .toIso8601String(),
                                                    'total_unread': 0,
                                                  }).then((_) {
                                                    print(
                                                        "Chat created in Dosen's chats with ID: ${docRef.id}");
                                                  }).catchError((error) {
                                                    print(
                                                        "Failed to create chat in Dosen's chats: $error");
                                                  });
                                                });
                                              }).catchError((error) {
                                                print(
                                                    "Failed to find Dosen: $error");
                                              });
                                            }).catchError((error) {
                                              print(
                                                  "Failed to create chat: $error");
                                            });
                                          });
                                        }).catchError((error) {
                                          print(error);
                                        });
                                      });
                                    }).catchError((error) {
                                      print(error);
                                    });
                                    Navigator.of(context).pop();
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
                        'Tambah Dosen Pembimbing 1',
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: medium,
                        ),
                      ),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        elevation: MaterialStateProperty.all(0),
                      ),
                    ),
                  )
                : DosenTile(
                    nip: currentDosen!.nimNip,
                    name: currentDosen!.name,
                    status: 'Pembimbing 1',
                    imageUrl: 'assets/Acatar.png',
                  ),

            // DOSPEM 2
            currentDosen2 == null
                ? Container(
                    margin: EdgeInsets.only(top: 16),
                    height: 70,
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: Colors.blue, // Set border color
                        width: 2, // Set border width
                      ),
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            String nimNip = '';
                            return AlertDialog(
                              title: Text('Masukkan NIP'),
                              content: TextFormField(
                                decoration: InputDecoration(labelText: 'NIP'),
                                onChanged: (value) {
                                  nimNip = value;
                                  print(nimNip);
                                },
                              ),
                              actions: [
                                TextButton(
                                  child: Text('Cancel'),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    final query = firestore
                                        .collection('Dosen')
                                        .where('nimNip', isEqualTo: nimNip);
                                    query
                                        .get()
                                        .then((QuerySnapshot querySnapshot) {
                                      querySnapshot.docs.forEach((doc) {
                                        final data = doc.data() as Map<String,
                                            dynamic>; // Get data from doc
                                        setState(() {
                                          currentDosen2 = Dosen(
                                            nimNip: data['nimNip'],
                                            name: data['name'],
                                          );
                                        });

                                        // Get the currently logged in Mahasiswa's nim
                                        final mahasiswaNim =
                                            userData['nimNip'] ?? 'Unknown Nim';

                                        print('mahasiswaNim' + mahasiswaNim);

                                        firestore
                                            .collection('Mahasiswa')
                                            .where('nimNip',
                                                isEqualTo: mahasiswaNim)
                                            .get()
                                            .then(
                                                (QuerySnapshot querySnapshot) {
                                          querySnapshot.docs.forEach((doc) {
                                            doc.reference.update({
                                              'dospem_2': {
                                                'name': data['name'],
                                                'nimNip': data['nimNip'],
                                                'status': false,
                                              },
                                              // Update other fields as needed
                                            }).then((_) {
                                              print("Dosen Pembimbing Updated");
                                            }).catchError((error) {
                                              print(
                                                  "Failed to update Dosen Pembimbing: $error");
                                            });

                                            final dosenId =
                                                doc.id; // Store the document ID

                                            // Create a new chat document with the mahasiswa and dosen as participants
                                            firestore.collection('chats').add({
                                              'connections': [
                                                mahasiswaNim,
                                                data['nimNip']
                                              ],
                                            }).then((docRef) {
                                              print(
                                                  "Chat created with ID: ${docRef.id}");

                                              // Create a new chat document in the 'chats' subcollection of the Mahasiswa document
                                              doc.reference
                                                  .collection('chats')
                                                  .doc(docRef.id)
                                                  .set({
                                                'connection': data['nimNip'],
                                                'lastTime': DateTime.now()
                                                    .toIso8601String(),
                                                'total_unread': 0,
                                              }).then((_) {
                                                print(
                                                    "Chat created in Mahasiswa's chats with ID: ${docRef.id}");
                                              }).catchError((error) {
                                                print(
                                                    "Failed to create chat in Mahasiswa's chats: $error");
                                              });

                                              // // Create a new chat document in the 'chats' subcollection of the Dosen document
                                              firestore
                                                  .collection('Dosen')
                                                  .where('nimNip',
                                                      isEqualTo: data['nimNip'])
                                                  .get()
                                                  .then((QuerySnapshot
                                                      querySnapshot) {
                                                querySnapshot.docs
                                                    .forEach((dosenDoc) {
                                                  // Create a new chat document in the 'chats' subcollection of the Dosen document
                                                  dosenDoc.reference
                                                      .collection('chats')
                                                      .doc(docRef.id)
                                                      .set({
                                                    'connection':
                                                        mahasiswaNim, // Store the Mahasiswa's nim
                                                    'lastTime': DateTime.now()
                                                        .toIso8601String(),
                                                    'total_unread': 0,
                                                  }).then((_) {
                                                    print(
                                                        "Chat created in Dosen's chats with ID: ${docRef.id}");
                                                  }).catchError((error) {
                                                    print(
                                                        "Failed to create chat in Dosen's chats: $error");
                                                  });
                                                });
                                              }).catchError((error) {
                                                print(
                                                    "Failed to find Dosen: $error");
                                              });
                                            }).catchError((error) {
                                              print(
                                                  "Failed to create chat: $error");
                                            });
                                          });
                                        }).catchError((error) {
                                          print(error);
                                        });
                                      });
                                    }).catchError((error) {
                                      print(error);
                                    });
                                    Navigator.of(context).pop();
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
                        'Tambah Dosen Pembimbing 2',
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: medium,
                        ),
                      ),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        elevation: MaterialStateProperty.all(0),
                      ),
                    ),
                  )
                : DosenTile(
                    nip: currentDosen2!.nimNip,
                    name: currentDosen2!.name,
                    status: 'Pembimbing 2',
                    imageUrl: 'assets/Acatar.png',
                  ),
            // Container(
            //   margin: EdgeInsets.only(top: 16),
            //   height: 70,
            //   width: 350,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(18),
            //     border: Border.all(
            //       color: Colors.blue, // Set border color
            //       width: 2, // Set border width
            //     ),
            //   ),
            //   child: ElevatedButton.icon(
            //     onPressed: () {
            //       showDialog(
            //         context: context,
            //         builder: (context) => AlertDialog(
            //           title: Text('Masukkan NIP'),
            //           content: TextFormField(
            //             decoration: InputDecoration(labelText: 'NIP'),
            //           ),
            //           actions: [
            //             TextButton(
            //               child: Text('Cancel'),
            //               onPressed: () => Navigator.of(context).pop(),
            //             ),
            //             TextButton(
            //               child: Text('OK'),
            //               onPressed: () {
            //                 void getDosen(String nimNip) async {
            //                   var firestore;
            //                   DocumentSnapshot document = await firestore
            //                       .collection('dosen')
            //                       .doc(nimNip)
            //                       .get();
            //                   if (document.exists) {
            //                     print('Dosen data: ${document.data()}');
            //                   } else {
            //                     print('No dosen found with nip: $nimNip');
            //                   }
            //                 }

            //                 bool _showDosenTile;
            //                 setState(() => _showDosenTile = true);
            //                 Navigator.of(context).pop();
            //               },
            //             ),
            //           ],
            //         ),
            //       );
            //     },
            //     icon: Icon(
            //       Icons.add,
            //       color: Colors.blue,
            //     ),
            //     label: Text(
            //       'Tambah Dosen Pembimbing 2',
            //       style: blackTextStyle.copyWith(
            //         fontSize: 14,
            //         fontWeight: medium,
            //       ),
            //     ),
            //     style: ButtonStyle(
            //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //         RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(18),
            //         ),
            //       ),
            //       elevation: MaterialStateProperty.all(0),
            //     ),
            //   ),
            // ),
          ],
        ),
      );
    }

    Widget listPenguji() {
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
              'Dosen Penguji',
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              height: 70,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.blue, // Set border color
                  width: 2, // Set border width
                ),
              ),
              child: ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Masukkan NIP'),
                      content: TextFormField(
                        decoration: InputDecoration(labelText: 'NIP'),
                      ),
                      actions: [
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            bool _showDosenTile;
                            setState(() => _showDosenTile = true);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.blue,
                ),
                label: Text(
                  'Tambah Dosen Penguji 1',
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  elevation: MaterialStateProperty.all(0),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              height: 70,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.blue, // Set border color
                  width: 2, // Set border width
                ),
              ),
              child: ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Masukkan NIP'),
                      content: TextFormField(
                        decoration: InputDecoration(labelText: 'NIP'),
                      ),
                      actions: [
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            bool _showDosenTile;
                            setState(() => _showDosenTile = true);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.blue,
                ),
                label: Text(
                  'Tambah Dosen Penguj 2',
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  elevation: MaterialStateProperty.all(0),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              height: 70,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.blue, // Set border color
                  width: 2, // Set border width
                ),
              ),
              child: ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Masukkan NIP'),
                      content: TextFormField(
                        decoration: InputDecoration(labelText: 'NIP'),
                      ),
                      actions: [
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            bool _showDosenTile;
                            setState(() => _showDosenTile = true);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.blue,
                ),
                label: Text(
                  'Tambah Dosen Penguj 3',
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  elevation: MaterialStateProperty.all(0),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            )
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
            listPenguji(),
          ],
        ),
      ),
    );
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }
}
