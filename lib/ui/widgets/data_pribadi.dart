import 'dart:convert';

import 'package:easkripsi/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DataPribadi extends StatefulWidget {
  DataPribadi({Key? key}) : super(key: key);

  @override
  State<DataPribadi> createState() => _DataPribadiState();
}

class _DataPribadiState extends State<DataPribadi> {
  final storage = FlutterSecureStorage();
  Map<String, dynamic> userData = {};

  @override
  void initState() {
    super.initState();
    _readData().then((data) {
      setState(() {
        userData = data;
      });
    });
  }

  Future<Map<String, dynamic>> _readData() async {
    String value = await storage.read(key: 'user') ?? '{}';
    try {
      Map<String, dynamic> data = jsonDecode(value);
      return data;
    } catch (e) {
      print('Error parsing JSON: $e');
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: kGreyColor),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "NPM",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      userData['nimNip'] ?? 'Unknown NIM',
                      style: TextStyle(
                        color: kBlackColor,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: kGreyColor,
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Telepon",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      userData['telepon'] ?? 'Unknown Telepon',
                      style: TextStyle(
                        color: kBlackColor,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: kGreyColor,
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Jenis Kelamin",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      userData['jk'] ?? 'Unknown Jenis Kelamin',
                      style: TextStyle(
                        color: kBlackColor,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: kGreyColor,
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tempat Lahir",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      userData['tempat_lahir'] ?? 'Unknown Tempat Lahir',
                      style: TextStyle(
                        color: kBlackColor,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: kGreyColor,
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tanggal Lahir",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      userData['tanggal_lahir'] ?? 'Unknown Tanggal Lahir',
                      style: TextStyle(
                        color: kBlackColor,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: kGreyColor,
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Agama",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      userData['agama'] ?? 'Unknown Agama',
                      style: TextStyle(
                        color: kBlackColor,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: kGreyColor,
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Alamat Sekarang",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      child: Text(
                        userData['alamat'] ?? 'Unknown Alamat',
                        textAlign: TextAlign.end,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: kBlackColor,
                          fontFamily: 'Public Sans',
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
