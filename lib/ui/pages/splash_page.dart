import 'dart:async';

import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.pushNamed(context, '/login-page');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/image_usk.png',
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'EASKRIPSI',
                      style: whiteTextStyle.copyWith(
                        fontSize: 29,
                        fontWeight: bold,
                      ),
                    ),
                    Text(
                      'S1-Informatika USK',
                      style: whiteTextStyle.copyWith(
                        fontSize: 15,
                        fontWeight: bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Aplikasi EASKRIPSI S1-Informatika USK akan\nsangat membantu dalam proses\nbimbingan tugas akhir. Sehingga semua proses bimbingan dapat terorganisir dengan baik.',
              textAlign: TextAlign.center,
              style: whiteTextStyle.copyWith(
                fontSize: 13,
                fontWeight: medium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
