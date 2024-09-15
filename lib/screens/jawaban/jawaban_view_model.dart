import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quranhealer/models/jawaban/detail_post_model.dart';
import 'package:quranhealer/models/post/post_model.dart';
import 'package:quranhealer/services/jawaban/jawaban_service.dart';
import 'package:quranhealer/services/post/personal_post_service.dart';
import 'package:rxdart/rxdart.dart';

class JawabanViewModel extends ChangeNotifier {
  var personalPostController = BehaviorSubject<PostDetail>();
  late Timer timer1;
  bool isTimerActive = false;

  final PersonalPostService _personalPostService = PersonalPostService();

  Stream<PostDetail> get personalPostStream => personalPostController.stream;

  void streamAllPostData({required int idPost}) {
    print('Memanggil Stream : $isTimerActive');
    if (!isTimerActive) {
      timer1 = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (!personalPostController.isClosed) {
          getPersonalPostDataStream(idPost: idPost);
        } else {
          timer.cancel();
        }
      });
      isTimerActive = true;
    }
  }

  Future<void> getPersonalPostDataStream({required int idPost}) async {
    try {
      final PostDetail post =
          await _personalPostService.fetchPost(idPost: idPost);
      personalPostController.add(post);
    } catch (error) {
      // Hanya tambahkan error jika BehaviorSubject belum ditutup
      if (!personalPostController.isClosed) {
        personalPostController.addError('Error loading post data: $error');
      }
    }
  }

  void cancelTimer() {
    if (isTimerActive) {
      timer1.cancel();
      isTimerActive = false;
    }
    if (isTimerActive2) {
      timer2.cancel();
      isTimerActive2 = false;
    }
  }

  void clearPostController() {
    // Menutup dan mengganti BehaviorSubject dengan instance baru
    if (!personalPostController.isClosed) {
      personalPostController.close();
    }
    personalPostController = BehaviorSubject<PostDetail>();
    if (!commentPostController.isClosed) {
      commentPostController.close();
    }
    commentPostController = BehaviorSubject<List<Comment>>();
  }

  // @override
  // void dispose() {
  //   personalPostController.close();
  //   if (isTimerActive) {
  //     timer1.cancel();
  //   }
  //   commentPostController.close();
  //   if (isTimerActive2) {
  //     timer2.cancel();
  //   }
  //   super.dispose();
  // }

  // List<Comment?> _listJawaban = [];
  // List<Comment?> get allJawaban => _listJawaban;

  // Future getAllJawaban({idPost}) async {
  //   try {
  //     final List<Map<String, dynamic>> allPostData =
  //         await JawabanService.fetchJawabanData(idPost: idPost);

  //     _listJawaban = allPostData.map((item) => Comment.fromJson(item)).toList();

  //     notifyListeners();
  //   } catch (error) {
  //     throw Exception('Gagal memuat all data post : $error');
  //   }
  //   notifyListeners();
  // }

  // void clearJawaban() {
  //   _listJawaban.clear();
  // }

  var commentPostController = BehaviorSubject<List<Comment>>();
  late Timer timer2;
  bool isTimerActive2 = false;

  Stream<List<Comment>> get commentPostStream => commentPostController.stream;

  void streamCommentPostData({required int idPost}) {
    if (!isTimerActive2) {
      timer2 = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (!commentPostController.isClosed) {
          getCommentPostDataStream(idPost: idPost);
        } else {
          timer2.cancel();
        }
      });
      isTimerActive2 = true;
    }
  }

  Future<void> getCommentPostDataStream({required int idPost}) async {
    try {
      final List<Comment> comment =
          await JawabanService.fetchJawabanData(idPost: idPost);
      // Hanya tambahkan data jika BehaviorSubject belum ditutup
      if (!commentPostController.isClosed) {
        commentPostController.add(comment);
      }
    } catch (error) {
      // Hanya tambahkan error jika BehaviorSubject belum ditutup
      if (!commentPostController.isClosed) {
        commentPostController.addError('Error loading post data: $error');
      }
    }
  }

  @override
  notifyListeners();
}
