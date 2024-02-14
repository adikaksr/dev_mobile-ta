import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class PresensiService {
  List<dynamic> presensiData = [];

  Future<void> loadPresensiData() async {
    String jsonString = await rootBundle.loadString('assets/presensi.json');
    presensiData = jsonDecode(jsonString);
  }

  List<dynamic> getFilteredData(DateTime currentDate, String selectedTime) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);

    return presensiData.where((item) {
      return item['date'] == formattedDate && item['time'] == selectedTime;
    }).toList();
  }
}
