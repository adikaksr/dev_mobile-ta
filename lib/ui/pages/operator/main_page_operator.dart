import 'package:easkripsi/cubit/page_cubit.dart';
import 'package:easkripsi/ui/pages/bimbingan_page.dart';
import 'package:easkripsi/ui/pages/dosen/bimbingan_page_dosen.dart';
import 'package:easkripsi/ui/pages/dosen/daftar_mahasiswa_page.dart';
import 'package:easkripsi/ui/pages/dosen/home_page_dosen.dart';
import 'package:easkripsi/ui/pages/home_page.dart';
import 'package:easkripsi/ui/pages/jadwal_page.dart';
import 'package:easkripsi/ui/pages/koordinator%20ta/daftar_berkas_mahasiswa_page.dart';
import 'package:easkripsi/ui/pages/koordinator%20ta/home_page_koorta.dart';
import 'package:easkripsi/ui/pages/operator/home_page.operator.dart';
import 'package:easkripsi/ui/widgets/custom_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/theme.dart';

class MainPageOperator extends StatelessWidget {
  const MainPageOperator({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildContent(int currentIndex) {
      switch (currentIndex) {
        case 0:
          return const HomePageOperator();
        default:
          return HomePage();
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
