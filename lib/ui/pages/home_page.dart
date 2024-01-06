import 'package:flutter/material.dart';
import '../../shared/theme.dart';
import '../widgets/fl_charts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget chartBar() {
      return Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(top: 5),
        height: 500,
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: kGreyColor),
        ),
        child: const BarChartSample2(),
      );
    }

    Widget listPengumuman() {
      return Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(
          top: 20,
          bottom: 60,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: kGreyColor),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Pengumuman",
                style: blackTextStylePS.copyWith(
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Lihat pengumuman terbaru mengenai info surat edaran yang diterbitkan",
                style: gray2TextStylePS.copyWith(
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Daftar Pengumuman",
                style: grayTextStylePS.copyWith(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                  fontWeight: thin,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(15),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Color(0xFF696CFF)),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () => {},
                    child: Row(
                      children: [
                        Container(
                          width: 18,
                          height: 18,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/icon_surat.png',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          "SE Nomor 1163/UN11/HK.00/2020",
                          style: gray2TextStylePS.copyWith(
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          flexibleSpace: Container(
            color: Colors.white,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 15,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/image_usk.png",
                      scale: 2.5,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 6),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'EASKRIPSI',
                            style: blackTextStyle.copyWith(
                              fontSize: 20,
                              fontWeight: bold,
                            ),
                          ),
                          Text(
                            "S1-Informatika USK",
                            style: blackTextStyle.copyWith(
                              fontSize: 11,
                              fontWeight: bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: IconButton(
                        onPressed: () {},
                        icon: const CircleAvatar(),
                        iconSize: 40,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          leadingWidth: 100,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Center(
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              chartBar(),
              listPengumuman(),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
