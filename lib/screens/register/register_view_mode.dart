import 'package:flutter/material.dart';

class RegisterViewModel with ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isChecked = false;

  String gender = 'L';

  bool loading = false;

  void setGender(String value) {
    gender = value;
    notifyListeners();
  }

  void setChecked(bool value) {
    isChecked = value;
    notifyListeners();
  }

  void penggantiDispose() {
    isChecked = false;
    loading = false;
    gender = "L";
    emailController.text = '';

    passwordController.text = '';

    nameController.text = '';

    confirmPasswordController.text = '';
    notifyListeners();
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  // @override
  // void dispose() {
  //   emailController.dispose();
  //   passwordController.dispose();
  //   nameController.dispose();
  //   confirmPasswordController.dispose();
  //   super.dispose();
  // }
}
