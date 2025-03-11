import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = Locale('en'); // Default locale

  Locale get locale => _locale;

  void setLocale(Locale newLocale) {
    if (_locale == newLocale) return;
    _locale = newLocale;
    notifyListeners(); // Notify UI to rebuild
  }
}