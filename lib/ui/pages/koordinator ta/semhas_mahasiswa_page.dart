import 'dart:io';

import 'package:easkripsi/controller/file_controller.dart';
import 'package:easkripsi/ui/pages/second_form_page.dart';
import 'package:easkripsi/ui/widgets/custom_button.dart';
import 'package:easkripsi/ui/widgets/custom_filepicker.dart';
import 'package:easkripsi/ui/widgets/custom_text_form_field.dart';
import 'package:easkripsi/ui/widgets/koor_openfile_semhas.dart';
import 'package:easkripsi/ui/widgets/koor_openfile_sempro.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../shared/theme.dart';
import '../../shared/theme.dart';

class SemhasMahasiswaPage extends StatefulWidget {
  final List<Map<String, dynamic>> mahasiswaWithBerkas;
  const SemhasMahasiswaPage({super.key, required this.mahasiswaWithBerkas});

  @override
  State<SemhasMahasiswaPage> createState() => _SemhasMahasiswaPageState();
}

class _SemhasMahasiswaPageState extends State<SemhasMahasiswaPage> {
  final fileController = Get.find<FileController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print(widget.mahasiswaWithBerkas);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 10),
            child: Text(
              "Form Seminar Hasil",
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
        key: _formKey,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    KoorOpenfileSemhas(
                      mahasiswaWithBerkas: widget.mahasiswaWithBerkas,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 30,
                        bottom: 45.0,
                        left: 8,
                      ),
                      child: CustomButton(title: 'Selesai', onPressed: () {}),
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
