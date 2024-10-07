import 'package:flutter/material.dart';

class OnboardProvider extends ChangeNotifier {

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setCurrentIndex() {
    _currentIndex++;
    notifyListeners();
  }
}