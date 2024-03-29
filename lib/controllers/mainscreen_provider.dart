import 'package:flutter/material.dart';

class MainScreenNotifier extends ChangeNotifier {
  int _pageIndex = 0;
  int get currentIndex => _pageIndex;
  // set changeIndex(int index)
  set currentIndex(int index) {
    _pageIndex = index;
    notifyListeners();
  }
}
