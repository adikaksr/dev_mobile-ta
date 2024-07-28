import 'dart:io';

import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class CustomFilePicker extends StatelessWidget {
  final String title;
  final File? file;
  final Function() pickFile;
  const CustomFilePicker({
    super.key,
    required this.title,
    required this.file,
    required this.pickFile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: TextStyle(
                color: kBlueColor,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
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
                  child: Text(
                    file == null
                        ? '-Pilih File-' // If no file is selected
                        : 'File: ${file!.path.split('/').last}',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ElevatedButton(
                  onPressed: pickFile,
                  child: Text(
                    'Upload',
                    style: TextStyle(
                      color: kGrayColor,
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
        )
      ],
    );
  }
}
