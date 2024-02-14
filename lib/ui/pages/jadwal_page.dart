import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easkripsi/ui/widgets/custom_button.dart';
import 'package:easkripsi/ui/widgets/detail_presensi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../models/presensi_model.dart';
import '../../services/presensi_service.dart';
import '../../shared/theme.dart';

class JadwalPage extends StatefulWidget {
  const JadwalPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _JadwalPageState createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  int _currentPage = 0;
  String selectedTime = '08:00-10:00';
  DateTime currentDate = DateTime.now();
  List<Jadwal> jadwalList = [];
  List<String> times = [
    "08:00-10:00",
    "10:00-12:00",
    "14:00-16:00",
    "16:00-18:00"
  ];
  PresensiService presensiService = PresensiService();

  @override
  void initState() {
    super.initState();
    loadJadwalData();
    presensiService.loadPresensiData();
  }

  void loadJadwalData() async {
    String jsonString = await rootBundle.loadString('assets/presensi.json');
    List<dynamic> jsonList = jsonDecode(jsonString);
    jadwalList = jsonList.map((json) => Jadwal.fromJson(json)).toList();
    setState(() {});
  }

  Widget build(BuildContext context) {
    List<DateTime> dates = List.generate(
            10 * 7, // Generate dates for 10 weeks
            (i) => DateTime.now().add(Duration(days: i)))
        .where((date) {
          // Only include weekdays
          return date.weekday != DateTime.saturday &&
              date.weekday != DateTime.sunday;
        })
        .take(10)
        .toList();
    List<dynamic> filteredData =
        presensiService.getFilteredData(currentDate, selectedTime);
    print('Filtered data: $currentDate, $selectedTime, $filteredData');
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
      body: SingleChildScrollView(
        child: Container(
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
                        borderRadius: BorderRadius.circular(
                            10.0), // Add border radius here
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
                            currentDate =
                                dates[index]; // Update currentDate here
                            print(
                                'Current date: ${DateFormat('yyyy-MM-dd').format(currentDate)}');
                          });
                        },
                      ),
                      items: dates.asMap().entries.map<Widget>((entry) {
                        // Take only the first 10 dates
                        int index = entry.key;
                        DateTime date = entry.value;
                        final double opacity =
                            (_currentPage == index) ? 1.0 : 0.3;
                        return Opacity(
                          opacity: opacity,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: kWhiteColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                      }).toList(),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: times.map((time) {
                      bool isSelected = time == selectedTime;
                      return Container(
                        margin: EdgeInsets.only(right: 5),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedTime = time;
                            });
                            print('Button with time $time pressed');
                            // Perform your action here
                          },
                          child: Text(
                            time,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (selectedTime == time) {
                                  return Colors
                                      .blue; // the color when button selected
                                }
                                return Colors.white; // the default color
                              },
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: isSelected
                                    ? BorderSide.none
                                    : BorderSide(
                                        color: Colors.blue, width: 1.5),
                              ),
                            ),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(
                                  10.0), // Adjust this value to decrease/increase padding
                            ),
                            elevation: MaterialStateProperty.all(0),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                padding: const EdgeInsets.all(15.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 289, // Set a specific height for the Container
                      child: Column(
                        children: [
                          Container(
                            // padding: const EdgeInsets.all(8.0),
                            margin: EdgeInsets.only(bottom: 15),
                            child: Text(
                              'Detail Presensi',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16, // Adjust the font size as needed
                                fontWeight:
                                    FontWeight.bold, // Make the text bold
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: filteredData.map((item) {
                                // Check if the 'presensi' key exists in the item
                                if (item.containsKey('presensi')) {
                                  return DetailPresensi(
                                    title: item['presensi']['dosen'],
                                    status: item['presensi']['status'],
                                  );
                                } else {
                                  // Handle the case when the 'presensi' key doesn't exist
                                  return ListTile(
                                    title: Text('No presensi data'),
                                  );
                                }
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              CustomButton(title: 'Pilih Jadwal', onPressed: () {}),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
