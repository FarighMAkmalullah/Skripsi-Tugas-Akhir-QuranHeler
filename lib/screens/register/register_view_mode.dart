import 'package:flutter/material.dart';

class RegisterViewModel with ChangeNotifier {
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
    notifyListeners();
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  bool _obscureText = true;

  bool get obscureText => _obscureText;

  void toggleObscureText() {
    _obscureText = !_obscureText;
    notifyListeners();
  }

  bool _obscureText2 = true;

  bool get obscureText2 => _obscureText2;

  void toggleObscureText2() {
    _obscureText2 = !_obscureText2;
    notifyListeners();
  }
}
