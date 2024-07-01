import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easkripsi/controller/text_controller.dart';
import 'package:easkripsi/shared/theme.dart';
import 'package:easkripsi/ui/pages/chat_room_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
      QuerySnapshot mahasiswaSnapshot = await firestore
          .collection('Mahasiswa')
          .where('nimNip', isEqualTo: nim)
          .get();

      var chatData = firestore
          .collection('Mahasiswa')
          .doc(mahasiswaSnapshot.docs[0].id)
          .collection('chats')
          .orderBy("lastTime", descending: true)
          .snapshots();

      yield* chatData;
    } catch (e) {
      print('Failed to get chats data: $e');
    }
  }

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
        stream: getChatsData(textController.nimMahasiswa.value),
        // builder: (BuildContext context,
        //     AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var chatData = snapshot.data!.docs;

            if (chatData.isEmpty) {
              return const Center(child: Text('Belum ada bimbingan tersedia!'));
            } else {
              return ListView.builder(
                itemCount: chatData.length,
                itemBuilder: (context, index) {
                  var chat = chatData[index].data();

                  // format the lastTime to show the date or time
                  String formatDuration(DateTime lastTime) {
                    DateTime now = DateTime.now();
                    DateTime today = DateTime(now.year, now.month, now.day);
                    DateTime yesterday = today.subtract(Duration(days: 1));
                    DateTime lastDate =
                        DateTime(lastTime.year, lastTime.month, lastTime.day);

                    if (lastDate == today) {
                      // If the lastTime is today, show the clock time
                      return DateFormat('HH:mm').format(lastTime);
                    } else if (lastDate == yesterday) {
                      // If the lastTime is yesterday, show "Kemarin"
                      return 'Kemarin';
                    } else {
                      // If the lastTime is more than one day ago, show the date
                      return DateFormat('dd/MM/yyyy').format(lastTime);
                    }
                  }

                  return ListTile(
                    title: Text(chat['name']),
                    subtitle: Text(
                      chat['last_chat'] ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    leading: CircleAvatar(
                      radius: 23,
                      backgroundImage: AssetImage('assets/image_avatar.png'),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment:
                          CrossAxisAlignment.end, // Align to the right
                      children: [
                        // Show the formatted lastTime
                        Text(formatDuration(DateTime.parse(chat['lastTime']))),
                        // Show the unread count if it's not zero
                        chat['total_unread'] != 0
                            ? Container(
                                margin: EdgeInsets.only(top: 5),
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green,
                                ),
                                child: Center(
                                  child: Text(
                                    // Show the unread count
                                    chat['total_unread'].toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          12, // Adjust font size for better fit if necessary
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                    onTap: () {
                      // Get.to(() => ChatRoomPage(
                      //     chatId: chat['chat_id'],
                      //     chatName: chat['name'],
                      //     nipDosen: chat['connection']));
                      bimbinganController.goToChatRoom(
                        chat['chat_id'],
                        chat['name'],
                        textController.nimMahasiswa.value,
                        chat['connection'],
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
