class HadistData {
  final int code;
  final String message;
  final HadistInfo data;

  HadistData({
    required this.code,
    required this.message,
    required this.data,
  });

  factory HadistData.fromJson(Map<String, dynamic> json) {
    return HadistData(
      code: json['code'],
      message: json['message'],
      data: HadistInfo.fromJson(json['data']),
    );
  }
}

class HadistInfo {
  final String name;
  final String id;
  final int available;
  final int requested;
  final List<HadistAyat> hadist;

  HadistInfo({
    required this.available,
    required this.name,
    required this.id,
    required this.requested,
    required this.hadist,
  });

  factory HadistInfo.fromJson(Map<String, dynamic> json) {
    final hadistList = json['hadiths'] as List<dynamic>;
    final hadist = hadistList.map((item) => HadistAyat.fromJson(item)).toList();
    return HadistInfo(
      available: json['available'],
      id: json['id'],
      name: json['name'],
      requested: json['requested'],
      hadist: hadist,
    );
  }
}

class HadistAyat {
  final int number;
  final String arab;
  final String id;

  HadistAyat({
    required this.number,
    required this.arab,
    required this.id,
  });

  factory HadistAyat.fromJson(Map<String, dynamic> json) {
    return HadistAyat(
      number: json['number'],
      arab: json['arab'],
      id: json['id'],
    );
  }
}
