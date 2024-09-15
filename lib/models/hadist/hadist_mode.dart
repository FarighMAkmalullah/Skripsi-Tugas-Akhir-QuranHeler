class Hadist {
  final String name;
  final String id;
  final int available;

  Hadist({
    required this.name,
    required this.id,
    required this.available,
  });

  factory Hadist.fromJson(Map<String, dynamic> json) {
    return Hadist(
      name: json['name'],
      id: json['id'],
      available: json['available'],
    );
  }
}

class ApiHadistResponse {
  final int code;
  final String message;
  final List<Hadist> data;
  final bool error;

  ApiHadistResponse({
    required this.code,
    required this.message,
    required this.data,
    required this.error,
  });

  factory ApiHadistResponse.fromJson(Map<String, dynamic> json) {
    return ApiHadistResponse(
      code: json['code'],
      message: json['message'],
      data:
          List<Hadist>.from(json['data'].map((book) => Hadist.fromJson(book))),
      error: json['error'],
    );
  }
}
