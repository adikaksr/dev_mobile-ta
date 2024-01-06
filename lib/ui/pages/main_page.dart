import 'package:easkripsi/ui/pages/home_page.dart';
import 'package:easkripsi/ui/widgets/custom_bottom_navigation.dart';
import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildContent() {
      return HomePage();
    }

    Widget customBottomNavigation() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: kWhiteColor,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //HOME
              CustomBottomNavigation(
                imageUrl: 'assets/icon_home.png',
                title: 'Beranda',
                isSelected: true,
              ),
              //FORM
              CustomBottomNavigation(
                imageUrl: 'assets/icon_form.png',
                title: 'Form',
              ),
              //BIMBINGAN
              CustomBottomNavigation(
                imageUrl: 'assets/icon_bimbingan.png',
                title: 'Bimbingan',
              ),
              //JADWAL
              CustomBottomNavigation(
                imageUrl: 'assets/icon_jadwal.png',
                title: 'Jadwal',
              ),
              //KEHADIRAN
              CustomBottomNavigation(
                imageUrl: 'assets/icon_kehadiran.png',
                title: 'Kehadiran',
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBGColor,
      body: Stack(
        children: [
          buildContent(),
          customBottomNavigation(),
        ],
      ),
    );
  }
}
