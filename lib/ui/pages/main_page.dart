import 'package:easkripsi/cubit/page_cubit.dart';
import 'package:easkripsi/ui/pages/bimbingan_page.dart';
import 'package:easkripsi/ui/pages/form_page.dart';
import 'package:easkripsi/ui/pages/home_page.dart';
import 'package:easkripsi/ui/pages/jadwal_page.dart';
import 'package:easkripsi/ui/pages/kehadiran_page.dart';
import 'package:easkripsi/ui/widgets/custom_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/theme.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildContent(int currentIndex) {
      switch (currentIndex) {
        case 0:
          return const HomePage();
        case 1:
          return const FormPage();
        case 2:
          return const BimbinganPage();
        case 3:
          return const JadwalPage();
        case 4:
          return const KehadiranPage();
        default:
          return const HomePage();
      }
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //HOME
              CustomBottomNavigation(
                index: 0,
                iconKey: 'home',
                title: 'Beranda',
                context: context,
              ),
              //FORM
              CustomBottomNavigation(
                index: 1,
                iconKey: 'form',
                title: 'Form',
                context: context,
              ),
              //BIMBINGAN
              CustomBottomNavigation(
                index: 2,
                iconKey: 'bimbingan',
                title: 'Bimbingan',
                context: context,
              ),
              //JADWAL
              CustomBottomNavigation(
                index: 3,
                iconKey: 'jadwal',
                title: 'Jadwal',
                context: context,
              ),
              //KEHADIRAN
              CustomBottomNavigation(
                index: 4,
                iconKey: 'kehadiran',
                title: 'Kehadiran',
                context: context,
              ),
            ],
          ),
        ),
      );
    }

    return BlocBuilder<PageCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          backgroundColor: kBGColor,
          body: Stack(
            children: [
              buildContent(currentIndex),
              customBottomNavigation(),
            ],
          ),
        );
      },
    );
  }
}
