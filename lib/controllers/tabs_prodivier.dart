import 'package:flutter/material.dart';

class TabsNotifiier extends ChangeNotifier {
  int _firsttab = 2;
  int get firstTab => _firsttab;
  set firstTab(int index) {
    _firsttab = index;
    notifyListeners();
  }
}
