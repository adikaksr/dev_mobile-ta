import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easkripsi/controller/koorta_controller.dart';
import 'package:easkripsi/ui/pages/akun_page.dart';
import 'package:easkripsi/ui/pages/bimbingan_page.dart';
import 'package:easkripsi/ui/pages/koordinator%20ta/daftar_berkas_mahasiswa_page.dart';
import 'package:easkripsi/ui/pages/koordinator%20ta/pilih_seminar_mahasiswa_page.dart';
import 'package:easkripsi/ui/widgets/mahasiswa_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../controller/text_controller.dart';
import '../../../shared/theme.dart';
import '../../widgets/berkas_mahasiswa.dart';

class HomePageKoorta extends StatefulWidget {
  const HomePageKoorta({super.key});

  @override
  State<HomePageKoorta> createState() => _HomePageKoortaState();
}

class _HomePageKoortaState extends State<HomePageKoorta> {
  final TextController textController = Get.put(TextController());
  final KoortaController koortaController = Get.find<KoortaController>();
  final firestore = FirebaseFirestore.instance;
  final storage = new FlutterSecureStorage();
  Map<String, dynamic> userData = {};
  String collectedDosen = '';

  @override
  void initState() {
    super.initState();
    _readData().then((data) {
      setState(() {
        userData = data;
        textController.updateDosen(data['nimNip']);
      });
    });
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
              child: FutureBuilder<Map<String, dynamic>>(
                future: _readData(), // Read the data from secure storage
                builder: (BuildContext context,
                    AsyncSnapshot<Map<String, dynamic>> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error.toString()}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Show a loading spinner while waiting for the data
                  }

                  Map<String, dynamic> data = snapshot.data ?? {};
                  String dosenName = data['name'] ?? 'No name';
                  collectedDosen = dosenName;

                  return Container(
                    child: Text(
                      'Hello,\n$dosenName',
                      style: blackTextStyle.copyWith(
                        fontSize: 24,
                        fontWeight: semiBold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                },
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
                        'Periksa berkas\nmahasiswa',
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
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            backgroundColor: kWhiteColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                          child: Text(
                            'Mulai Periksa',
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
            SizedBox(
              height: 15,
            ),
            Container(
              height: 200, // Ensure the container has a defined height
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: koortaController.getMahasiswa(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('No Mahasiswa with berkas found'),
                    );
                  }
                  var mahasiswaWithBerkas = snapshot.data!;
                  int itemCount = min(mahasiswaWithBerkas.length, 3);
                  return ListView.builder(
                    itemCount: itemCount,
                    itemBuilder: (context, index) {
                      var data = mahasiswaWithBerkas[index];
                      return InkWell(
                        onTap: () {
                          var selectedMahasiswa = mahasiswaWithBerkas
                              .where((mahasiswa) =>
                                  mahasiswa['nimNip'] == data['nimNip'])
                              .toList();
                          Get.to(() => PilihSeminarMahasiswaPage(
                              mahasiswaWithBerkas: selectedMahasiswa));
                        },
                        child: BerkasMahasiswa(
                          name: data['name'],
                          status: data['nimNip'],
                          imageUrl: 'assets/Acatar.png',
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Get.to(() => const DaftarBerkasMahasiswaPage());
                },
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
