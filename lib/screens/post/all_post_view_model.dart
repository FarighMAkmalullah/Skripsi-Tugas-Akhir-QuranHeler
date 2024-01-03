import 'package:flutter/material.dart';
import 'package:quranhealer/models/post/post_model.dart';
import 'package:quranhealer/services/post/post_service.dart';

class AllPostViewModel extends ChangeNotifier {
  List<Post> _listAllPost = [];
  List<Post> get allPostData => _listAllPost;

  Future getAllPostData() async {
    try {
      final List<Map<String, dynamic>> allPostData =
          await PostService.fetchPostData();

      _listAllPost = allPostData.map((item) => Post.fromJson(item)).toList();

      notifyListeners();
    } catch (error) {
      throw Exception('Gagal memuat all data post : $error');
    }
  }

  void clearAllPost() {
    _listAllPost.clear();
  }

  Post getPostById(int idPost) {
    return _listAllPost.firstWhere(
      (post) => post.id == idPost,
      // orElse: () => null,
    );
  }

  @override
  notifyListeners();
}
