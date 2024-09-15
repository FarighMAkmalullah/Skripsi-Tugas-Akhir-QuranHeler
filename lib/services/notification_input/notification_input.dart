import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NotificationInputService extends ChangeNotifier {
  //mendapatkan instace firestore dan mendapatkan auh
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  //mendapatkan user stream / mendapatkan semua data ustadz
  Stream<List<Map<String, dynamic>>> getTokenUstadzSteam(int idUstadz) {
    try {
      return _firestore
          .collection("Ustadz")
          .doc(idUstadz.toString())
          .collection("tokenNotification")
          .snapshots()
          .map((snapshot) {
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

  Stream<List<Map<String, dynamic>>> getTokenUserSteam(int idUstadz) {
    try {
      return _firestore
          .collection("User")
          .doc(idUstadz.toString())
          .collection("tokenNotification")
          .snapshots()
          .map((snapshot) {
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

  // mengirim data user ke ustadz
  Future<void> addTokenNotificationUstadz(
    String token,
    int idUstadz,
  ) async {
    try {
      return _firestore
          .collection("Ustadz")
          .doc(idUstadz.toString())
          .collection("tokenNotification")
          .doc(token)
          .set({
        'token': token,
      });
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // mengirim data user
  Future<void> addUser(int idUser, String email) async {
    try {
      return _firestore.collection("User").doc(idUser.toString()).set({
        'user_id': idUser,
        'email': email,
      });
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // mengirim data user ke ustadz
  Future<void> addTokenNotificationUser(
    String token,
    int idUser,
  ) async {
    try {
      return _firestore
          .collection("User")
          .doc(idUser.toString())
          .collection("tokenNotification")
          .doc(token)
          .set({
        'token': token,
      });
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> deleteNotificationTokenUstadz(String token, int idUstadz) async {
    return _firestore
        .collection("Ustadz")
        .doc(idUstadz.toString())
        .collection("tokenNotification")
        .doc(token)
        .delete();
  }

  Future<void> deleteNotificationTokenUser(String token, int idUstadz) async {
    return _firestore
        .collection("User")
        .doc(idUstadz.toString())
        .collection("tokenNotification")
        .doc(token)
        .delete();
  }
}
