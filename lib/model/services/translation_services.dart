import 'dart:convert';
import 'dart:developer';
import 'package:tabibinet_project/model/api_services/api_services.dart';
import 'package:tabibinet_project/model/api_services/url/baseurl.dart';
import 'package:tabibinet_project/model/services/SharedPreference/shared_preference.dart';

class TranslationService {
  final String _apiKey = BaseUrl.API_KEY;

  static const int MAX_TEXTS_PER_REQUEST = 100;
  static const int MAX_CHARACTERS_PER_REQUEST = 5000;

  Future<Map<String, String>> translateMultiple(List<String> texts, {String? targetLanguage}) async {
    // Use the current language if none is provided
    final pref = await SharedPreferencesService.getInstance();
    String language = pref.getString("language") ?? "en";
    targetLanguage ??= language;

    texts = texts.toSet().toList();

    Map<String, String> translationMap = {};

    if (texts.isEmpty) return translationMap;

    try {
      List<List<String>> batches = _batchTexts(texts, MAX_TEXTS_PER_REQUEST, MAX_CHARACTERS_PER_REQUEST);

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
            translationMap[originalText] = translated;
          }
        } else {
          for (var text in batch) {
            translationMap[text] = text;
          }
        }
      }
    } catch (e) {
      for (var text in texts) {
        translationMap[text] = text;
      }
    }

    return translationMap;
  }

  List<List<String>> _batchTexts(List<String> texts, int maxTexts, int maxChars) {
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

}
