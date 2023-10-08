class DoaModel {
  final String title;
  final String arabic;
  final String latin;
  final String translation;

  DoaModel({
    required this.title,
    required this.arabic,
    required this.latin,
    required this.translation,
  });

  factory DoaModel.fromJson(Map<String, dynamic> json) {
    return DoaModel(
      title: json['title'],
      arabic: json['arabic'],
      latin: json['latin'],
      translation: json['translation'],
    );
  }
}
