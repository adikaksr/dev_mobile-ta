import 'package:easkripsi/shared/theme.dart';
import 'package:easkripsi/ui/pages/chat_room_page.dart';
import 'package:flutter/material.dart';

class BimbinganPage extends StatelessWidget {
  const BimbinganPage({Key? key}) : super(key: key);

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
      body: ListView(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ChatRoomPage()), // Replace with your ChatRoomPage
              );
            },
            child: ListTile(
              title: const Text("Dosen 1 Informatika"),
              subtitle: const Text(
                "Gimana progressnya?",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              leading: const CircleAvatar(
                radius: 23,
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("10min"),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green,
                    ),
                    child: const Center(
                      child: Text("1",
                          style: TextStyle(
                            color: Colors.white,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: kGreyColor,
            thickness: 1,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ChatRoomPage()), // Replace with your ChatRoomPage
              );
            },
            child: ListTile(
              title: const Text("Dosen 2 Informatika"),
              subtitle: const Text(
                "Boleh",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              leading: const CircleAvatar(
                radius: 23,
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("30min"),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green,
                    ),
                    child: const Center(
                      child: Text("3",
                          style: TextStyle(
                            color: Colors.white,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: kGreyColor,
            thickness: 1,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ChatRoomPage()), // Replace with your ChatRoomPage
              );
            },
            child: ListTile(
              title: const Text("Koordinator TA"),
              subtitle: const Text(
                "Berkas sudah diperiksa",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              leading: const CircleAvatar(
                radius: 23,
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("1jam"),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green,
                    ),
                    child: const Center(
                      child: Text("3",
                          style: TextStyle(
                            color: Colors.white,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: kGreyColor,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
