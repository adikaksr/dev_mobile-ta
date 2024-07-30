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
  File? _fileJIF01;
  File? _fileJIF02;
  File? _filePEN01;
  File? _filePEN02;
  File? _fileKRS;
  File? _fileTranskripSementara;
  File? _fileProposal;
  File? _fileBuktiKehadiran;

  Future<void> pickFileJIF01() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _fileJIF01 = File(result.files.single.path!);
      });
    }
  }

  Future<void> pickFileJIF02() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _fileJIF02 = File(result.files.single.path!);
      });
    }
  }

  Future<void> pickFilePEN01() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _filePEN01 = File(result.files.single.path!);
      });
    }
  }

  Future<void> pickFilePEN02() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _filePEN02 = File(result.files.single.path!);
      });
    }
  }

  Future<void> pickFileKRS() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _fileKRS = File(result.files.single.path!);
      });
    }
  }

  Future<void> pickFileTranskripSementara() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _fileTranskripSementara = File(result.files.single.path!);
      });
    }
  }

  Future<void> pickFileProposal() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _fileProposal = File(result.files.single.path!);
      });
    }
  }

  Future<void> pickFileBuktiKehadiran() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _fileBuktiKehadiran = File(result.files.single.path!);
      });
    }
  }

  // Future<void> _uploadFile(file) async {
  //   // Implement your file upload logic here
  //   // For example, upload to a server or Firebase Storage
  //   print('Uploading ${file?.path}');
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
                    CustomFilePicker(
                      title: 'JIF - 01',
                      pickFile: fileController.uploadfile,
                    ),
                    CustomFilePicker(
                      title: 'JIF - 02',
                      pickFile: fileController.uploadfile,
                    ),
                    // CustomFilePicker(
                    //   title: 'PEN - 01',
                    //   file: _filePEN01,
                    //   pickFile: pickFilePEN01,
                    // ),
                    // CustomFilePicker(
                    //   title: 'PEN - 02',
                    //   file: _filePEN02,
                    //   pickFile: pickFilePEN02,
                    // ),
                    // CustomFilePicker(
                    //   title: 'KRS',
                    //   file: _fileKRS,
                    //   pickFile: pickFileKRS,
                    // ),
                    // CustomFilePicker(
                    //   title: 'Transkrip Sementara',
                    //   file: _fileTranskripSementara,
                    //   pickFile: pickFileTranskripSementara,
                    // ),
                    // CustomFilePicker(
                    //   title: 'Berkas Proposal',
                    //   file: _fileProposal,
                    //   pickFile: pickFileProposal,
                    // ),
                    // CustomFilePicker(
                    //   title: 'Bukti Kehadiran',
                    //   file: _fileBuktiKehadiran,
                    //   pickFile: pickFileBuktiKehadiran,
                    // ),
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
