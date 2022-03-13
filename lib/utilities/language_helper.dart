import 'package:flutter/material.dart';

class LanguageHelper {
  convertLangNameToLocale(String lang) {
    Locale convertedLocale;
    switch (lang) {
      case 'English':
        convertedLocale = const Locale('en', 'EN');
        break;

      case 'Korean':
        convertedLocale = const Locale('ko', 'KR');
        break;

      default:
        convertedLocale = const Locale('en', 'EN');
    }
    return convertedLocale;
  }

  convertLocaleToLangName(String locale) {
    String langName;
    switch (locale) {
      case 'en':
        langName = 'English';
        break;
      case 'ko':
        langName = 'Korean';
        break;
      default:
        langName = 'English';
    }
    return langName;
  }
}
