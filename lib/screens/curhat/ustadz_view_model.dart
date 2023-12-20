import 'package:flutter/material.dart';
import 'package:quranhealer/models/ustadz/ustadz_model.dart';
import 'package:quranhealer/services/uztads/ustadz_service.dart';

class UstadzViewModel extends ChangeNotifier {
  List<UstadzData?> _listUstadz = [];
  List<UstadzData?> get detailUstadz => _listUstadz;

  Future getUstadzDetail() async {
    try {
      final List<Map<String, dynamic>> ustadzData =
          await UstadzService.fetchDetailUstadz();

      _listUstadz =
          ustadzData.map((item) => UstadzData.fromJson(item)).toList();

      notifyListeners();
    } catch (error) {
      throw Exception('Gagal memuat detail ustadz : $error');
    }
  }
}
