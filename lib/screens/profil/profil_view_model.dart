import 'package:flutter/material.dart';
import 'package:quranhealer/models/profil/profil_model.dart';
import 'package:quranhealer/services/profil/profil_service.dart';

class ProfilViewModel extends ChangeNotifier {
  UserData? _detailUser;
  UserData? get detailUser => _detailUser;

  Future getProfilDetail() async {
    try {
      final response = await ProfilService.getDetailUser();

      if (response.statusCode == 200) {
        final responseData = response.data['result'];
        _detailUser = UserData.fromJson(responseData as Map<String, dynamic>);
        notifyListeners();
      } else {
        throw Exception(
            'Gagal memuat detail user. Error code : ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Gagal memuat detail user : $error');
    }
  }
}
