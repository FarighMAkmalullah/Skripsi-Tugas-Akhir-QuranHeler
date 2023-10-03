import 'package:flutter/material.dart';
import 'package:quranhealer/models/adzan/adzan_model.dart';
import 'package:quranhealer/services/adzan/adzan_service.dart';

class AdzanViewModel extends ChangeNotifier {
  final AdzanService _apiService = AdzanService();
  List<AdzanListModel> _quranlist = [];

  List<AdzanListModel> get quranlist => _quranlist;

  Future<void> fetchAdzanViewModel() async {
    try {
      final List<Map<String, dynamic>> quranData =
          await _apiService.fetchAdzanData();

      _quranlist =
          quranData.map((item) => AdzanListModel.fromJson(item)).toList();

      notifyListeners();
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
