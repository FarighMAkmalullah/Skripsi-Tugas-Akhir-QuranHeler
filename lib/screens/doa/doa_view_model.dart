import 'package:flutter/material.dart';
import 'package:quranhealer/models/doa/doa_model.dart';
import 'package:quranhealer/services/doa/doa_service.dart';

class DoaViewModel extends ChangeNotifier {
  final DoaService _apiService = DoaService();
  List<DoaModel> _doalist = [];

  List<DoaModel> get doalist => _doalist;

  Future<void> fetchDoaViewModel() async {
    try {
      final List<Map<String, dynamic>> doaData =
          await _apiService.fetchDoaData();

      _doalist = doaData.map((item) => DoaModel.fromJson(item)).toList();

      notifyListeners();
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
