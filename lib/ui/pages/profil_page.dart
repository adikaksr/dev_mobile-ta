import 'package:easkripsi/shared/theme.dart';
import 'package:flutter/material.dart';
import '../widgets/data_ortu.dart';
import '../widgets/data_pribadi.dart';

class ProfilPage extends StatelessWidget {
  ProfilPage({Key? key}) : super(key: key);

  final List<Widget> myTab = [
    const Tab(text: "Data Pribadi"),
    const Tab(text: "Data Orangtua"),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTab.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(360),
          child: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(40)),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: <Color>[
                        Color(0xff4481EB),
                        Color(0xff04BEFE),
                      ], // Gradient from https://learnui.design/tools/gradient-generator.html
                      tileMode: TileMode.mirror,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 35),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        BackButton(color: Colors.white),
                        Text(
                          "Profil",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 55,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          "Adika Nuraga Kanaka Stamba Rucira",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Public Sans',
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: const Icon(
                                Icons.email,
                                size: 15,
                                color: Color(0xFF3194F1),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "nuraga@mhs.usk.ac.id",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            backgroundColor: kBGColor,
            elevation: 0,
            bottom: TabBar(
              tabs: myTab,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 3,
              indicatorColor: Colors.white,
              labelStyle: const TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.all(20),
          child: TabBarView(
            children: [
              DataPribadi(),
              DataOrtu(),
            ],
          ),
        ),
      ),
    );
  }
}
