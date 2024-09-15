import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quranhealer/models/post/post_model.dart';
import 'package:quranhealer/services/post/post_ustadz_service.dart';
import 'package:rxdart/rxdart.dart';

class UstadzPostViewModel extends ChangeNotifier {
  var ustadzPostController = BehaviorSubject<List<Post>>();
  late Timer timer1;
  Stream<List<Post>> get ustadzPostStream => ustadzPostController.stream;

  bool _isTimerActive = false;

  StreamSubscription<List<Post>>? subscription;

  void streamUstadzPostData({idUstadz}) async {
    if (!_isTimerActive) {
      timer1 = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (!ustadzPostController.isClosed) {
          getUstadzPostDataStream(idUstadz: idUstadz);
        } else {
          timer.cancel();
        }
      });
      _isTimerActive = true;
    }
  }

  void filterUstadzPostData(String keyword) {
    print("Keyword : $keyword");
    final List<Post> allData = ustadzPostController.value;
    if (keyword.isEmpty) {
      ustadzPostController.add(allData);
    } else {
      final List<Post> filteredData = allData
          .where((data) =>
              data.judul.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
      ustadzPostController.add(filteredData);
    }
  }

  Future getUstadzPostDataStream({idUstadz}) async {
    try {
      final List<Post> allPostData =
          await PostUstadzService.fetchPostUstadzData(idUstadz: idUstadz);
      ustadzPostController.add(allPostData);
    } catch (error) {
      throw Exception('Error loading history data: $error');
    }
  }

  void clearPostController() {
    // Menutup dan mengganti BehaviorSubject dengan instance baru
    if (!ustadzPostController.isClosed) {
      ustadzPostController.close();
    }
    ustadzPostController = BehaviorSubject<List<Post>>();
  }

  void cancelTimer() {
    if (_isTimerActive) {
      timer1.cancel();
      _isTimerActive = false;
    }
  }

  List<Post?> _listUstadzPost = [];
  List<Post?> get allUstadzData => _listUstadzPost;

  void clearUstadzPost() {
    _listUstadzPost.clear();
  }

  // Future getUstadzPostData({idUstadz}) async {
  //   try {
  //     final List<Map<String, dynamic>> allPostData =
  //         await PostUstadzService.fetchPostUstadzData(idUstadz: idUstadz);

  //     _listUstadzPost = allPostData.map((item) => Post.fromJson(item)).toList();

  //     notifyListeners();
  //   } catch (error) {
  //     throw Exception('Gagal memuat all data post : $error');
  //   }
  // }

  void clearAllPost() {
    _listUstadzPost.clear();
  }

  @override
  notifyListeners();
}
