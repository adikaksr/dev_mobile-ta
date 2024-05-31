import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easkripsi/shared/theme.dart';
import 'package:easkripsi/ui/pages/chat_room_page.dart';
import 'package:flutter/material.dart';

class BimbinganPage extends StatefulWidget {
  const BimbinganPage({Key? key}) : super(key: key);

  @override
  State<BimbinganPage> createState() => _BimbinganPageState();
}

class _BimbinganPageState extends State<BimbinganPage> {
  final firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    // Refresh the page here
  }

  Future<DocumentSnapshot> getDosenData() async {
    // Replace 'yourChatId' with the actual chat ID
    final chatDoc = await firestore.collection('chats').doc('yourChatId').get();
    final dosenNimNip = chatDoc.data()?['connections'][
        1]; // Assuming the Dosen's nimNip is the second item in the 'connections' array

    // Fetch the Dosen data
    final querySnapshot = await firestore
        .collection('Dosen')
        .where('nimNip', isEqualTo: dosenNimNip)
        .get();

    if (querySnapshot.docs.isEmpty) {
      // Handle the case where the query didn't match any documents
      // For example, you could throw an error or return null
      throw Exception('No matching Dosen found');
    }

    return querySnapshot.docs.first;
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
      body: FutureBuilder<DocumentSnapshot>(
        future: getDosenData(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child:
                    CircularProgressIndicator()); // Show a loading spinner while waiting
          } else if (snapshot.hasError) {
            return Text(
                "Error: ${snapshot.error}"); // Show an error message if something went wrong
          } else {
            final dosenData = snapshot.data?.data() as Map<String, dynamic>;
            return ListTile(
              title: Text(dosenData != null && dosenData.containsKey('name')
                  ? dosenData['name']
                  : 'No name'), // Replace 'name' with the actual field name for the Dosen's name
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
          }
        },
      ),
      // ListView(
      //   children: [
      //     InkWell(
      //       onTap: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //               builder: (context) =>
      //                   ChatRoomPage()), // Replace with your ChatRoomPage
      //         );
      //       },
      //       child: ListTile(
      //         title: const Text("Dosen 1 Informatika"),
      //         subtitle: const Text(
      //           "Gimana progressnya?",
      //           maxLines: 1,
      //           overflow: TextOverflow.ellipsis,
      //         ),
      //         leading: const CircleAvatar(
      //           radius: 23,
      //         ),
      //         trailing: Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             const Text("10min"),
      //             Container(
      //               margin: const EdgeInsets.only(top: 5),
      //               height: 20,
      //               width: 20,
      //               decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(10),
      //                 color: Colors.green,
      //               ),
      //               child: const Center(
      //                 child: Text("1",
      //                     style: TextStyle(
      //                       color: Colors.white,
      //                     )),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //     Divider(
      //       color: kGreyColor,
      //       thickness: 1,
      //     ),
      //     InkWell(
      //       onTap: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //               builder: (context) =>
      //                   ChatRoomPage()), // Replace with your ChatRoomPage
      //         );
      //       },
      //       child: ListTile(
      //         title: const Text("Dosen 2 Informatika"),
      //         subtitle: const Text(
      //           "Boleh",
      //           maxLines: 1,
      //           overflow: TextOverflow.ellipsis,
      //         ),
      //         leading: const CircleAvatar(
      //           radius: 23,
      //         ),
      //         trailing: Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             const Text("30min"),
      //             Container(
      //               margin: const EdgeInsets.only(top: 5),
      //               height: 20,
      //               width: 20,
      //               decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(10),
      //                 color: Colors.green,
      //               ),
      //               child: const Center(
      //                 child: Text("3",
      //                     style: TextStyle(
      //                       color: Colors.white,
      //                     )),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //     Divider(
      //       color: kGreyColor,
      //       thickness: 1,
      //     ),
      //     InkWell(
      //       onTap: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //               builder: (context) =>
      //                   ChatRoomPage()), // Replace with your ChatRoomPage
      //         );
      //       },
      //       child: ListTile(
      //         title: const Text("Koordinator TA"),
      //         subtitle: const Text(
      //           "Berkas sudah diperiksa",
      //           maxLines: 1,
      //           overflow: TextOverflow.ellipsis,
      //         ),
      //         leading: const CircleAvatar(
      //           radius: 23,
      //         ),
      //         trailing: Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             const Text("1jam"),
      //             Container(
      //               margin: const EdgeInsets.only(top: 5),
      //               height: 20,
      //               width: 20,
      //               decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(10),
      //                 color: Colors.green,
      //               ),
      //               child: const Center(
      //                 child: Text("3",
      //                     style: TextStyle(
      //                       color: Colors.white,
      //                     )),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //     Divider(
      //       color: kGreyColor,
      //       thickness: 1,
      //     ),
      //   ],
      // ),
    );
  }
}
