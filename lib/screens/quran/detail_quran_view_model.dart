import 'package:flutter/material.dart';
import 'package:quranhealer/models/quran/detail_quran_model.dart';
import 'package:quranhealer/services/quran/detail_quran_service.dart';

class DetailSurahViewModel extends ChangeNotifier {
  QuranInfo? _detailSurah;
  QuranInfo? get detailSurah => _detailSurah;

  Future<void> getSurahDetail(int? nomor) async {
    try {
      final response = await DetailService.getDetailSurah(nomor);

      if (response.statusCode == 200) {
        final responseData = response.data['data'];
        _detailSurah = QuranInfo.fromJson(responseData);
        notifyListeners();
      } else {
        throw Exception(
            'Gagal memuat detail surah. Error code : ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Gagal memuat detail surah : $error');
    }
  }
}
