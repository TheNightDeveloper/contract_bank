import 'package:flutter/material.dart';

class SkeletProvider extends ChangeNotifier {
  int page;
  String? currentPage;
  SkeletProvider({this.page = 2});
  void changeScreen(int index) {
    page = index;
    notifyListeners();
  }

  void changePage(String page) {
    currentPage = page;
    notifyListeners();
  }
}
