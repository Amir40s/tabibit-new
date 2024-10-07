import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabibinet_project/Providers/FaqProvider/faq_provider.dart';
import 'package:tabibinet_project/Providers/Language/language_provider.dart';
import 'package:tabibinet_project/Providers/payment/payment_provider.dart';

import 'package:tabibinet_project/Providers/translation/translation_provider.dart';
import 'package:tabibinet_project/Providers/chatProvider/chat_provider.dart';
import 'Providers/BottomNav/bottom_navbar_provider.dart';
import 'Providers/FindDoctor/find_doctor_provider.dart';
import 'Providers/Medicine/medicine_provider.dart';
import 'Providers/PatientAppointment/patient_appointment_provider.dart';
import 'Providers/PatientNotification/patient_notification_provider.dart';
import 'Providers/Profile/profile_provider.dart';
import 'Providers/SignIn/sign_in_provider.dart';
import 'Providers/subscription_provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class GlobalProviderAccess {

  static SignInProvider? get signPro {
    final context = navigatorKey.currentContext;
    if (context != null) {
      return Provider.of<SignInProvider>(context, listen: false);
    }
    return null;
  }

  static LanguageProvider? get languagePro {
    final context = navigatorKey.currentContext;
    if (context != null) {
      return Provider.of<LanguageProvider>(context, listen: false);
    }
    return null;
  }

  static ProfileProvider? get profilePro {
    final context = navigatorKey.currentContext;
    if (context != null) {
      return Provider.of<ProfileProvider>(context, listen: false);
    }
    return null;
  }

  static FindDoctorProvider? get findDoctorPro {
    final context = navigatorKey.currentContext;
    if (context != null) {
      return Provider.of<FindDoctorProvider>(context, listen: false);
    }
    return null;
  }


  static PatientNotificationProvider? get patientNotificationPro {
    final context = navigatorKey.currentContext;
    if (context != null) {
      return Provider.of<PatientNotificationProvider>(context, listen: false);
    }
    return null;
  }

  static BottomNavBarProvider? get bottomNavProvider {
    final context = navigatorKey.currentContext;
    if (context != null) {
      return Provider.of<BottomNavBarProvider>(context, listen: false);
    }
    return null;
  }

  static MedicineProvider? get medicineProvider {
    final context = navigatorKey.currentContext;
    if (context != null) {
      return Provider.of<MedicineProvider>(context, listen: false);
    }
    return null;
  }

  static ChatProvider? get chatProvider {
    final context = navigatorKey.currentContext;
    if (context != null) {
      return Provider.of<ChatProvider>(context, listen: false);
    }
    return null;
  }

  static TranslationProvider? get translationProvider {
    final context = navigatorKey.currentContext;
    if (context != null) {
      return Provider.of<TranslationProvider>(context, listen: false);
    }
    return null;
  }

  static FaqProvider? get faqProvider {
    final context = navigatorKey.currentContext;
    if (context != null) {
      return Provider.of<FaqProvider>(context, listen: false);
    }
    return null;
  }

  static PaymentProvider? get paymentProvider {
    final context = navigatorKey.currentContext;
    if (context != null) {
      return Provider.of<PaymentProvider>(context, listen: false);
    }
    return null;
  }

  static PatientAppointmentProvider? get patientAppointmentProvider {
    final context = navigatorKey.currentContext;
    if (context != null) {
      return Provider.of<PatientAppointmentProvider>(context, listen: false);
    }
    return null;
  }

  static SubscriptionProvider? get subscriptionProvider {
    final context = navigatorKey.currentContext;
    if (context != null) {
      return Provider.of<SubscriptionProvider>(context, listen: false);
    }
    return null;
  }

}