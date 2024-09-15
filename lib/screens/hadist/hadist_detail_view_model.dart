import 'package:flutter/material.dart';
import 'package:quranhealer/models/hadist/hadist_detail_model.dart';
import 'package:quranhealer/services/hadist/hadist_detail_service.dart';

class DetailHadistViewModel extends ChangeNotifier {
  HadistInfo? _detailHadist;
  HadistInfo? get detailHadist => _detailHadist;

  Future<void> getHadistDetail({
    required String hadist,
    required int nomorAwal,
    required int nomorAkhir,
  }) async {
    try {
      final response = await HadistService.getDetailHadist(
        hadist: hadist,
        nomorAwal: nomorAwal,
        nomorAkhir: nomorAkhir,
      );

      if (response.statusCode == 200) {
        final responseData = response.data['data'];
        _detailHadist = HadistInfo.fromJson(responseData);
        notifyListeners();
      } else {
        print(response.statusCode);
        throw Exception(
            'Gagal memuat detail Hadist. Error code : ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Gagal memuat detail Hadist : $error');
    }
  }
}
