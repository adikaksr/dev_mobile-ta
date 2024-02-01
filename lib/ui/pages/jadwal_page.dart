import 'package:carousel_slider/carousel_slider.dart';
import 'package:easkripsi/ui/widgets/custom_button.dart';
import 'package:easkripsi/ui/widgets/detail_presensi.dart';
import 'package:easkripsi/ui/widgets/jam_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../shared/theme.dart';

class JadwalPage extends StatefulWidget {
  const JadwalPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _JadwalPageState createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBGColor2,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 10),
              child: Text(
                "Jadwal Seminar",
                style: blackTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: medium,
                ),
              ),
            ),
          ),
          backgroundColor: kWhiteColor,
          elevation: 1,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: 30,
        ), // Add margin here

        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 140.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius:
                          BorderRadius.circular(10.0), // Add border radius here
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 97.0,
                      viewportFraction: 1 / 3,
                      enableInfiniteScroll: false,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentPage = index; // Update _currentPage here
                        });
                      },
                    ),
                    items: List.generate(
                            10 * 7, // Generate dates for 10 weeks
                            (i) => DateTime.now().add(Duration(days: i)))
                        .where((date) {
                          // Only include weekdays
                          return date.weekday != DateTime.saturday &&
                              date.weekday != DateTime.sunday;
                        })
                        .take(10)
                        .toList()
                        .asMap()
                        .entries
                        .map<Widget>((entry) {
                          // Take only the first 10 dates
                          int index = entry.key;
                          DateTime date = entry.value;
                          final double opacity =
                              (_currentPage == index) ? 1.0 : 0.3;
                          return Opacity(
                            opacity: opacity,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                color: kWhiteColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      DefaultTextStyle.merge(
                                        style: GoogleFonts.poppins(
                                            height:
                                                1.1), // Adjust this value to change the line height
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              DateFormat('d').format(date),
                                              style: GoogleFonts.poppins(
                                                fontSize: 32,
                                                color: Color(0xFFC8372D),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              DateFormat('MMM').format(date),
                                              style: GoogleFonts.poppins(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })
                        .toList(),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    JamPicker(title: '8.00 - 10.00'),
                    JamPicker(title: '10.00 - 12.00'),
                    JamPicker(title: '14.00 - 16.00'),
                    JamPicker(title: '16.00 - 18.00'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                margin: EdgeInsets.only(top: 10.0),
                width: double.infinity,
                // height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Text(
                      'Detail Presensi',
                      style: blackTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: semiBold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: ListView(
                        children: [
                          DetailPresensi(
                            title: 'Dosen 1 Informatika',
                          ),
                          DetailPresensi(
                            title: 'Dosen 2 Informatika',
                          ),
                          DetailPresensi(
                            title: 'Dosen 3 Informatika',
                          ),
                          DetailPresensi(
                            title: 'Dosen 4 Informatika',
                          ),
                          DetailPresensi(
                            title: 'Dosen 5 Informatika',
                          ),
                          SizedBox(height: 10),
                          CustomButton(title: 'Pilih Jadwal', onPressed: () {}),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
