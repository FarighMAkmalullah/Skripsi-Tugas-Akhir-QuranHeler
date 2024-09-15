import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quranhealer/models/message/message.dart';

class LoginFirebaseService extends ChangeNotifier {
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
  Future<bool> doesUserExistInChatRoomUstadz(
      String emailustadz, String emailuser) async {
    DocumentSnapshot documentSnapshot = await _firestore
        .collection("UserChatRoom_$emailustadz")
        .doc(emailuser)
        .get();
    return documentSnapshot.exists;
  }

  // mengirim data user ke ustadz
  Future<void> addUserToChatRoomUstadz(String emailuser, String nameuser,
      String emailustadz, int nameVisibility, String gender) async {
    bool userExists =
        await doesUserExistInChatRoomUstadz(emailustadz, emailuser);
    if (userExists) {
      incrementNotfUstadz(emailustadz, emailuser);
      incrementNotfUstadzAll(emailustadz);
    } else {
      try {
        return _firestore
            .collection("UserChatRoom_$emailustadz")
            .doc(emailuser)
            .set({
          'email': emailuser,
          'name': nameuser,
          'notfuser': 0,
          'notfustadz': 0,
          'namevisibility': nameVisibility,
          'timestamp': Timestamp.now(),
          'gender': gender
        });
      } on FirebaseAuthException catch (e) {
        throw Exception(e.code);
      }
    }
  }

  //  mengirim chat ke ChatRoomUstadz
  //mengirim pesan
  Future<void> sendMessege(String message, emailustadz, emailuser) async {
    // get current user info
    final Timestamp timestamp = Timestamp.now();

    // create a new messege
    Message newMeggage = Message(
      senderID: emailuser,
      senderEmail: emailuser,
      receiverID: emailustadz,
      message: message,
      timestamp: timestamp,
    );

    // construct chat room ID for the two user ( sorted to ensure uniqueness )
    List<String> ids = [emailuser, emailustadz];
    ids.sort();
    String chatRoomID = ids.join("_");
    //  add new messege to database
    await _firestore
        .collection("chat_rooms_$emailustadz")
        .doc(chatRoomID)
        .collection("message")
        .add(newMeggage.toMap());
  }

  //mendapatkan pesan

  Stream<QuerySnapshot> getMessage(String emailuser, emailustadz) {
    // construct a chatroom ID for this two users
    List<String> ids = [emailuser, emailustadz];

    ids.sort();
    String chatRoomID = ids.join("_");

    return _firestore
        .collection("chat_rooms_$emailustadz")
        .doc(chatRoomID)
        .collection("message")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  Future<void> incrementNotfUstadz(String emailustadz, String emailuser) async {
    DocumentReference documentReference =
        _firestore.collection("UserChatRoom_$emailustadz").doc(emailuser);

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

  Future<void> incrementNotfUstadzAll(String emailustadz) async {
    DocumentReference documentReference =
        _firestore.collection("Ustadz").doc(emailustadz);

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
}
