import 'dart:convert';

import 'package:easkripsi/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DataOrtu extends StatefulWidget {
  const DataOrtu({Key? key}) : super(key: key);

  @override
  State<DataOrtu> createState() => _DataOrtuState();
}

class _DataOrtuState extends State<DataOrtu> {
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
                      "Nama Ayah",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      userData['nama_ayah'] ?? 'Unknown Nama Ayah',
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
                      "Nama Ibu",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      userData['nama_ibu'] ?? 'Unknown Nama Ibu',
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
                      "Alamat Orangtua",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      userData['alamat_ortu'] ?? 'Unknown Alamat Orangtua',
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
                      "Status Hidup Ayah",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      userData['status_h_ayah'] ?? 'Unknown Status Hidup Ayah',
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
                      "Status Hidup Ibu",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      userData['status_h_ibu'] ?? 'Unknown Status Hidup Ibu',
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
                      "Pendidikan Ayah",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      userData['pend_ayah'] ?? 'Unknown Pendidikan Ayah',
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
                      "Pendidikan Ibu",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      userData['pend_ibu'] ?? 'Unknown Pendidikan Ibu',
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
                      "Nomor HP Ayah",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      userData['hp_ayah'] ?? 'Unknown Nomor HP Ayah',
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
                      "Nomor HP Ibu",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      userData['hp_ibu'] ?? 'Unknown Nomor HP Ibu',
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
                      "Nomor HP Wali",
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
                        userData['hp_wali'] ?? 'Unknown Nomor HP Wali',
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
