import 'package:flutter/foundation.dart';

class CartProvider extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;
  void increment() {
    _counter++;
    notifyListeners();
  }

  void decrement() {
    _counter--;
    notifyListeners();
  }
}
