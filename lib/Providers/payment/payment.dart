
import 'dart:convert';
import 'dart:developer';
import  'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:tabibinet_project/global_provider.dart';
import 'package:tabibinet_project/model/api_services/url/baseurl.dart';
import 'package:tabibinet_project/model/payment/payment_inten_model.dart';

Future createPaymentIntent({required String name,
  required String address,
  required String pin,
  required String city,
  required String state,
  required String country,
  required String currency,
  required String amount}) async{

  final provider = GlobalProviderAccess.paymentProvider;

  final url = Uri.parse('https://api.stripe.com/v1/payment_intents');
  final secretKey=BaseUrl.STRIPE_SCRET_KEY;
  final body={
    'amount': amount,
    'currency': currency.toLowerCase(),
    'automatic_payment_methods[enabled]': 'true',
    'description': "Test Donation",
    'shipping[name]': name,
    'shipping[address][line1]': address,
    'shipping[address][postal_code]': pin,
    'shipping[address][city]': city,
    'shipping[address][state]': state,
    'shipping[address][country]': country
  };

  final response= await http.post(url,
      headers: {
        "Authorization": "Bearer $secretKey",
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: body
  );

  print(body);

  log("Body Response:: ${response.body}");
  if(response.statusCode==200){
    var json=jsonDecode(response.body);
    if(provider !=null){
      provider.savePaymentIntent(json);
    }
    log("Json Response:: ${json}");
    return json;
  }
  else{
    log("error in calling payment intent");
  }
}