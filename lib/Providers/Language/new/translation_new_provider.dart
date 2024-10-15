import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:tabibinet_project/model/api_services/api_services.dart';
import 'package:tabibinet_project/model/api_services/url/baseurl.dart';
import 'package:tabibinet_project/model/services/SharedPreference/shared_preference.dart';

import '../../../model/services/translation_services.dart';


class TranslationNewProvider with ChangeNotifier {
  String translatedText = "";
  String doctorText = "";
  String currentLanguage = "ar";
  Map<String, String> translatedTexts = {};

  int MAX_TEXTS_PER_REQUEST = 100;
  int MAX_CHARACTERS_PER_REQUEST = 5000;

  final String _apiKey = BaseUrl.API_KEY;

  final TranslationService _translationService = TranslationService();
  Map<String, String> translations = {};
  bool isLoading = false;

  Map<String, String> notificationTranslationList = {};
  bool isNotification = false;

  Map<String, String> faqList = {};
  bool isFaq = false;

  Map<String, String> feeList = {};
  bool isFee = false;

  Map<String, String> prescriptionPatientList = {};
  bool isPatient = false;

  Map<String, String> appointmentList = {};
  bool isAppointment = false;

  Map<String, String> medicationList = {};
  bool isMedication = false;

  Map<String, String> chatRoomList = {};
  bool isChatRoom = false;

  Map<String, String> doctorPatientList = {};
  bool isDoctorPatient = false;

  Map<String, String> appointmentRemainder = {};
  bool isAppointmentRemainder = false;

  Map<String, String> paymentCardList = {};
  bool isPayment = false;

  final Map<String, String> languages = {
    'English': 'en',
    'Arabic': 'ar',
    'French': 'fr',
    'Spanish': 'es',
  };

  void changeLanguage(String language) {
    currentLanguage = languages[language] ?? 'en';
    notifyListeners(); // Notify listeners that language has changed
  }

  Future<String?> translateSingleText(String text, {String? targetLanguage}) async {
    final pref = await SharedPreferencesService.getInstance();
    String language = pref.getString("language") ?? "en";

    if (translatedTexts.containsKey(text) && translatedTexts[text]?.contains(targetLanguage ?? language) == true) {
      return translatedTexts[text];
    }

    try {
      final String url =
          '${BaseUrl.BASEURL_TRANSLATOR}$targetLanguage&key=$_apiKey&q=${Uri.encodeComponent(text)}';
      final response = await ApiService.get(
          endPoint: url,
          headers: BaseUrl.headers
      );
      log("STATUS CODE:: ${response.statusCode}");
      log("BODY:: ${response.body}");
      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        translatedText = decodedResponse['data']['translations'][0]['translatedText'];
        translatedTexts[text] = translatedText; // Store the translation
        log("TRANSLATE:: $translatedText");
        notifyListeners(); // Notify listeners of changes
        return translatedText;
      } else {
        translatedText = text; // Fallback to original text
        translatedTexts[text] = text; // Store original text as translation
        notifyListeners();
        return null;
      }
    } catch (e) {
      log("Error: ${e.toString()}");
      return null;
    }
  }

  Future<void> translateMultiple(List<String> texts, {String? targetLanguage}) async {
    translatedTexts.clear();
    final pref = await SharedPreferencesService.getInstance();
    String language = pref.getString("language") ?? "en";

    try {
      final String url = '${BaseUrl.BASEURL_TRANSLATOR}$language&key=$_apiKey';

      final body = {
        'q': texts,
      };

      final response = await ApiService.post(
          requestBody: body, headers: BaseUrl.headers, endPoint: url);
      log("STATUS CODE:: ${response.statusCode}");
      log("BODY:: ${response.body}");
      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        List<dynamic> translations = decodedResponse['data']['translations'];

        // Store the translated texts in the map
        translatedTexts = {
          for (int i = 0; i < texts.length; i++)
            texts[i]: translations[i]['translatedText'] ?? texts[i]
        };
        log("TRANSLATE MULTIPLE:: ${translatedTexts}");
        notifyListeners(); // Notify listeners of updates
      } else {
        translatedTexts = {
          for (var text in texts) text: text,
        };
        notifyListeners();
      }
    } catch (e) {
      log("Error in translateMultiple: $e");
    }
  }

  Future<void> translateHomeDoctor(List<String> texts) async {
    isLoading = true;
    try {
      var result = await _translationService.translateMultiple(texts);
      translations = result;
    } finally {
      isLoading = false;
      notifyListeners(); // Notify listeners of completed loading
    }
  }

  Future<void> translateNotification(List<String> texts) async {
    isNotification = true;
    try {
      var result = await _translationService.translateMultiple(texts);
      notificationTranslationList = result;
    } finally {
      isNotification = false;
      notifyListeners();
    }
  }

  Future<void> translateFaq(List<String> texts) async {
    isFaq = true;
    try {
      var result = await _translationService.translateMultiple(texts);
      faqList = result;
    } finally {
      isFaq = false;
      notifyListeners();
    }
  }

  Future<void> translateFees(List<String> texts) async {
    isFee = true;
    try {
      var result = await _translationService.translateMultiple(texts);
      feeList = result;
    } finally {
      isFee = false;
      notifyListeners();
    }
  }

  Future<void> translatePatientPrescription(List<String> texts) async {
    isPatient = true;
    try {
      var result = await _translationService.translateMultiple(texts);
      prescriptionPatientList = result;
    } finally {
      isPatient = false;
      notifyListeners();
    }
  }

  Future<void> translateAppointment(List<String> texts) async {
    isAppointment = true;
    try {
      var result = await _translationService.translateMultiple(texts);
      appointmentList = result;
    } finally {
      isAppointment = false;
      notifyListeners();
    }
  }

  Future<void> translateMedication(List<String> texts) async {
    isMedication = true;
    try {
      var result = await _translationService.translateMultiple(texts);
      medicationList = result;
    } finally {
      isMedication = false;
      notifyListeners();
    }
  }

  Future<void> translateChatRoom(List<String> texts) async {
    isChatRoom = true;
    try {
      var result = await _translationService.translateMultiple(texts);
      chatRoomList = result;
    } finally {
      isChatRoom= false;
      notifyListeners();
    }
  }

  Future<void> translateDoctorPatient(List<String> texts) async {
    isDoctorPatient = true;
    try {
      var result = await _translationService.translateMultiple(texts);
      doctorPatientList = result;
    } finally {
      isDoctorPatient= false;
      notifyListeners();
    }
  }

  Future<void> translateAppointmentRemainder(List<String> texts) async {
    isAppointmentRemainder = true;
    try {
      var result = await _translationService.translateMultiple(texts);
      appointmentRemainder = result;
    } finally {
      isAppointmentRemainder= false;
      notifyListeners();
    }
  }

  Future<void> translatePaymentCard(List<String> texts) async {
    isPayment = true;
    try {
      var result = await _translationService.translateMultiple(texts);
      paymentCardList = result;
    } finally {
      isPayment= false;
      notifyListeners();
    }
  }

  void updateTranslations(List<String> texts, {String? targetLanguage}) {
    translateMultiple(texts, targetLanguage: targetLanguage);
  }

  void updateDoctorTranslation(List<String> texts, {String? targetLanguage}) async {
    translations.clear();
    var result = await _translationService.translateMultiple(texts, targetLanguage: targetLanguage);
    translations = result;
    notifyListeners();
  }

  void updateDoctorFaq(List<String> texts, {String? targetLanguage}) async {
    faqList.clear();
    var result = await _translationService.translateMultiple(texts, targetLanguage: targetLanguage);
    faqList = result;
    notifyListeners();
  }

  void updateFees(List<String> texts, {String? targetLanguage}) async {
    feeList.clear();
    var result = await _translationService.translateMultiple(texts, targetLanguage: targetLanguage);
    feeList = result;
    notifyListeners();
  }

  void updateNotification(List<String> texts, {String? targetLanguage}) async {
    notificationTranslationList.clear();
    var result = await _translationService.translateMultiple(texts, targetLanguage: targetLanguage);
    notificationTranslationList = result;
    notifyListeners();
  }


  void updatePatientPrescription(List<String> texts, {String? targetLanguage}) async {
    prescriptionPatientList.clear();
    var result = await _translationService.translateMultiple(texts, targetLanguage: targetLanguage);
    prescriptionPatientList = result;
    notifyListeners();
  }

  void updateAppointment(List<String> texts, {String? targetLanguage}) async {
    appointmentList.clear();
    var result = await _translationService.translateMultiple(texts, targetLanguage: targetLanguage);
    appointmentList = result;
    notifyListeners();
  }

  void updateMedication(List<String> texts, {String? targetLanguage}) async {
    medicationList.clear();
    var result = await _translationService.translateMultiple(texts, targetLanguage: targetLanguage);
    medicationList = result;
    notifyListeners();
  }

  void updateChatRoom(List<String> texts, {String? targetLanguage}) async {
    chatRoomList.clear();
    var result = await _translationService.translateMultiple(texts, targetLanguage: targetLanguage);
    chatRoomList = result;
    notifyListeners();
  }

  void updateDoctorPatient(List<String> texts, {String? targetLanguage}) async {
    doctorPatientList.clear();
    var result = await _translationService.translateMultiple(texts, targetLanguage: targetLanguage);
    doctorPatientList = result;
    notifyListeners();
  }

  void updateAppointmentRemainder(List<String> texts, {String? targetLanguage}) async {
    appointmentRemainder.clear();
    var result = await _translationService.translateMultiple(texts, targetLanguage: targetLanguage);
    appointmentRemainder = result;
    notifyListeners();
  }

  void updatePaymentCard(List<String> texts, {String? targetLanguage}) async {
    paymentCardList.clear();
    var result = await _translationService.translateMultiple(texts, targetLanguage: targetLanguage);
    paymentCardList = result;
    notifyListeners();
  }
}
