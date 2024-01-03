import 'package:flutter/material.dart';

class EditProfilViewModel with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool isChecked = false;

  String gender = 'L';

  bool loading = false;

  void setGender(String value) {
    gender = value;
    notifyListeners();
  }

  void penggantiDispose() {
    isChecked = false;
    loading = false;
    gender = "L";
    emailController.text = '';

    nameController.text = '';

    notifyListeners();
  }

  void setEmailController(String value) {
    emailController.text = value;
  }

  void setNameController(String value) {
    nameController.text = value;
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }
}
