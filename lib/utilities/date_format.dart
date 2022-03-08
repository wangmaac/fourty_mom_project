import 'package:intl/intl.dart';

final int _timeLineItemCount = 30;

final DateFormat _dateFormat = DateFormat.MMMd();

final DateFormat _eDateFormat = DateFormat.MEd();

DateFormat get dateFormat => _dateFormat;

DateFormat get eDateFormat => _eDateFormat;

int get timeLineItemCount => _timeLineItemCount;
