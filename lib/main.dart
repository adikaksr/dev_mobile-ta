import 'package:easkripsi/ui/pages/login_page.dart';
import 'package:easkripsi/ui/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'ui/pages/splash_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashPage(),
        '/login-page': (context) => const LoginPage(),
        '/main': (context) => MainPage(),
      },
    );
  }
}
