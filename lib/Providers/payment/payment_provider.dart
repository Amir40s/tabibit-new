import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:tabibinet_project/Providers/payment/payment.dart';
import 'package:tabibinet_project/Screens/DoctorScreens/DoctorBottomNavBar/doctor_bottom_navbar.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/global_provider.dart';
import 'package:tabibinet_project/model/api_services/api_services.dart';
import 'package:tabibinet_project/model/api_services/url/baseurl.dart';
import 'package:tabibinet_project/model/payment/payment_inten_model.dart';
import 'package:tabibinet_project/model/puahNotification/push_notification.dart';

import '../../Screens/PatientScreens/BookingConfirmedScreen/booking_confirmed_screen.dart';

class PaymentProvider with ChangeNotifier {
  final String secretKey = BaseUrl.STRIPE_SCRET_KEY;
  final patientAppointmentP = GlobalProviderAccess.patientAppointmentProvider;
  String customerId = '';
  String ephericalID = '';
  String clientSecret = '';
  double paymentAmount = 0.0;

  PaymentIntentModel? _models;


  PaymentIntentModel? get paymentIntentModel => _models;

  Future<void> startTransaction(BuildContext context) async {
    final response = await http.post(
      Uri.parse('https://api.stripe.com/v1/customers'),
      headers: {
        'Authorization': 'Bearer $secretKey',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      customerId = data['id'];
      log("customerId:: $customerId");
      await getClientSecret(context, customerId,"");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create customer')),
      );
    }
  }

  Future<void> getEmpericalKey(BuildContext context, String customerId) async {
    try{
      final body = {
        'customer': customerId,
      };

      final header = {
        'Authorization': 'Bearer $secretKey',
        'Content-Type': 'application/x-www-form-urlencoded',
        'Stripe-Version': '2024-09-30.acacia',
      };

      final response = await ApiService.post(
          endPoint:  "https://api.stripe.com/v1/ephemeral_keys",
          headers: header,
          requestBody: body
      );

      log("Response: ${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        ephericalID = data['id'];
        log("ephericalID:: $ephericalID");
        await getClientSecret(context, customerId, ephericalID);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create ephemeral key')),
        );
      }
    }catch (e){
      log("error:: ${e.toString()}");
    }


  }

  Future<void> getClientSecret(BuildContext context, String customerId, String ephericalID) async {
    final response = await http.post(
      Uri.parse('https://api.stripe.com/v1/payment_intents'),
      headers: {
        'Authorization': 'Bearer $secretKey',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        // 'customer': customerId,
        'amount': (paymentAmount * 100).toString(),
        'currency': 'gbp',
        'automatic_payment_methods[enabled]': 'true',
        'description': "Test Donation",
        'shipping[name]': "name",
      },
    );

    log("Body: ${response.body}");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      clientSecret = data['client_secret'];
      log("clientSecret:: $clientSecret}");
      notifyListeners();
      await presentPaymentSheet(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create payment intent')),
      );
    }
  }

  Future<void> presentPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: "TABIBI NET",
        customerId: customerId,
        // customerEphemeralKeySecret: ephericalID,
      ));

      await Stripe.instance.presentPaymentSheet();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment Successful!')),
      );
      saveTransactionData();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment failed: ${e.toString()}')),
      );
    }
  }

  void saveTransactionData() {
    //log all data in the variables
    log("Customer ID: $customerId");
    log("Ephemeral Key ID: $ephericalID");
    log("Payment Client Secret: $clientSecret");
    log("Payment Amount: $paymentAmount");
  }


  // save json response to model class using provider create funtion

  void savePaymentIntent(Map<String, dynamic> json){
    _models = PaymentIntentModel.fromJson(json);
    notifyListeners();
  }

  Future<void> initPaymentSheet({
    required String amount,
    required String name,
    String type = "payment",
    String image = "",
  }) async {
    log("message:: $amount");
    try {
      // 1. create payment intent on the client side by calling stripe api
      final data = await createPaymentIntent(
        // convert string to double
          amount: (int.parse(amount)*100).toString(),
          currency: "MAD",
          name: name,
          address: "Address",
          pin: "1234",
          city: "city",
          state: 'pk',
          country: "Pakistan");


      // 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          customFlow: false,
          merchantDisplayName: 'Test Merchant',
          paymentIntentClientSecret: data['client_secret'],
          customerEphemeralKeySecret: data['ephemeralKey'],
          customerId: data['id'],
          style: ThemeMode.light,
        ),
      );

      checkPaymentStatus(type,image);

    } catch (e) {
      log("message:: ${e.toString()}");
      Get.snackbar(e.toString(), "");
      rethrow;
    }
  }

  void checkPaymentStatus(String type,String image) async{
    try{
      await Stripe.instance.presentPaymentSheet();


      if(type == "payment"){
        await patientAppointmentP!.sendAppointment(
          _models!.id.toString(),
          _models!.amount.toString(),
          _models!.clientSecret.toString(),
          _models!.amountReceived.toString(),
          image
        );

        final fcm = FCMService();
        fcm.sendNotification(
          patientAppointmentP!.doctorDeviceToken.toString(),
          "New Appointment",
          "you have received one new appointment",
          "zyx",
        );

        Get.to(()=>const BookingConfirmedScreen());
      }else{
        String uid = auth.currentUser?.uid.toString() ?? "";

        var logger = Logger();
        logger.i("Payment done");
        logger.d(uid);
        final provider = GlobalProviderAccess.subscriptionProvider;

        if(provider !=null){
          await provider.startTrial(uid, "premium");
          Get.offAll(const DoctorBottomNavbar());
        }

      }


      log("payment done");

    }catch(e){
      log("payment sheet failed");
    }
  }


}
