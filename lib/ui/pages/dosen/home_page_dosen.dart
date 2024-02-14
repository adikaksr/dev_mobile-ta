import 'package:easkripsi/ui/pages/akun_page.dart';
import 'package:easkripsi/ui/pages/bimbingan_page.dart';
import 'package:easkripsi/ui/widgets/mahasiswa_tile.dart';
import 'package:flutter/material.dart';
import '../../../shared/theme.dart';

class HomePageDosen extends StatelessWidget {
  const HomePageDosen({super.key});

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
                  'Hello,\nDosen 1 Informatika',
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
                  MaterialPageRoute(builder: (context) => const AkunPage()),
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
                        'Siap bimbingan\nhari ini?',
                        style: blackTextStyle.copyWith(
                          fontSize: 19,
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
              'Daftar Mahasiswa',
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
            const MahasiswaTile(
              name: 'Mahasiswa 1',
              status: '1808107010001',
              imageUrl: 'assets/Acatar.png',
            ),
            const MahasiswaTile(
              name: 'Mahasiswa 2',
              status: '1808107010002',
              imageUrl: 'assets/Acatar.png',
            ),
            const MahasiswaTile(
              name: 'Mahasiswa 3',
              status: '1808107010003',
              imageUrl: 'assets/Acatar.png',
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: GestureDetector(
                onTap: () {},
                child: Text(
                  'Lihat selengkapnya',
                  style: blueTextStyle.copyWith(
                    fontWeight: medium,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 80,
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
          ],
        ),
      ),
    );
  }
}
