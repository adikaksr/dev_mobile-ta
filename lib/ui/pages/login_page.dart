import 'dart:math';
import 'package:easkripsi/ui/pages/dosen/main_page_dosen.dart';
import 'package:easkripsi/ui/pages/koordinator%20ta/koordinator_ta_page.dart';
import 'package:easkripsi/ui/pages/main_page.dart';
import 'package:easkripsi/ui/pages/operator/operator_page.dart';
import 'package:easkripsi/ui/widgets/custom_button.dart';
import 'package:easkripsi/ui/widgets/custom_dropdown.dart';
import 'package:easkripsi/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/login_controller.dart';
import '../../shared/theme.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? role;
  LoginController loginController = LoginController();
  final idInput = TextEditingController();
  final passwordInput = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  void handleLogin() async {
    String nimNip = idInput.text;
    String password = passwordInput.text;

    // Show a loading indicator
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Row(
          children: <Widget>[
            CircularProgressIndicator(),
            Text("  Logging in..."),
          ],
        ),
      ),
    );

    try {
      bool data = await loginController.login(nimNip, password, role!);

      // Hide the loading indicator
      _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();

      if (data && role == 'Mahasiswa') {
        Navigator.pushReplacementNamed(context, '/main');
      } else if (data && role == 'Dosen') {
        Navigator.pushReplacementNamed(context, '/main-dosen');
      } else if (data && role == 'Koordinator TA') {
        Navigator.pushReplacementNamed(context, '/main-koorta');
      } else if (data && role == 'Operator') {
        Navigator.pushReplacementNamed(context, '/main-operator');
      } else {
        // Show an error message
        Get.snackbar('Error', 'Failed to login');
        throw Exception('Failed to login');
      }
    } catch (error) {
      // Hide the loading indicator
      _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();

      // Show an error message
      _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text('Failed to login: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: const EdgeInsets.only(
          top: 50,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/image_usk.png',
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'EASKRIPSI',
                  style: blackTextStyle.copyWith(
                    fontSize: 26,
                    fontWeight: bold,
                  ),
                ),
                Text(
                  'S1-Informatika USK',
                  style: blackTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget welcome() {
      return Container(
        margin: const EdgeInsets.only(
          top: 50,
        ),
        child: Text(
          'Selamat Datang',
          textAlign: TextAlign.center,
          style: blueTextStyle.copyWith(
            fontSize: 28,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget userRole() {
      return CustomDropdown(
        title: 'Login Sebagai',
        items: ['Mahasiswa', 'Dosen', 'Koordinator TA', 'Operator'],
        onChanged: (value) {
          setState(() {
            role = value;
          });
        },
      );
    }

    Widget inputSection() {
      Widget idForm() {
        return CustomTextFormField(
          title: 'NPM/NIP',
          hintText: 'NPM/NIP',
          controller: idInput,
        );
      }

      Widget passwordForm() {
        return CustomTextFormField(
          title: 'Kata Sandi',
          hintText: 'Kata Sandi',
          obscureText: true,
          controller: passwordInput,
        );
      }

      Widget loginButton() {
        return CustomButton(
          title: 'Masuk',
          onPressed: handleLogin,
        );
      }

      return Container(
        margin: const EdgeInsets.only(top: 30),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            userRole(),
            idForm(),
            passwordForm(),
            loginButton(),
          ],
        ),
      );
    }

    return ScaffoldMessenger(
      child: Scaffold(
        key: _scaffoldMessengerKey,
        backgroundColor: kBGColor,
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            children: [
              header(),
              welcome(),
              inputSection(),
            ],
          ),
        ),
      ),
    );
  }
}
