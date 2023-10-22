import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:totalis_admin/utils/device.dart';

class LanguageService extends ChangeNotifier {
  final _LanguagePrefs _prefs = _LanguagePrefs();
  Locale? _locale;

  LanguageService() {
    _prefs.getLanguage().then((language) {
      _applyLocaleAndNotify(language != null ? Locale(language) : null);
    });
  }

  Future<void> _applyLocaleAndNotify(Locale? value) async {
    if (_locale != value) {
      _locale = value;
      notifyListeners();
    }
  }

  Locale? get customLocale => _locale;

  Locale get locale => customLocale ?? appLocale();


  Future<void> setLanguage(String language) => _prefs
      .setLanguage(language)
      .then((_) => _applyLocaleAndNotify(Locale(language)));
}

class _LanguagePrefs {
  static const keyLanguage = "keyLanguagePrefs";

  Future<SharedPreferences> _prefs() => SharedPreferences.getInstance();

  Future<void> setLanguage(String language) =>
      _prefs().then((prefs) => prefs.setString(keyLanguage, language));

  Future<String?> getLanguage() =>
      _prefs().then((prefs) => prefs.getString(keyLanguage));
}
