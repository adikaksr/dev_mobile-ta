import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easkripsi/controller/text_controller.dart';
import 'package:easkripsi/shared/theme.dart';
import 'package:easkripsi/ui/pages/chat_room_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../controller/bimbingan_controller.dart';

class BimbinganPage extends StatefulWidget {
  const BimbinganPage({Key? key}) : super(key: key);

  @override
  State<BimbinganPage> createState() => _BimbinganPageState();
}

class _BimbinganPageState extends State<BimbinganPage> {
  final firestore = FirebaseFirestore.instance;
  final storage = new FlutterSecureStorage();
  final textController = Get.find<TextController>();
  final bimbinganController = Get.find<BimbinganController>();
  Map<String, dynamic> userData = {};

  // late StreamSubscription<List<QuerySnapshot>> _chatsSubscription;
  List<Map<String, dynamic>> _chatData = [];

  @override
  void initState() {
    super.initState();
    _readData().then((data) {
      print(' apa ni dapat data?: $data');
      setState(() {
        userData = data;
      });
    });

    // _chatsSubscription = getChatsData(userData['nimNip'])
    //     .listen((List<QuerySnapshot> snapshots) {
    //   snapshots.forEach((snapshot) {
    //     snapshot.docs.forEach((doc) {
    //       print(doc.data());
    //     });
    //   });
    // });
  }

  @override
  void dispose() {
    // _chatsSubscription?.cancel();
    super.dispose();
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

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatsData(String nim) async* {
    try {
      // Replace 'yourMahasiswaId' with the actual Mahasiswa ID
      QuerySnapshot mahasiswaSnapshot = await firestore
          .collection('Mahasiswa')
          .where('nimNip', isEqualTo: nim)
          .get();

      var chatData = firestore
          .collection('Mahasiswa')
          .doc(mahasiswaSnapshot.docs[0].id)
          .collection('chats')
          .snapshots();
      // for (var doc in mahasiswaSnapshot.docs) {
      //   yield* doc.reference
      //       .collection('chats')
      //       .snapshots()
      //       .map((snapshot) => [snapshot]);
      // }
      yield* chatData;
    } catch (e) {
      print('Failed to get chats data: $e');
    }
  }

  // Future<DocumentSnapshot> getDosenData() async {
  //   // Replace 'yourChatId' with the actual chat ID
  //   final chatDoc = await firestore.collection('chats').doc('yourChatId').get();
  //   final dosenNimNip = chatDoc.data()?['connections'][
  //       1]; // Assuming the Dosen's nimNip is the second item in the 'connections' array

  //   // Fetch the Dosen data
  //   final querySnapshot = await firestore
  //       .collection('Dosen')
  //       .where('nimNip', isEqualTo: dosenNimNip)
  //       .get();

  //   if (querySnapshot.docs.isEmpty) {
  //     // Handle the case where the query didn't match any documents
  //     // For example, you could throw an error or return null
  //     throw Exception('No matching Dosen found');
  //   }

  //   return querySnapshot.docs.first;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 15, bottom: 10),
              child: Text(
                "Bimbingan",
                style: blackTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: medium,
                ),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 1,
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: bimbinganController.dataChatDosen(),
        // builder: (BuildContext context,
        //     AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var chatData = snapshot.data!.docs;

            print('dapat userData: $userData');
            print('dapat chatData: $chatData');
            if (chatData.isEmpty) {
              return const Center(child: Text('Belum ada chat tersedia!'));
            } else {
              return ListView.builder(
                itemCount: chatData.length,
                itemBuilder: (context, index) {
                  var chat = chatData[index].data();

                  print(chatData[0].data());

                  return ListTile(
                    title: Text('hadi'),
                    subtitle: Text(
                      "Gimana progressnya?",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    leading: CircleAvatar(
                      radius: 23,
                      backgroundImage: AssetImage('assets/image_avatar.png'),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("10min"),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green,
                          ),
                          child: Center(
                            child: Text("1",
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatRoomPage()),
                      );
                    },
                  );
                },
              );
            }
          } else if (snapshot.hasError) {
            return Text(
                "Error: ${snapshot.error}"); // Show an error message if something went wrong
          } else {
            // print('ini apa snapshot data: ${snapshot.data}');
            return const Center(
                child:
                    CircularProgressIndicator()); // Show a loading spinner while waiting
          }
        },
      ),
    );
  }
}
