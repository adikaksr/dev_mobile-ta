import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easkripsi/controller/koorta_controller.dart';
import 'package:easkripsi/shared/theme.dart';
import 'package:easkripsi/ui/pages/koordinator%20ta/pilih_seminar_mahasiswa_page.dart';
import 'package:easkripsi/ui/widgets/berkas_mahasiswa.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/mahasiswa_tile.dart';

class DaftarBerkasMahasiswaPage extends GetView<KoortaController> {
  const DaftarBerkasMahasiswaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Mahasiswa'),
      ),
      body: Container(
        margin: const EdgeInsets.only(
          top: 5,
          left: 20,
          right: 20,
        ),
        color: kBGColor,
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: controller.getMahasiswa(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No Mahasiswa with berkas found'),
              );
            }
            var mahasiswaWithBerkas = snapshot.data!;
            // print(mahasiswaWithBerkas[0].data());
            mahasiswaWithBerkas.sort((a, b) => a['name'].compareTo(b['name']));
            return ListView.builder(
              itemCount: mahasiswaWithBerkas.length,
              itemBuilder: (context, index) {
                var data = mahasiswaWithBerkas[index];
                // var mahasiswaID = mahasiswaWithBerkas[index].id;
                return InkWell(
                  onTap: () {
                    var selectedMahasiswa = mahasiswaWithBerkas
                        .where((mahasiswa) =>
                            mahasiswa['nimNip'] == data['nimNip'])
                        .toList();
                    Get.to(() => PilihSeminarMahasiswaPage(
                        mahasiswaWithBerkas: selectedMahasiswa));
                  },
                  child: BerkasMahasiswa(
                    name: data['name'],
                    status: data['nimNip'],
                    imageUrl: 'assets/Acatar.png',
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
