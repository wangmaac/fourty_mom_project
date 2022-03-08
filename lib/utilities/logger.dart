import 'package:logger/logger.dart';
import 'dart:developer' as developer;

var logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    colors: true,
  ),
);

void ll(String message) {
  developer.log(message, name: '왕마악 로그');
}
