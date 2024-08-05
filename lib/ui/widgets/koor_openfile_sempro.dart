import 'package:easkripsi/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/file_controller.dart';

class KoorOpenfileSempro extends StatelessWidget {
  // final fileController = Get.find<FileController>();
  final List<Map<String, dynamic>> mahasiswaWithBerkas;

  const KoorOpenfileSempro({super.key, required this.mahasiswaWithBerkas});

  @override
  Widget build(BuildContext context) {
    print('OpenFile: ${mahasiswaWithBerkas[0]}');
    return Column(
      children: [
        FilePickerButton(
          fileType: 'JIF-01',
          name: ''.obs,
        ),
        const SizedBox(
          height: 12.0,
        ),
        FilePickerButton(
          fileType: 'JIF-02',
          name: ''.obs,
        ),
        const SizedBox(
          height: 12.0,
        ),
        FilePickerButton(
          fileType: 'PEN-01',
          name: ''.obs,
        ),
        const SizedBox(
          height: 12.0,
        ),
        FilePickerButton(
          fileType: 'PEN-02',
          name: ''.obs,
        ),
        const SizedBox(
          height: 12.0,
        ),
        FilePickerButton(
          fileType: 'KRS',
          name: ''.obs,
        ),
        const SizedBox(
          height: 12.0,
        ),
        FilePickerButton(
          fileType: 'Transkrip Sementara',
          name: ''.obs,
        ),
        const SizedBox(
          height: 12.0,
        ),
        FilePickerButton(
          fileType: 'Berkas Proposal',
          name: ''.obs,
        ),
        const SizedBox(
          height: 12.0,
        ),
        FilePickerButton(
          fileType: 'Bukti Kehadiran',
          name: ''.obs,
        ),
        // Add more buttons for other file types as needed
      ],
    );
  }
}

class FilePickerButton extends StatelessWidget {
  final String fileType;
  final RxString name;
  // final FileController fileController;

  FilePickerButton({
    required this.fileType,
    // required this.fileController,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              fileType,
              style: TextStyle(
                color: kBlueColor,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(18.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Obx(() => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          name.value.isEmpty ? 'Tidak ada file' : name.value,
                          overflow: TextOverflow.ellipsis,
                          style: blackTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: light,
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
