import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quranhealer/models/message/message.dart';
import 'dart:developer';

class ChatService extends ChangeNotifier {
  //mendapatkan instace firestore dan mendapatkan auh
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  //mendapatkan user stream / mendapatkan semua data ustadz
  Stream<List<Map<String, dynamic>>> getUserStream() {
    try {
      return _firestore.collection("Ustadz").snapshots().map((snapshot) {
        return snapshot.docs.map((e) {
          //untuk go setiap individual user
          final user = e.data();
          return user;
        }).toList();
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  // Metode untuk memeriksa apakah dokumen dengan emailuser sudah ada
  Future<bool> doesUserExistInChatRoomUstadz(int idUstadz, int idUser) async {
    DocumentSnapshot documentSnapshot = await _firestore
        .collection("UserChatRoom_$idUstadz")
        .doc(idUser.toString())
        .get();
    return documentSnapshot.exists;
  }

  // mengirim data user ke ustadz
  Future<void> addUserToChatRoomUstadz(
    String emailuser,
    String nameuser,
    String emailustadz,
    int nameVisibility,
    String gender,
    int idUstadz,
    int idUser,
  ) async {
    bool userExists = await doesUserExistInChatRoomUstadz(idUstadz, idUser);
    log('userExists : $userExists');
    if (userExists) {
      incrementNotfUstadz(emailustadz, emailuser, idUstadz, idUser);
      incrementNotfUstadzAll(emailustadz, idUstadz);
    } else {
      try {
        return _firestore
            .collection("UserChatRoom_$idUstadz")
            .doc(idUser.toString())
            .set({
          'email': emailuser,
          'name': nameuser,
          'notfuser': 0,
          'notfustadz': 1,
          'namevisibility': nameVisibility,
          'timestamp': Timestamp.now(),
          'gender': gender,
          'user_id': idUser,
        });
      } on FirebaseAuthException catch (e) {
        throw Exception(e.code);
      }
    }
  }

  //  mengirim chat ke ChatRoomUstadz
  //mengirim pesan
  Future<void> sendMessege(
      String message, emailustadz, emailuser, int idUstadz, int idUser) async {
    // get current user info
    final Timestamp timestamp = Timestamp.now();
    bool userExists = await doesUserExistInChatRoomUstadz(idUstadz, idUser);
    if (userExists) {
      readNotfUser(idUstadz, idUser);
    }
    log("$userExists");

    // create a new messege
    Message newMeggage = Message(
      senderID: idUser.toString(),
      senderEmail: emailuser,
      receiverID: idUstadz.toString(),
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

  //mendapatkan pesan

  Stream<QuerySnapshot> getMessage(
    String emailuser,
    emailustadz,
    int idUser,
    idUstadz,
    String type,
  ) {
    // construct a chatroom ID for this two users
    List<String> ids = [idUser.toString(), idUstadz.toString()];

    ids.sort();
    String chatRoomID = ids.join("_");

    return _firestore
        .collection("chat_rooms_$idUstadz")
        .doc(chatRoomID)
        .collection("message")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  Future<void> readNotfUstadz(
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

  Future<void> incrementNotfUstadz(
      String emailustadz, String emailuser, int idUstadz, int idUser) async {
    DocumentReference documentReference =
        _firestore.collection("UserChatRoom_$idUstadz").doc(idUser.toString());

    await _firestore.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);

      if (!snapshot.exists) {
        transaction.set(documentReference, {'notfustadz': 1});
      } else {
        int newNotfustadz = (snapshot.get('notfustadz') ?? 0) + 1;
        transaction.update(documentReference, {'notfustadz': newNotfustadz});
      }
    });
  }

  Future<void> incrementNotfUstadzAll(String emailustadz, int idUstadz) async {
    DocumentReference documentReference =
        _firestore.collection("Ustadz").doc(idUstadz.toString());

    await _firestore.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);

      if (!snapshot.exists) {
        transaction.set(documentReference, {'notifChat': 1});
      } else {
        int newNotfustadz = (snapshot.get('notifChat') ?? 0) + 1;
        transaction.update(documentReference, {'notifChat': newNotfustadz});
      }
    });
  }

  Future<void> readNotfUser(
    int idUstadz,
    int idUser,
  ) async {
    DocumentReference documentReference =
        _firestore.collection("UserChatRoom_$idUstadz").doc(idUser.toString());

    await _firestore.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);

      if (!snapshot.exists) {
        transaction.set(documentReference, {'notfuser': 0});
      } else {
        transaction.update(documentReference, {'notfuser': 0});
      }
    });
  }

  Stream<DocumentSnapshot> getNotfUser(int idUstadz, int idUser) {
    return _firestore
        .collection("UserChatRoom_$idUstadz")
        .doc(idUser.toString())
        .snapshots();
  }
}
