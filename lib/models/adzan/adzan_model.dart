class AdzanKota {
  final String id;
  final String nama;

  AdzanKota({
    required this.id,
    required this.nama,
  });

  factory AdzanKota.fromJson(Map<String, dynamic> json) {
    return AdzanKota(
      id: json['id'],
      nama: json['nama'],
    );
  }
}
