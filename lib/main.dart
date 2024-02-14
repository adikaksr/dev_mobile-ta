import 'package:easkripsi/cubit/page_cubit.dart';
import 'package:easkripsi/ui/pages/bimbingan_page.dart';
import 'package:easkripsi/ui/pages/chat_room_page.dart';
import 'package:easkripsi/ui/pages/dosen/main_page_dosen.dart';
import 'package:easkripsi/ui/pages/form_page.dart';
import 'package:easkripsi/ui/pages/home_page.dart';
import 'package:easkripsi/ui/pages/jadwal_page.dart';
import 'package:easkripsi/ui/pages/kehadiran_page.dart';
import 'package:easkripsi/ui/pages/koordinator%20ta/koordinator_ta_page.dart';
import 'package:easkripsi/ui/pages/login_page.dart';
import 'package:easkripsi/ui/pages/main_page.dart';
import 'package:easkripsi/ui/pages/second_form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'ui/pages/splash_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PageCubit(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashPage(),
          '/login-page': (context) => LoginPage(),
          '/main': (context) => const MainPage(),
          '/bimbingan': (context) => const BimbinganPage(),
          '/home': (context) => const HomePage(),
          '/jadwal': (context) => const JadwalPage(),
          '/kehadiran': (context) => const KehadiranPage(),
          '/form': (context) => FormPage(),
          '/second-form': (context) => SecondFormPage(),
          '/chat-room': (context) => ChatRoomPage(),
          '/maindosen': (context) => const MainPageDosen(),
          'main': (context) => const MainPage(),
          '/mainkoorta': (context) => KoordinatorTAPage(),
        },
      ),
    );
  }
}
