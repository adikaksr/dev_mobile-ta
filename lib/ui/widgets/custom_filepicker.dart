import 'package:easkripsi/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/file_controller.dart';

class CustomFilePicker extends StatelessWidget {
  final fileController = Get.find<FileController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FilePickerButton(
          fileType: 'JIF-01',
          fileController: fileController,
          name: ''.obs,
        ),
        const SizedBox(
          height: 12.0,
        ),
        FilePickerButton(
          fileType: 'JIF-02',
          fileController: fileController,
          name: ''.obs,
        ),
        const SizedBox(
          height: 12.0,
        ),
        FilePickerButton(
          fileType: 'PEN - 01',
          fileController: fileController,
          name: ''.obs,
        ),
        const SizedBox(
          height: 12.0,
        ),
        FilePickerButton(
          fileType: 'PEN - 02',
          fileController: fileController,
          name: ''.obs,
        ),
        const SizedBox(
          height: 12.0,
        ),
        FilePickerButton(
          fileType: 'KRS',
          fileController: fileController,
          name: ''.obs,
        ),
        const SizedBox(
          height: 12.0,
        ),
        FilePickerButton(
          fileType: 'Transkrip Sementara',
          fileController: fileController,
          name: ''.obs,
        ),
        const SizedBox(
          height: 12.0,
        ),
        FilePickerButton(
          fileType: 'Berkas Proposal',
          fileController: fileController,
          name: ''.obs,
        ),
        const SizedBox(
          height: 12.0,
        ),
        FilePickerButton(
          fileType: 'Bukti Kehadiran',
          fileController: fileController,
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
  final FileController fileController;

  FilePickerButton({
    required this.fileType,
    required this.fileController,
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
                  child: Obx(() => Text(
                        name.value.isEmpty ? '-Pilih File-' : name.value,
                        overflow: TextOverflow.ellipsis,
                      )),
                ),
                ElevatedButton(
                  onPressed: () {
                    fileController.uploadFile(fileType, name);
                  },
                  child: Text(
                    'Upload',
                    style: grayTextStyle.copyWith(
                      fontSize: 14.0,
                      fontWeight: medium,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    side: MaterialStateProperty.all(
                        BorderSide(color: Colors.grey, width: 1.0)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
