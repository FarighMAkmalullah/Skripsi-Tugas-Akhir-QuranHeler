import 'package:flutter/material.dart';
import 'package:quranhealer/models/post/post_model.dart';
import 'package:quranhealer/services/post/post_ustadz_service.dart';

class UstadzPostViewModel extends ChangeNotifier {
  List<Post?> _listUstadzPost = [];
  List<Post?> get allUstadzData => _listUstadzPost;

  void clearUstadzPost() {
    _listUstadzPost.clear();
  }

  Future getUstadzPostData({idUstadz}) async {
    try {
      final List<Map<String, dynamic>> allPostData =
          await PostUstadzService.fetchPostUstadzData(idUstadz: idUstadz);

      _listUstadzPost = allPostData.map((item) => Post.fromJson(item)).toList();

      notifyListeners();
    } catch (error) {
      throw Exception('Gagal memuat all data post : $error');
    }
  }

  void clearAllPost() {
    _listUstadzPost.clear();
  }

  @override
  notifyListeners();
}
