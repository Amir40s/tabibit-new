import 'package:flutter/material.dart';

class OnboardProvider extends ChangeNotifier {
  int _currentIndex = 0;

  // Getter for the current index
  int get currentIndex => _currentIndex;

  // Method to go to the next onboarding screen
  void nextIndex() {
    if (_currentIndex < 2) { // Assuming 3 onboarding screens
      _currentIndex++;
      notifyListeners();
    }
  }

  // Method to go to the previous onboarding screen
  void previousIndex() {
    if (_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }

  // Optional: Set a specific index directly
  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
