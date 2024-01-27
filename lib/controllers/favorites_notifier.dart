import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FavoritesNotifier extends ChangeNotifier {
  final _favBox = Hive.box('fav_box');
  List<dynamic> _ids = [];
  List<dynamic> _favorites = [];

  List<dynamic> get ids => _ids;

  set ids(List<dynamic> newIds) {
    _ids = newIds;
    notifyListeners();
  }

  List<dynamic> get favorites => _favorites;

  set favorites(List<dynamic> newFav) {
    _favorites = newFav;
    notifyListeners();
  }

  void getFavorites() {
    // Ensure that getFavorites is not called during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final favData = _favBox.keys.map((key) {
        final item = _favBox.get(key);

        return {
          "key": key,
          "id": item['id'],
        };
      }).toList();

      _favorites = favData.toList();
      _ids = _favorites.map((item) => item['id']).toList();

      // Notify listeners that the data has changed
      notifyListeners();
    });
  }

  getfav() {
    final favdata = _favBox.keys.map((key) {
      final item = _favBox.get(key);
      return {
        "key": key,
        "id": item['id'],
        "category": item['category'],
        "name": item['name'],
        "price": item['price'],
        "imageUrl": item['imageUrl'],
        "quantity": item['quantity'],
      };
    }).toList();
    _favorites = favdata.reversed.toList();
  }

  Future<void> deleteFav(int key) async {
    await _favBox.delete(key);
  }
}
