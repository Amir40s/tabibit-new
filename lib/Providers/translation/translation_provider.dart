import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tabibinet_project/global_provider.dart';
import 'package:tabibinet_project/model/api_services/api_services.dart';
import 'package:tabibinet_project/model/api_services/url/baseurl.dart';
import 'package:tabibinet_project/model/services/SharedPreference/shared_preference.dart';

import '../../controller/translation_controller.dart';

class TranslationProvider with ChangeNotifier {

  int MAX_TEXTS_PER_REQUEST = 100;
  int MAX_CHARACTERS_PER_REQUEST = 5000;

  String _translatedText = "";
  String _currentLanguage = "en";
  Map<String, String> _translatedTexts = {};

  String get translatedText => _translatedText;
  String get currentLanguage => _currentLanguage;
  Map<String, String> get translatedTexts => _translatedTexts;

  List<String> specialties = [];
  List<String> doctorsList = [];
  List<String> faqList = [];
  List<String> feeLists = [];
  List<String> notificationList = [];
  List<String> patientPrecscription = [];
  List<String> appointmentList = [];
  List<String> medicationList = [];
  List<String> chatRoomList = [];
  List<String> doctorPatientList = [];
  List<String> appointmentRemainder = [];
  List<String> paymentCardList = [];

  final String _apiKey = BaseUrl.API_KEY;

  final Map<String, String> _languages = {
    'English': 'en',
    'Arabic': 'ar',
    'French': 'fr',
    'Spanish': 'es',
  };

  Map<String, String> get languages => _languages;

  void changeLanguage(String language) {
    final provider = GlobalProviderAccess.translationNewProvider;
    _currentLanguage = _languages[language] ?? 'en';
    notifyListeners();
    provider!.updateTranslations(specialties, targetLanguage:  _currentLanguage);
    provider.updateDoctorTranslation(doctorsList, targetLanguage:  _currentLanguage);
    provider.updateDoctorFaq(faqList, targetLanguage:  _currentLanguage);
    provider.updateFees(feeLists, targetLanguage:  _currentLanguage);
    provider.updateNotification(notificationList, targetLanguage:  _currentLanguage);
    provider.updatePatientPrescription(patientPrecscription, targetLanguage:  _currentLanguage);
    provider.updateAppointment(appointmentList, targetLanguage:  _currentLanguage);
    provider.updateMedication(medicationList, targetLanguage:  _currentLanguage);
    provider.updateChatRoom(chatRoomList, targetLanguage:  _currentLanguage);
    provider.updateDoctorPatient(doctorPatientList, targetLanguage:  _currentLanguage);
    provider.updateAppointmentRemainder(appointmentRemainder, targetLanguage:  _currentLanguage);
    provider.updatePaymentCard(paymentCardList, targetLanguage:  _currentLanguage);
  }

  void setSpecialties(List<String> specs) {
    specialties = specs;
    notifyListeners();
  }

  void setHomeDoctors(List<String> doctors) {
    doctorsList = doctors;
    notifyListeners();
  }

  void setFeesDoctors(List<String> fees) {
    feeLists = fees;
    notifyListeners();
  }

  void setFAQ(List<String> faq) {
    doctorsList = faq;
    notifyListeners();
  }

  void setNotification(List<String> notification) {
    notificationList = notification;
    notifyListeners();
  }

  void setPrescription(List<String> prescription) {
    patientPrecscription = prescription;
    notifyListeners();
  }



  Future<String?> translateSingleText(String text, {String? targetLanguage}) async {
    targetLanguage ??= _currentLanguage;

    // Check if the translation already exists for the text in the target language
    if (_translatedTexts.containsKey(text) && _translatedTexts[text]?.contains(targetLanguage) == true) {
      return _translatedTexts[text];
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
        _translatedText = decodedResponse['data']['translations'][0]['translatedText'];
        _translatedTexts[text] = _translatedText; // Store the translation
        log("TRANSLATE:: $_translatedText");
        notifyListeners();
        return _translatedText;
      } else {
        _translatedText = text;
        _translatedTexts[text] = text;
        notifyListeners();
        return null;
      }
    } catch (e) {
      log("Error: ${e.toString()}");
      return null;
    }
  }

  Future<void> translateMultiple(List<String> texts, {String? targetLanguage}) async {

    final pref =await  SharedPreferencesService.getInstance();

    final String currentLanguage = pref.getString('language')?? 'en';

    targetLanguage ??= currentLanguage;


    texts = texts.where((text) =>
    !_translatedTexts.containsKey(text) ||
        _translatedTexts[text] != targetLanguage).toList();

    if (texts.isEmpty) return;

    List<List<String>> batchTexts(List<String> texts, int maxTexts, int maxChars) {
      List<List<String>> batches = [];
      List<String> currentBatch = [];
      int currentBatchLength = 0;

      for (String text in texts) {
        if (currentBatch.length >= maxTexts || (currentBatchLength + text.length) > maxChars) {
          batches.add(currentBatch);
          currentBatch = [];
          currentBatchLength = 0;
        }
        currentBatch.add(text);
        currentBatchLength += text.length;
      }

      if (currentBatch.isNotEmpty) {
        batches.add(currentBatch);
      }
      return batches;
    }

    try {

      List<List<String>> batches = batchTexts(texts, MAX_TEXTS_PER_REQUEST, MAX_CHARACTERS_PER_REQUEST);

      for (var batch in batches) {
        final String url = '${BaseUrl.BASEURL_TRANSLATOR}$targetLanguage&key=$_apiKey';

        final body = {
          'q': batch,
        };

        final response = await ApiService.post(
          requestBody: body,
          headers: BaseUrl.headers,
          endPoint: url,
        );

        if (response.statusCode == 200) {
          final decodedResponse = json.decode(response.body);
          List<dynamic> translations = decodedResponse['data']['translations'];

          for (int i = 0; i < batch.length; i++) {
            String originalText = batch[i];
            String translated = translations[i]['translatedText'] ?? originalText;
            _translatedTexts[originalText] = translated;
          }
          notifyListeners();
        } else {
          for (var text in batch) {
            _translatedTexts[text] = text;
          }
          notifyListeners();
        }
      }
    } catch (e) {
      for (var text in texts) {
        _translatedTexts[text] = text;
      }
      notifyListeners();
    }
  }

}
