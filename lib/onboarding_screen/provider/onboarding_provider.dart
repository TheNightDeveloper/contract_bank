import 'package:flutter/material.dart';

class OnboardingProvider extends ChangeNotifier {
  int index = 0;
  String buttonText = 'بعدی';
  void changeText(String text) {
    buttonText = text;
    notifyListeners();
  }

  void changePage(int page) {
    index = page;
    notifyListeners();
  }
}
