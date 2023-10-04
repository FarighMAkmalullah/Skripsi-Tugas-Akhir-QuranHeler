class JadwalAdzan {
  final String ashar;
  final String dhuha;
  final String dzuhur;
  final String imsak;
  final String isya;
  final String maghrib;
  final String subuh;
  final String tanggal;
  final String terbit;

  JadwalAdzan({
    required this.ashar,
    required this.dhuha,
    required this.dzuhur,
    required this.imsak,
    required this.isya,
    required this.maghrib,
    required this.subuh,
    required this.tanggal,
    required this.terbit,
  });

  factory JadwalAdzan.fromJson(Map<String, dynamic> json) {
    return JadwalAdzan(
      ashar: json['ashar'],
      dhuha: json['dhuha'],
      dzuhur: json['dzuhur'],
      imsak: json['imsak'],
      isya: json['isya'],
      maghrib: json['maghrib'],
      subuh: json['subuh'],
      tanggal: json['tanggal'],
      terbit: json['terbit'],
    );
  }
}
