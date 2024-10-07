import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Providers/actionProvider/actionProvider.dart';

class OnlineStatusController extends GetxController with WidgetsBindingObserver{

  @override
  void onInit() {
    super.onInit();
    log("Listening for online status");
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      ActionProvider().setDoctorOffline();
    } else if (state == AppLifecycleState.resumed) {
      ActionProvider().setDoctorOnline();
    }else if (state == AppLifecycleState.detached){
      ActionProvider().setDoctorOffline();
    }
  }


}