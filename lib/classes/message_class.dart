import 'package:intl/intl.dart';

class Messages {
  String get appName => Intl.message('Flutter APP', name: 'appName');
  String get helloWorld => Intl.message("Hello World", name: 'helloWorld');

  hello(str) => Intl.message("hello $str!", name: 'hello', args: [str]);
}
