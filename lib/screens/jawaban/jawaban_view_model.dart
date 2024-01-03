import 'package:flutter/material.dart';
import 'package:quranhealer/models/jawaban/detail_post_model.dart';
import 'package:quranhealer/services/jawaban/jawaban_service.dart';

class JawabanViewModel extends ChangeNotifier {
  List<Comment?> _listJawaban = [];
  List<Comment?> get allJawaban => _listJawaban;

  Future getAllJawaban({idPost}) async {
    try {
      final List<Map<String, dynamic>> allPostData =
          await JawabanService.fetchJawabanData(idPost: idPost);

      _listJawaban = allPostData.map((item) => Comment.fromJson(item)).toList();

      notifyListeners();
    } catch (error) {
      throw Exception('Gagal memuat all data post : $error');
    }
    notifyListeners();
  }

  void clearJawaban() {
    _listJawaban.clear();
  }

  @override
  notifyListeners();
}
