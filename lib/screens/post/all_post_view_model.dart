import 'package:flutter/material.dart';
import 'package:quranhealer/models/post/post_model.dart';
import 'package:quranhealer/models/ustadz/ustadz_model.dart';
import 'package:quranhealer/services/post/post_service.dart';
import 'package:quranhealer/services/uztads/ustadz_service.dart';

class AllPostViewModel extends ChangeNotifier {
  List<Post?> _listAllPost = [];
  List<Post?> get allPostData => _listAllPost;

  Future getAllPostData() async {
    try {
      final List<Map<String, dynamic>> allPostData =
          await PostService.fetchPostData();

      _listAllPost = allPostData.map((item) => Post.fromJson(item)).toList();
      print(_listAllPost[0]);

      notifyListeners();
    } catch (error) {
      throw Exception('Gagal memuat all data post : $error');
    }
  }

  @override
  notifyListeners();
}
