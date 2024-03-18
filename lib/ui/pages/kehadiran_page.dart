import 'package:flutter/material.dart';
import '../../shared/theme.dart';
import 'package:file_picker/file_picker.dart';

import '../widgets/dash_border_painter.dart';

class KehadiranPage extends StatelessWidget {
  const KehadiranPage({super.key});

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;

      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
      print(file.path);
    } else {
      // User canceled the picker
    }
  }

  Widget filePickerContainer(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20, top: 20),
          child: Text(
            title,
            style: blackTextStyle.copyWith(
              fontSize: 18,
              fontWeight: medium,
            ),
          ),
        ),
        Stack(
          children: [
            Container(
              width: double.infinity, // Set the width of the Container
              height: 200, // Set the height of the Container
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xFFD9EBFD),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            CustomPaint(
              size:
                  Size(double.infinity, 200), // Set the size of the CustomPaint
              painter: DashedBorderPainter(),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Icon(Icons.upload_file,
                          size: 50,
                          color: Color(
                              0xFF3392F1)), // Upload icon with color #3392F1
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 5,
                      ), // Set the margin
                      child: Text(
                        'Unggah bukti $title disini',
                        style: blackTextStyle.copyWith(
                          fontSize: 13,
                          fontWeight: medium,
                        ),
                      ), // Text
                    ),
                    Container(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: pickFile,
                        child: Text(
                          "Browse",
                          style: blueTextStyle.copyWith(
                            fontSize: 13,
                            fontWeight: medium,
                            decoration: TextDecoration.underline,
                            decorationColor: kPrimaryColor,
                          ),
                        ), // Button
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 15, bottom: 10),
              child: Text(
                "Kehadiran",
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
      ),
      body: Column(
        children: <Widget>[
          filePickerContainer('Page 1'),
          SizedBox(height: 20), // Add some space between the containers
          filePickerContainer('Page 2'),
        ],
      ),
    );
  }
}
