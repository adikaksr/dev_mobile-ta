import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class PdfPreviewScreen extends StatefulWidget {
  final String url;

  const PdfPreviewScreen({Key? key, required this.url}) : super(key: key);

  @override
  _PdfPreviewScreenState createState() => _PdfPreviewScreenState();
}

class _PdfPreviewScreenState extends State<PdfPreviewScreen> {
  String? localPath;

  @override
  void initState() {
    super.initState();
    _downloadFile();
  }

  Future<void> _downloadFile() async {
    try {
      Dio dio = Dio();
      var dir = await getApplicationDocumentsDirectory();
      String savePath = '${dir.path}/${widget.url.split('/').last}';
      await dio.download(widget.url, savePath);
      setState(() {
        localPath = savePath;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load file: $e')),
      );
    }
  }

  // void _openFile(BuildContext context, String url) async {
  //   final Uri uri = Uri.parse(url);
  //   if (await canLaunchUrl(uri)) {
  //     await launchUrl(
  //       uri,
  //       // mode: LaunchMode.externalApplication,
  //       // webViewConfiguration:
  //       //     const WebViewConfiguration(enableJavaScript: false),
  //     );
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  void _openFile(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        // Fallback to in-app web view if external application launch fails
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.inAppWebView);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not launch $url')),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Preview'),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () => _openFile(context, widget.url),
          ),
        ],
      ),
      body: localPath == null
          ? Center(child: CircularProgressIndicator())
          : PDFView(
              filePath: localPath!,
            ),
    );
  }
}
