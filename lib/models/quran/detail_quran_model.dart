class QuranData {
  final int code;
  final String message;
  final QuranInfo data;

  QuranData({
    required this.code,
    required this.message,
    required this.data,
  });

  factory QuranData.fromJson(Map<String, dynamic> json) {
    return QuranData(
      code: json['code'],
      message: json['message'],
      data: QuranInfo.fromJson(json['data']),
    );
  }
}

class QuranInfo {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;
  final String tempatTurun;
  final String arti;
  final String deskripsi;
  final Map<String, String> audioFull;
  final List<QuranAyat> ayat;
  final QuranSurat suratSelanjutnya;
  final bool suratSebelumnya;

  QuranInfo({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.audioFull,
    required this.ayat,
    required this.suratSelanjutnya,
    required this.suratSebelumnya,
  });

  factory QuranInfo.fromJson(Map<String, dynamic> json) {
    final audioFullMap = json['audioFull'] as Map<String, dynamic>;
    final audioFull = Map<String, String>.from(audioFullMap);

    final ayatList = json['ayat'] as List<dynamic>;
    final ayat = ayatList.map((item) => QuranAyat.fromJson(item)).toList();

    return QuranInfo(
      nomor: json['nomor'],
      nama: json['nama'],
      namaLatin: json['namaLatin'],
      jumlahAyat: json['jumlahAyat'],
      tempatTurun: json['tempatTurun'],
      arti: json['arti'],
      deskripsi: json['deskripsi'],
      audioFull: audioFull,
      ayat: ayat,
      suratSelanjutnya: QuranSurat.fromJson(json['suratSelanjutnya']),
      suratSebelumnya: json['suratSebelumnya'],
    );
  }
}

class QuranAyat {
  final int nomorAyat;
  final String teksArab;
  final String teksLatin;
  final String teksIndonesia;
  final Map<String, String> audio;

  QuranAyat({
    required this.nomorAyat,
    required this.teksArab,
    required this.teksLatin,
    required this.teksIndonesia,
    required this.audio,
  });

  factory QuranAyat.fromJson(Map<String, dynamic> json) {
    final audioMap = json['audio'] as Map<String, dynamic>;
    final audio = Map<String, String>.from(audioMap);

    return QuranAyat(
      nomorAyat: json['nomorAyat'],
      teksArab: json['teksArab'],
      teksLatin: json['teksLatin'],
      teksIndonesia: json['teksIndonesia'],
      audio: audio,
    );
  }
}

class QuranSurat {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;

  QuranSurat({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
  });

  factory QuranSurat.fromJson(Map<String, dynamic> json) {
    return QuranSurat(
      nomor: json['nomor'],
      nama: json['nama'],
      namaLatin: json['namaLatin'],
      jumlahAyat: json['jumlahAyat'],
    );
  }
}
