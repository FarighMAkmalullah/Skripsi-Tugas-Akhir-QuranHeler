import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quranhealer/models/post/post_model.dart';
import 'package:quranhealer/services/post/post_service.dart';
import 'package:rxdart/rxdart.dart';

class AllPostViewModel extends ChangeNotifier {
  var allPostController = BehaviorSubject<List<Post>>();
  late Timer timer1;
  Stream<List<Post>> get allPostStream => allPostController.stream;

  bool _isTimerActive = false;

  StreamSubscription<List<Post>>? subscription;

  void streamAllPostData() async {
    if (!_isTimerActive) {
      timer1 = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (!allPostController.isClosed) {
          getAllPostDataStream();
        } else {
          timer.cancel();
        }
      });
      _isTimerActive = true;
    }
  }

  void filterAllPostData(String keyword) {
    final List<Post> allData = allPostController.value;
    if (keyword.isEmpty) {
      allPostController.add(allData);
    } else {
      final List<Post> filteredData = allData
          .where((data) =>
              data.judul.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
      allPostController.add(filteredData);
    }
  }

  Future getAllPostDataStream() async {
    try {
      final List<Post> allPostData = await PostService.fetchPostData();
      allPostController.add(allPostData);
    } catch (error) {
      throw Exception('Error loading history data: $error');
    }
  }

  List<Post> _listAllPost = [];
  List<Post> get allPostData => _listAllPost;

  // Future getAllPostData() async {
  //   try {
  //     final List<Map<String, dynamic>> allPostData =
  //         await PostService.fetchPostData();

  //     _listAllPost = allPostData.map((item) => Post.fromJson(item)).toList();

  //     notifyListeners();
  //   } catch (error) {
  //     throw Exception('Gagal memuat all data post : $error');
  //   }
  // }

  void cancelTimer() {
    if (_isTimerActive) {
      timer1.cancel();
      _isTimerActive = false;
    }
  }

  void clearPostController() {
    // Menutup dan mengganti BehaviorSubject dengan instance baru
    if (!allPostController.isClosed) {
      allPostController.close();
    }
    allPostController = BehaviorSubject<List<Post>>();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   allPostController.close();
  //   subscription?.cancel();
  // }

  void clearAllPost() {
    _listAllPost.clear();
  }

  @override
  notifyListeners();
}
