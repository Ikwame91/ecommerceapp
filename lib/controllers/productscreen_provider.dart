import 'package:ecommerce_app/models/sneaker_model.dart';
import 'package:ecommerce_app/services/helper.dart';
import 'package:flutter/material.dart';

class ProductScreenNotifier extends ChangeNotifier {
  int _activepage = 0;

  //

  //

  int get activepage => _activepage;
  set activePage(int newIndex) {
    _activepage = newIndex;
    notifyListeners();
  }

//
  List<String> _sizes = [];
  List<String> get sizes => _sizes;

//
  late Future<List<Sneakers>> male;
  late Future<List<Sneakers>> female;
  late Future<List<Sneakers>> kids;
  void getMale() {
    male = Helper().getMaleSneakers();
  }

  void getFemale() {
    female = Helper().getFemaleSneakers();
  }

  void getKids() {
    kids = Helper().getKidSneakers();
  }

  set sizess(List<String> newSizes) {
    _sizes = newSizes;
    notifyListeners();
  }

  //////////////////////////////////////
  List<dynamic> _shoeSizess = [];

  List<dynamic> get shoeSizess => _shoeSizess;

  set shoeSizes(List<dynamic> newShoeSizes) {
    _shoeSizess = newShoeSizes;
    notifyListeners();
  }

  void toggleCheck(int index) {
    for (int i = 0; i < _shoeSizess.length; i++) {
      if (i == index) {
        _shoeSizess[i]["isSelected"] = !_shoeSizess[i]["isSelected"];
      }
    }
    notifyListeners();
  }
}
