import 'package:easkripsi/ui/pages/home_page.dart';
import 'package:easkripsi/ui/widgets/custom_button.dart';
import 'package:easkripsi/ui/widgets/custom_dropdown.dart';
import 'package:easkripsi/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import '../../controller/login_controller.dart';
import '../../shared/theme.dart';
import 'register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _selectedRole;
  LoginController loginController = LoginController();
  final idInput = TextEditingController();
  final passwordInput = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final _auth = FirebaseAuth.instance;

  set _isLoading(bool _isLoading) {}

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
      String role =
          await loginController.login(nimNip, password, _selectedRole!);

      // Hide the loading indicator
      _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();

      if (role == 'Mahasiswa') {
        Navigator.pushReplacementNamed(context, '/main');
      } else if (role == 'Dosen') {
        Navigator.pushReplacementNamed(context, '/main-dosen');
      } else if (role == 'Koordinator TA') {
        Navigator.pushReplacementNamed(context, '/main-koorta');
      } else if (role == 'Operator') {
        Navigator.pushReplacementNamed(context, '/main-operator');
      } else {
        // Show an error message
        _scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(content: Text('Failed to login')),
        );
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
            _selectedRole = value;
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
        // return CustomButton(
        //   title: 'Masuk',
        //   onPressed: () async {
        //     setState(() {
        //       _isLoading = true;
        //     });
        //     try {
        //       final navigator = Navigator.of(context);
        //       final _emailController = TextEditingController();
        //       final email = _emailController.text;
        //       final _passwordController = TextEditingController();
        //       final password = _passwordController.text;
        //       await _auth.signInWithEmailAndPassword(
        //           email: email, password: password);
        //       // Replace 'path_to_chat_page.dart' with the actual file path

        //       var ChatPage;
        //       navigator.pushReplacementNamed(ChatPage.id);
        //     } catch (e) {
        //       final snackbar = SnackBar(content: Text(e.toString()));
        //       ScaffoldMessenger.of(context).showSnackBar(snackbar);
        //     } finally {
        //       setState(() {
        //         _isLoading = false;
        //       });
        //     }
        //   },
        //   // onPressed: () {
        //   //   if (_selectedRole == 'Pilih Login Sebagai') {
        //   //     ScaffoldMessenger.of(context).showSnackBar(
        //   //       SnackBar(content: Text('Mohon pilih user')),
        //   //     );
        //   //   } else if (_selectedRole == 'Mahasiswa') {
        //   //     Navigator.push(
        //   //       context,
        //   //       MaterialPageRoute(builder: (context) => MainPage()),
        //   //     );
        //   //   } else if (_selectedRole == 'Dosen') {
        //   //     Navigator.push(
        //   //       context,
        //   //       MaterialPageRoute(builder: (context) => MainPageDosen()),
        //   //     );
        //   //   } else if (_selectedRole == 'Koordinator TA') {
        //   //     Navigator.push(
        //   //       context,
        //   //       MaterialPageRoute(builder: (context) => KoordinatorTAPage()),
        //   //     );
        //   //   } else if (_selectedRole == 'Operator') {
        //   //     Navigator.push(
        //   //       context,
        //   //       MaterialPageRoute(builder: (context) => OperatorPage()),
        //   //     );
        //   //   }
        //   // },
        // );
        ElevatedButton(
          onPressed: () async {
            try {
              final _emailController = TextEditingController();
              final _passwordController = TextEditingController();
              final email = _emailController.text;
              final password = _passwordController.text;

              // Sign in the user
              final userCredential =
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: email,
                password: password,
              );

              // Navigate to the home page if the sign in was successful
              if (userCredential.user != null) {
                Navigator.pushReplacementNamed(context, '/home');
              }
            } catch (e) {
              // Handle the error
              // ...
            }
          },
          child: Text('Login'),
        );
      }

      Widget regisButton() {
        return GestureDetector(
          onTap: () {
            // Navigate to the registration page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterPage()),
            );
          },
          child: Text(
            'Daftar',
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
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
            idForm(),
            passwordForm(),
            loginButton(),
            regisButton()
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
