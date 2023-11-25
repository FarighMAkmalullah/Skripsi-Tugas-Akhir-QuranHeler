import 'package:flutter/material.dart';

class DashboarViewModel with ChangeNotifier {
  String kotaAdzan = "KAB. BANTUL";
  String kodeKota = "1501";

  void setKotaAdzan(String kotaAdzanValue, kodeKotaValue) {
    kotaAdzan = kotaAdzanValue;
    kodeKota = kodeKotaValue;
    notifyListeners();
  }
}
