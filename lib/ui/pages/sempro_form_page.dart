import 'dart:io';

import 'package:easkripsi/controller/file_controller.dart';
import 'package:easkripsi/ui/pages/second_form_page.dart';
import 'package:easkripsi/ui/widgets/custom_button.dart';
import 'package:easkripsi/ui/widgets/custom_filepicker.dart';
import 'package:easkripsi/ui/widgets/custom_text_form_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../shared/theme.dart';

class SemproFormPage extends StatefulWidget {
  const SemproFormPage({super.key});

  @override
  State<SemproFormPage> createState() => _SemproFormPageState();
}

class _SemproFormPageState extends State<SemproFormPage> {
  final fileController = Get.find<FileController>();
  final _formKey = GlobalKey<FormState>();

  // Future<void> pickFileJIF01() async {
  //   final result = await FilePicker.platform.pickFiles();
  //   if (result != null) {
  //     setState(() {
  //       _fileJIF01 = File(result.files.single.path!);
  //     });
  //   }
  // }

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
              "Form Seminar Proposal",
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
                    CustomFilePicker(),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 30,
                        bottom: 45.0,
                        left: 8,
                      ),
                      child: CustomButton(
                          title: 'Selesai',
                          onPressed: () {
                            // if (_formKey.currentState != null &&
                            //     _formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SecondFormPage()),
                            );
                          }),
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
