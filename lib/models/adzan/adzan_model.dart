class AdzanListModel {
  final String id;
  final String nama;

  AdzanListModel({
    required this.id,
    required this.nama,
  });

  factory AdzanListModel.fromJson(Map<String, dynamic> json) {
    return AdzanListModel(
      id: json['id'],
      nama: json['nama'],
    );
  }
}
