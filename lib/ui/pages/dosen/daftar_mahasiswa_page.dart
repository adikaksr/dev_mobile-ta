import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easkripsi/controller/text_controller.dart';
import 'package:easkripsi/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/daftar_mahasiswa_controller.dart';
import '../../widgets/mahasiswa_tile.dart';

class DaftarMahasiswaPage extends GetView<DaftarMahasiswaController> {
  final TextController textController = Get.find<TextController>();

  DaftarMahasiswaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Mahasiswa'),
      ),
      body: Container(
        margin: const EdgeInsets.only(
          top: 0,
          left: 20,
          right: 20,
        ),
        color: kBGColor,
        child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: controller.getMahasiswa(textController.nipDosen.value),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('Belum ada mahasiswa'),
              );
            }
            var getMahasiswa = snapshot.data!.docs;
            getMahasiswa.sort((a, b) => a['name'].compareTo(b['name']));
            return ListView.builder(
              itemCount: getMahasiswa.length,
              itemBuilder: (context, index) {
                var data = getMahasiswa[index].data();

                return MahasiswaTile(
                  name: data['name'],
                  status: data['connection'],
                  imageUrl: 'assets/Acatar.png',
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class Mahasiswa {
  final String name;
  final String status;
  final String imageUrl;

  Mahasiswa({required this.name, required this.status, required this.imageUrl});
}
