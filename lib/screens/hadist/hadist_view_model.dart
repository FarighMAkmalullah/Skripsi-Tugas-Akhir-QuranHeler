import 'package:flutter/material.dart';
import 'package:quranhealer/models/hadist/hadist_mode.dart';
import 'package:quranhealer/services/hadist/hadist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HadistViewModel extends ChangeNotifier {
  final HadistService _apiService = HadistService();
  List<Hadist> _hadistlist = [];

  List<Hadist> get hadistlist => _hadistlist;

  Future<void> fetchHadistViewModel() async {
    try {
      final ApiHadistResponse hadistData = await _apiService.fetchHadistData();

      _hadistlist = hadistData.data;

      notifyListeners();
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  // get note

  final CollectionReference notes =
      FirebaseFirestore.instance.collection('hadist');

  // read
  Stream<QuerySnapshot> getNotesStream() {
    final notesStream = notes.orderBy('id').snapshots();
    return notesStream;
  }
}
