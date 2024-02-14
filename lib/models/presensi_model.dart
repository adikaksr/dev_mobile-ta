class Jadwal {
  final String date;
  final String time;
  final Presensi presensi;

  Jadwal({required this.date, required this.time, required this.presensi});

  factory Jadwal.fromJson(Map<String, dynamic> json) {
    return Jadwal(
      date: json['date'],
      time: json['time'],
      presensi: Presensi.fromJson(json['presensi']),
    );
  }
}

class Presensi {
  final String dosen;
  final String status;

  Presensi({required this.dosen, required this.status});

  factory Presensi.fromJson(Map<String, dynamic> json) {
    return Presensi(
      dosen: json['dosen'],
      status: json['status'],
    );
  }
}
