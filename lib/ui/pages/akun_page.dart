import 'package:easkripsi/controller/login_controller.dart';
import 'package:easkripsi/shared/theme.dart';
import 'package:easkripsi/ui/pages/login_page.dart';
import 'package:easkripsi/ui/pages/profil_page.dart';
import 'package:flutter/material.dart';

class AkunPage extends StatelessWidget {
  final LoginController loginController = LoginController();

  AkunPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBGColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 10),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Akun",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Profil",
              style: TextStyle(
                fontFamily: 'Public Sans',
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: kGrayColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                height: 65,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Color(0xFFDFE0EB)),
                          borderRadius: BorderRadius.circular(6))),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilPage()),
                    );
                  },
                  child: const Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                      ),
                      Expanded(
                        // Add this line
                        child: Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            "Adika Nuraga Kanaka Stamba Rucira",
                            style: TextStyle(
                              fontFamily: 'Public Sans',
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                "Logout",
                style: TextStyle(
                  fontFamily: 'Public Sans',
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: kGrayColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                height: 55,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Color(0xFFDFE0EB)),
                          borderRadius: BorderRadius.circular(6))),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Keluar'),
                          content: Text('Apakah anda yakin ingin keluar?'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Batal'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Keluar'),
                              onPressed: () async {
                                await loginController.logout();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text(
                    "Keluar",
                    style: TextStyle(
                      fontFamily: 'Public Sans',
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
