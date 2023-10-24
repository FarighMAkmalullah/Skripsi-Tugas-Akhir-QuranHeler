import 'package:flutter/material.dart';
import 'package:quranhealer/models/adzan/adzan_model.dart';
import 'package:quranhealer/services/adzan/adzan_service.dart';

class AdzanViewModel extends ChangeNotifier {
  final AdzanService _apiService = AdzanService();
  List<AdzanListModel> _adzanlist = [];

  List<AdzanListModel> get adzanlist => _adzanlist;

  Future<void> fetchAdzanViewModel() async {
    try {
      final List<Map<String, dynamic>> adzanData =
          await _apiService.fetchAdzanData();

      _adzanlist =
          adzanData.map((item) => AdzanListModel.fromJson(item)).toList();

      notifyListeners();
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
