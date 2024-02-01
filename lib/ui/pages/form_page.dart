import 'package:easkripsi/ui/pages/second_form_page.dart';
import 'package:easkripsi/ui/widgets/custom_button.dart';
import 'package:easkripsi/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class FormPage extends StatelessWidget {
  const FormPage({super.key});

  // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 10),
            child: Text(
              "Form",
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: medium,
              ),
            ),
          ),
        ),
        backgroundColor: kWhiteColor,
        elevation: 1,
      ),
      body: Stack(
        // key: _formKey,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const CustomTextFormField(
                      title: 'Nama Lengkap',
                      hintText: 'Nama Lengkap Anda',
                    ),
                    const CustomTextFormField(
                      title: 'Tempat/Tanggal Lahir',
                      hintText: 'Tempat/Tanggal Lahir Anda',
                    ),
                    const CustomTextFormField(
                      title: 'NPM',
                      hintText: 'NPM Anda',
                    ),
                    const CustomTextFormField(
                      title: 'Prodi/Jurusan',
                      hintText: 'Prodi/Jurusan Anda',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 30,
                        bottom: 70.0,
                      ),
                      child: CustomButton(
                          title: 'Selanjutnya',
                          onPressed: () {
                            // if (_formKey.currentState != null &&
                            //     _formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SecondFormPage()),
                            );
                          }
                          // },
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
