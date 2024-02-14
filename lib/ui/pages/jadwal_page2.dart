import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import '../../models/presensi_model.dart';

class JadwalPage2 extends StatefulWidget {
  @override
  _JadwalPage2State createState() => _JadwalPage2State();
}

class _JadwalPage2State extends State<JadwalPage2> {
  List<Jadwal> jadwalList = [];

  @override
  void initState() {
    super.initState();
    loadJadwalData();
  }

  void loadJadwalData() async {
    String jsonString = await rootBundle.loadString('assets/presensi.json');
    List<dynamic> jsonList = jsonDecode(jsonString);
    jadwalList = jsonList.map((json) => Jadwal.fromJson(json)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal Seminar'),
      ),
      body: ListView.builder(
        itemCount: jadwalList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
                'Date: ${jadwalList[index].date}, Time: ${jadwalList[index].time}'),
            subtitle: Text(
                'Dosen: ${jadwalList[index].presensi.dosen}, Status: ${jadwalList[index].presensi.status}'),
          );
        },
      ),
    );
  }
}
