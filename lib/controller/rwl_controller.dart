import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class RWLController with ChangeNotifier {
  int _selectRWL = 0;

  int get getRWL => _selectRWL;

  void setRWL(int value) {
    _selectRWL = value;
    notifyListeners();
  }
}
