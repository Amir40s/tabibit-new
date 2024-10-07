import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:tabibinet_project/global_provider.dart';

class AppLifecycleObserver with WidgetsBindingObserver {

  final AppStateProvider appStateProvider;
  final profileProvider = GlobalProviderAccess.profilePro;


  AppLifecycleObserver(this.appStateProvider);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        appStateProvider.setAppState("App is in background");
        break;
      case AppLifecycleState.resumed:
        appStateProvider.setAppState("App is active");
        // patientProfileProvider!.getSelfInfo();
        log("App is active");
        break;
      case AppLifecycleState.inactive:
        appStateProvider.setAppState("App is inactive");
        break;
      case AppLifecycleState.detached:
        appStateProvider.setAppState("App is detached");
        break;
      case AppLifecycleState.hidden:
        appStateProvider.setAppState("App is hidden");
        break;
    }
  }

  void addObserver() {
    WidgetsBinding.instance.addObserver(this);
  }

  void removeObserver() {
    WidgetsBinding.instance.removeObserver(this);
  }
}


class AppStateProvider extends ChangeNotifier {
  String _appState = "App is active";

  String get appState => _appState;

  void setAppState(String state) {
    _appState = state;
    notifyListeners();
  }
}