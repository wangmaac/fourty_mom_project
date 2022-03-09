
import 'package:flutter/material.dart';

class WelcomeTextController with ChangeNotifier {
  bool _showEntireText;

  WelcomeTextController(this._showEntireText);

  bool get getShow => _showEntireText;

  void setShowEntireText(bool value) {
    _showEntireText = value;
    notifyListeners();
  }
}
