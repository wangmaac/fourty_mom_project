import 'package:flutter/cupertino.dart';

class DateController with ChangeNotifier {
  final _baseDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime _selectDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  DateTime get getSelectDate => _selectDate;
  DateTime get getBaseDate => _baseDate;

  void setSelectDate(DateTime date) {
    _selectDate = date;
    notifyListeners();
  }
}
