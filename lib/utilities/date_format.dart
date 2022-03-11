import 'package:intl/intl.dart';

final int _timeLineItemCount = 30;

final DateFormat _dateFormat = DateFormat.MMMd();

final DateFormat _eDateFormat = DateFormat.MEd();

final DateFormat _mmmDateFormat = DateFormat.MMM(); //영어 월

final DateFormat _dDateFormat = DateFormat.d(); //일자

final DateFormat _mDateFormat = DateFormat.E();

final DateFormat _normalFormat = DateFormat('yyyyMMdd');

DateFormat get dateFormat => _dateFormat;

DateFormat get mmmDateFormat => _mmmDateFormat;

DateFormat get eDateFormat => _eDateFormat;

DateFormat get dDateFormat => _dDateFormat;

DateFormat get mDateFormat => _mDateFormat;

DateFormat get normalFormat => _normalFormat;

int get timeLineItemCount => _timeLineItemCount;
