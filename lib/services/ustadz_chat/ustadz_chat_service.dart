import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quranhealer/models/message/message.dart';

class ChatUstadzService extends ChangeNotifier {
  //mendapatkan instace firestore dan mendapatkan auh
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //mendapatkan user stream / mendapatkan semua data user
  Stream<List<Map<String, dynamic>>> getUserStream(
      String emailustadz, int idUstadz) {
    return _firestore.collection("UserChatRoom_$idUstadz").snapshots().map(
      (snapshot) {
        return snapshot.docs.map((e) {
          //untuk go setiap individual user
          final user = e.data();
          return user;
        }).toList();
      },
    );
  }

  // Metode untuk memeriksa apakah dokumen dengan emailuser sudah ada
  Future<bool> doesUserExistInChatRoomUstadz(
      String emailustadz, String emailuser, int idUstadz, int idUser) async {
    DocumentSnapshot documentSnapshot = await _firestore
        .collection("UserChatRoom_$idUstadz")
        .doc(idUser.toString())
        .get();
    return documentSnapshot.exists;
  }

  //  mengirim chat ke ChatRoomUstadz
  //mengirim pesan
  Future<void> sendMessege(
    String message,
    emailustadz,
    emailuser,
    int idUstadz,
    int idUser,
  ) async {
    // get current user info
    final Timestamp timestamp = Timestamp.now();

    // create a new messege
    Message newMeggage = Message(
      senderID: idUstadz.toString(),
      senderEmail: emailustadz,
      receiverID: idUser.toString(),
      message: message,
      timestamp: timestamp,
    );

    // construct chat room ID for the two user ( sorted to ensure uniqueness )
    List<String> ids = [idUser.toString(), idUstadz.toString()];
    ids.sort();
    String chatRoomID = ids.join("_");
    //  add new messege to database
    await _firestore
        .collection("chat_rooms_$idUstadz")
        .doc(chatRoomID)
        .collection("message")
        .add(newMeggage.toMap());
  }

  // ubah notifikasi
  //mendapatkan user stream / mendapatkan semua data user
  Stream<List<Map<String, dynamic>>> getNotificationStream(
      String emailustadz, int idUstadz) {
    return _firestore.collection("UserChatRoom_$idUstadz").snapshots().map(
      (snapshot) {
        return snapshot.docs.map((e) {
          //untuk go setiap individual user
          final user = e.data();
          return user;
        }).toList();
      },
    );
  }

  Future<void> readNotfUstadz(
    String emailustadz,
    String emailuser,
    int idUstadz,
    int idUser,
  ) async {
    DocumentReference documentReference =
        _firestore.collection("UserChatRoom_$idUstadz").doc(idUser.toString());

    await _firestore.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);

      if (!snapshot.exists) {
        transaction.set(documentReference, {'notfustadz': 0});
      } else {
        transaction.update(documentReference, {'notfustadz': 0});
      }
    });
  }

  Future<void> readNotfUstadzAll(
      String emailustadz, int notifUstadz, int idUstadz) async {
    DocumentReference documentReference =
        _firestore.collection("Ustadz").doc(idUstadz.toString());

    await _firestore.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);

      if (!snapshot.exists) {
        transaction.set(documentReference, {'notifChat': 0});
      } else {
        int newNotfustadz = (snapshot.get('notifChat') ?? 0) - notifUstadz;
        transaction.update(documentReference, {'notifChat': newNotfustadz});
      }
    });
  }

  Stream<DocumentSnapshot> getNotfUstadzAll(String emailustadz, int idUstadz) {
    return _firestore.collection("Ustadz").doc(idUstadz.toString()).snapshots();
  }

  Future<void> incrementNotfUser(
      String emailustadz, String emailuser, int idUstadz, int idUser) async {
    DocumentReference documentReference =
        _firestore.collection("UserChatRoom_$idUstadz").doc(idUser.toString());

    await _firestore.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);

      if (!snapshot.exists) {
        transaction.set(documentReference, {'notfuser': 1});
      } else {
        int newNotfustadz = (snapshot.get('notfuser') ?? 0) + 1;
        transaction.update(documentReference, {'notfuser': newNotfustadz});
      }
    });
  }
}
