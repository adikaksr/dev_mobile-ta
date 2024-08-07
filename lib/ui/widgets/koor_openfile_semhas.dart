import 'package:dio/dio.dart';
import 'package:easkripsi/shared/theme.dart';
import 'package:easkripsi/ui/widgets/pdf_preview_screen.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class KoorOpenfileSemhas extends StatelessWidget {
  final List<Map<String, dynamic>> mahasiswaWithBerkas;

  const KoorOpenfileSemhas({super.key, required this.mahasiswaWithBerkas});

  @override
  Widget build(BuildContext context) {
    Map<String, String> fileNames = {};
    for (var berkas in mahasiswaWithBerkas[0]['berkas']) {
      fileNames[berkas['id']] = berkas['fileName'];
    }

    Map<String, String> fileUrls = {};
    for (var berkas in mahasiswaWithBerkas[0]['berkas']) {
      fileUrls[berkas['id']] = berkas['downloadUrl'];
    }

    return Column(
      children: [
        FilePickerButton(
          fileType: 'Bukti Kehadiran (lembar belakang)',
          name: fileNames['Bukti Kehadiran (lembar belakang)'] ?? '',
          url: fileUrls['Bukti Kehadiran (lembar belakang)'] ?? '',
        ),
        const SizedBox(
          height: 12.0,
        ),
      ],
    );
  }
}

class FilePickerButton extends StatelessWidget {
  final String fileType;
  final String name;
  final String url;
  // final FileController fileController;

  const FilePickerButton({
    super.key,
    required this.fileType,
    required this.name,
    required this.url,
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      name.isEmpty ? 'Tidak ada file' : name,
                      overflow: TextOverflow.ellipsis,
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: light,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // if (url.isNotEmpty) {
                    //   _openFile(context, url);
                    // }
                    if (url.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PdfPreviewScreen(url: url),
                        ),
                      );
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Colors.grey, width: 1.0)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: Text(
                    'Preview',
                    style: grayTextStyle.copyWith(
                      fontSize: 14.0,
                      fontWeight: medium,
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

  void _openFile(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        // mode: LaunchMode.externalApplication,
        // webViewConfiguration:
        //     const WebViewConfiguration(enableJavaScript: false),
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  // void _downloadFile(BuildContext context, String url) async {
  //   try {
  //     Dio dio = Dio();
  //     var dir = await getApplicationDocumentsDirectory();
  //     String savePath = '${dir.path}/${url.split('/').last}';
  //     await dio.download(url, savePath);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('File downloaded to $savePath')),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to download file: $e')),
  //     );
  //   }
  // }
}
