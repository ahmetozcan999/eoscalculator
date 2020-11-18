import 'package:eoscalculator/models/compound.dart';
import 'package:flutter/material.dart';

class AppStateProvider with ChangeNotifier {
  Compound currentCompound = Compound();

  void changeCurrentCompound(Compound compound) {
    currentCompound = compound;
    notifyListeners();
  }
}
