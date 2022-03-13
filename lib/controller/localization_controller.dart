import 'package:flutter/material.dart';
import 'package:fourty_mom_project/utilities/language_helper.dart';

class MyLocalizationController extends ChangeNotifier {
  late String _currentLanguage;
  Locale _locale = Locale('ko');

  LanguageHelper languageHelper = LanguageHelper();

  Locale get getLocale => _locale;

  void changeLocale(String newLocale) {
    Locale convertedLocale;
    _currentLanguage = newLocale;

    convertedLocale = languageHelper.convertLangNameToLocale(newLocale);
    _locale = convertedLocale;
    notifyListeners();
  }

  defineCurrentLanguage(context) {
    String definedCurrentLanguage;

    if (_currentLanguage != null) {
      definedCurrentLanguage = _currentLanguage;
    } else {
      print(
          "locale from currentData: ${Localizations.localeOf(context).toString()}");
      definedCurrentLanguage = languageHelper
          .convertLocaleToLangName(Localizations.localeOf(context).toString());
    }
    return definedCurrentLanguage;
  }
}
