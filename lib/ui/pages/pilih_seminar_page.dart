import 'package:easkripsi/ui/pages/jadwal_page.dart';
import 'package:easkripsi/ui/pages/second_form_page.dart';
import 'package:easkripsi/ui/widgets/custom_button.dart';
import 'package:easkripsi/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class PilihSeminarPage extends StatelessWidget {
  const PilihSeminarPage({super.key});

  // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBGColor2,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 10),
            child: Text(
              "Pilih Seminar",
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 16),
              height: 70,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => JadwalPage()),
                  );
                },
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // Add this line
                  children: <Widget>[
                    Text(
                      'Seminar Proposal',
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: medium,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.black,
                    ),
                  ],
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
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => JadwalPage()),
                  );
                },
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // Add this line
                  children: <Widget>[
                    Text(
                      'Seminar Hasil',
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: medium,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.black,
                    ),
                  ],
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
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => JadwalPage()),
                  );
                },
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // Add this line
                  children: <Widget>[
                    Text(
                      'Sidang Tugas Akhir',
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: medium,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.black,
                    ),
                  ],
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
      ),
    );
  }
}
