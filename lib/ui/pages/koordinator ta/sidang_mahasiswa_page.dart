import 'dart:io';

import 'package:easkripsi/controller/file_controller.dart';
import 'package:easkripsi/ui/pages/second_form_page.dart';
import 'package:easkripsi/ui/widgets/custom_button.dart';
import 'package:easkripsi/ui/widgets/custom_filepicker.dart';
import 'package:easkripsi/ui/widgets/custom_text_form_field.dart';
import 'package:easkripsi/ui/widgets/koor_openfile_sempro.dart';
import 'package:easkripsi/ui/widgets/koor_openfile_sidang.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../shared/theme.dart';
import '../../shared/theme.dart';

class SidangMahasiswaPage extends StatefulWidget {
  final List<Map<String, dynamic>> mahasiswaWithBerkas;
  const SidangMahasiswaPage({super.key, required this.mahasiswaWithBerkas});

  @override
  State<SidangMahasiswaPage> createState() => _SidangMahasiswaPageState();
}

class _SidangMahasiswaPageState extends State<SidangMahasiswaPage> {
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
              "Form Sidang Tugas Akhir",
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
                    KoorOpenfileSidang(
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
