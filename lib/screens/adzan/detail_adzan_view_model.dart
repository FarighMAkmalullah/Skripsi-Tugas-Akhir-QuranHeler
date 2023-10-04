import 'package:flutter/material.dart';
import 'package:quranhealer/models/adzan/detail_adzan_model.dart';
import 'package:quranhealer/services/adzan/detail_adzan_service.dart';

class DetailAdzanViewModel extends ChangeNotifier {
  JadwalAdzan? _detailAdzan;
  JadwalAdzan? get detailAdzan => _detailAdzan;

  Future<void> getAdzanDetail(String kode, String tanggal) async {
    try {
      final response = await DetailAdzanService.getDetailAdzan(kode, tanggal);

      if (response.statusCode == 200) {
        final responseData = response.data['jadwal']['data'];
        _detailAdzan = JadwalAdzan.fromJson(responseData);
        notifyListeners();
      } else {
        throw Exception(
            'Gagal memuat detail Adzan. Error code : ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Gagal memuat detail adzan : $error');
    }
  }
}
