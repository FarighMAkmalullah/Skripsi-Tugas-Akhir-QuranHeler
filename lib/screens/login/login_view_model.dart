import 'package:flutter/material.dart';

class LoginViewModel with ChangeNotifier {
  bool loading = false;

  bool _obscureText = true;

  bool get obscureText => _obscureText;

  void toggleObscureText() {
    _obscureText = !_obscureText;
    notifyListeners();
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }
}
