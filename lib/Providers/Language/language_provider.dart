import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/translation_controller.dart';
import '../../model/services/SharedPreference/shared_preference.dart';

class LanguageProvider extends ChangeNotifier {

  int _selectedIndex = 2; // Default selection
  bool _isBouncing = false;
  Map<String, String> _localizedStrings = {};
  String _selectedLanguage = 'en';
  static const String languageKey = 'selected_language';
  static const String languageIndex = 'selected_language_index';

  final TranslationController translationController = Get.put(TranslationController());


  int get selectedIndex => _selectedIndex;
  bool get isBouncing => _isBouncing;
  String get selectedLanguage => _selectedLanguage;
  Map<String, String> get localizedStrings => _localizedStrings;


  // Fetch translation for a specific key
  String translate(String key) {
    return _localizedStrings[key] ?? key; // Return key if translation not found
  }

  Future<void> loadLanguage(String languageCode) async {
    final sharedPreferenceService = await SharedPreferencesService.getInstance();


    _selectedLanguage = languageCode;
    String jsonString = await rootBundle.loadString('assets/translations/$languageCode.json');
    log("************$languageCode******************");
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));

    // Save selected language to SharedPreferences
    await sharedPreferenceService.setString(languageKey, languageCode);

    log(_selectedLanguage);
    log(_selectedIndex.toString());
    notifyListeners();
  }

  // Load the saved language on app start
  Future<void> loadSavedLanguage() async {

    final sharedPreferenceService = await SharedPreferencesService.getInstance();

    String? savedLanguage =  sharedPreferenceService.getString(languageKey) ?? "en";
    int? savedIndex =  sharedPreferenceService.getInt(languageIndex) ?? 0;


    // If no language is saved, default to English
    if (savedLanguage != null) {
      await loadLanguage(savedLanguage);
      _selectedIndex = savedIndex ?? 3;
      log(savedIndex.toString());
      log(savedLanguage);
      notifyListeners();
    } else {
      await loadLanguage('en');
    }
  }

  Future<void> selectButton(int index) async {
    final _sharedPreferenceService = await SharedPreferencesService.getInstance();

    _selectedIndex = index;
    final sharedPreferenceService = await SharedPreferencesService.getInstance();
    await sharedPreferenceService.setInt(languageIndex, _selectedIndex);
    _isBouncing = true;
    notifyListeners();
  }

}