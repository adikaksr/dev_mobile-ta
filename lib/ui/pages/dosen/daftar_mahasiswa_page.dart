import 'package:easkripsi/shared/theme.dart';
import 'package:flutter/material.dart';
import '../../widgets/mahasiswa_tile.dart';

class DaftarMahasiswaPage extends StatelessWidget {
  final List<Mahasiswa> mahasiswaList = [
    Mahasiswa(
        name: 'Mahasiswa 1', status: 'Status 1', imageUrl: 'assets/Acatar.png'),
    Mahasiswa(
        name: 'Mahasiswa 2', status: 'Status 2', imageUrl: 'assets/Acatar.png'),
    Mahasiswa(
        name: 'Mahasiswa 3', status: 'Status 3', imageUrl: 'assets/Acatar.png'),
    // Add more mahasiswa here
  ];

  DaftarMahasiswaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Mahasiswa'),
      ),
      body: Container(
        color: kBGColor,
        child: ListView.builder(
          itemCount: mahasiswaList.length,
          itemBuilder: (context, index) {
            return MahasiswaTile(
              name: mahasiswaList[index].name,
              status: mahasiswaList[index].status,
              imageUrl: mahasiswaList[index].imageUrl,
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
