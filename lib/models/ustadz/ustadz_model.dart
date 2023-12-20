class UstadzData {
  final int userId;
  final String name;
  final String spesialisasi;
  final String gender;

  UstadzData({
    required this.userId,
    required this.name,
    required this.spesialisasi,
    required this.gender,
  });

  factory UstadzData.fromJson(Map<String, dynamic> json) {
    return UstadzData(
      userId: json['user_id'],
      name: json['name'],
      spesialisasi: json['spesialisasi'],
      gender: json['gender'],
    );
  }
}
