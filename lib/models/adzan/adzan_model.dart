class AdzanListModel {
  final String id;
  final String lokasi;

  AdzanListModel({
    required this.id,
    required this.lokasi,
  });

  factory AdzanListModel.fromJson(Map<String, dynamic> json) {
    return AdzanListModel(
      id: json['id'],
      lokasi: json['lokasi'],
    );
  }
}
