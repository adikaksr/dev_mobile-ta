import 'package:easkripsi/ui/widgets/custom_button.dart';
import 'package:easkripsi/ui/widgets/custom_dropdown.dart';
import 'package:easkripsi/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
        items: [
          'Pilih Login Sebagai',
          'Mahasiswa',
          'Dosen',
          'Koordinator TA',
          'Admin',
        ],
        title: 'Login Sebagai',
        hint: 'Pilih Login Sebagai',
        onChanged: (value) {
          print('Selected item: $value');
        },
      );
    }

    Widget inputSection() {
      Widget idInput() {
        return const CustomTextFormField(
          title: 'NPM/NIP',
          hintText: 'NPM/NIP',
        );
      }

      Widget passwordInput() {
        return const CustomTextFormField(
          title: 'Kata Sandi',
          hintText: 'Kata Sandi',
          obscureText: true,
        );
      }

      Widget loginButton() {
        return CustomButton(
          title: 'Masuk',
          onPressed: () {
            Navigator.pushNamed(context, '/main');
          },
          margin: const EdgeInsets.only(
            top: 30,
            bottom: 15,
          ),
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
            idInput(),
            passwordInput(),
            loginButton(),
          ],
        ),
      );
    }

    return Scaffold(
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
    );
  }
}
