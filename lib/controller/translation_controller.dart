import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:tabibinet_project/model/api_services/api_services.dart';
import 'package:tabibinet_project/model/api_services/url/baseurl.dart';
import 'package:tabibinet_project/model/services/SharedPreference/shared_preference.dart';

import '../model/services/translation_services.dart';

class TranslationController extends GetxController {
  RxString translatedText = "".obs;
  RxString doctorText = "".obs;
  RxString currentLanguage = "ar".obs;
  RxMap<String, String> translatedTexts = <String, String>{}.obs;

  int MAX_TEXTS_PER_REQUEST = 100;
  int MAX_CHARACTERS_PER_REQUEST = 5000;

  final String _apiKey = BaseUrl.API_KEY;

  final TranslationService _translationService = TranslationService();
  var translations = <String, String>{}.obs;
  var isLoading = false.obs;

  var notificationTranslationList = <String, String>{}.obs;
  var isNotification = false.obs;

  var faqList = <String, String>{}.obs;
  var isFaq = false.obs;

  var feeList = <String, String>{}.obs;
  var isFee = false.obs;

  final Map<String, String> languages = {
    'English': 'en',
    'Arabic': 'ar',
    'French': 'fr',
    'Spanish': 'es',
  };

  void changeLanguage(String language) {
    currentLanguage.value = languages[language] ?? 'en';
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
        translatedTexts[text] = translatedText.value; // Store the translation
        log("TRANSLATE:: $translatedText");
        return translatedText.value.toString();
      } else {
        translatedText.value = text; // Fallback to original text
        translatedTexts[text] = text; // Store original text as translation
        return null;
      }
    } catch (e) {
      log("Error: ${e.toString()}");
      return null;
    }
  }

  Future<void> translateMultiple(List<String> texts,{String? targetLanguage}) async {
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
        translatedTexts.value = {
          for (int i = 0; i < texts.length; i++)
            texts[i]: translations[i]['translatedText'] ?? texts[i]
        };
        log("TRANSLATE MULTIPLE:: ${translatedTexts}");
      } else {
        translatedTexts.value = {
          for (var text in texts) text: text,
        };
      }
    } catch (e) {
      log("Error in translateMultiple: $e");
    }
  }


  Future<void> translateHomeDoctor(List<String> texts) async {
    isLoading.value = true;
    try {
      var result = await _translationService.translateMultiple(texts);
      translations.value = result;
    } finally {
      isLoading.value = false;
    }
  }



  Future<void> translateNotification(List<String> texts) async {
    isNotification.value = true;
    try {
      var result = await _translationService.translateMultiple(texts);
      notificationTranslationList.value = result;
    } finally {
      isNotification.value = false;
    }
  }

  Future<void> translateFaq(List<String> texts) async {
    isFaq.value = true;
    try {
      var result = await _translationService.translateMultiple(texts);
      faqList.value = result;
    } finally {
      isFaq.value = false;
    }
  }

  Future<void> translateFees(List<String> texts) async {
    isFee.value = true;
    try {
      var result = await _translationService.translateMultiple(texts);
      feeList.value = result;
    } finally {
      isFee.value = false;
    }
  }

  void updateTranslations(List<String> texts, {String? targetLanguage}) {
    translateMultiple(texts, targetLanguage: targetLanguage);
  }

  void updateDoctorTranslation(List<String> texts, {String? targetLanguage}) async{
    translatedTexts.clear();
    var result = await  _translationService.translateMultiple(texts, targetLanguage: targetLanguage);
    translations.value = result;
  }

  void updateDoctorFaq(List<String> texts, {String? targetLanguage}) async{
    faqList.clear();
    var result = await  _translationService.translateMultiple(texts, targetLanguage: targetLanguage);
    faqList.value = result;
  }

  void updateFees(List<String> texts, {String? targetLanguage}) async{
    feeList.clear();
    var result = await  _translationService.translateMultiple(texts, targetLanguage: targetLanguage);
    feeList.value = result;
  }
}
