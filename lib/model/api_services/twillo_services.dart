import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:tabibinet_project/model/api_services/url/baseurl.dart';

class TwilioService {
  final String accountSid;
  final String authToken;
  final String twilioPhoneNumber;

  TwilioService({
    this.accountSid = BaseUrl.SID_TWILLO,
    this.authToken = BaseUrl.AUTH_TOKEN_TWILLO,
    this.twilioPhoneNumber = BaseUrl.PHONE_TWILLO,
  });

  Future<void> sendSmsReminder(String toPhoneNumber, String message) async {
    final String url = 'https://api.twilio.com/2010-04-01/Accounts/$accountSid/Messages.json';
    final String credentials = '$accountSid:$authToken';
    final String encodedCredentials = base64Encode(utf8.encode(credentials));

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Basic $encodedCredentials',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'From': twilioPhoneNumber,
        'To': toPhoneNumber,
        'Body': message,
      },
    );

    if (response.statusCode == 201) {
      log('SMS sent successfully');
    } else {
      throw Exception('Failed to send SMS: ${response.statusCode} ${response.body}');
    }
  }
}
