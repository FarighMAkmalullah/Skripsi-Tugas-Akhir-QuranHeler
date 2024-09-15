import 'package:cloud_firestore/cloud_firestore.dart';

class IqroViewModel {
  // read
  Stream<QuerySnapshot> getNotesStream({required int id}) {
    final notesStream = FirebaseFirestore.instance
        .collection('iqro/$id/halaman')
        .orderBy('id')
        .snapshots();
    return notesStream;
  }
}
