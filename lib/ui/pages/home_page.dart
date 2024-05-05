import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easkripsi/ui/pages/akun_page.dart';
import 'package:easkripsi/ui/pages/bimbingan_page.dart';
import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

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
              child: Container(
                child: Text(
                  'Hello,\nAdika Nuraga Kanaka Stamba Rucira',
                  style: blackTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: semiBold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
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
                  'Tambah Dosen Pembimbing 1',
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
                            void getDosen(String nimNip) async {
                              var firestore;
                              DocumentSnapshot document = await firestore
                                  .collection('dosen')
                                  .doc(nimNip)
                                  .get();
                              if (document.exists) {
                                print('Dosen data: ${document.data()}');
                              } else {
                                print('No dosen found with nip: $nimNip');
                              }
                            }

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
                  'Tambah Dosen Pembimbing 2',
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

  void setState(bool Function() param0) {}
}
