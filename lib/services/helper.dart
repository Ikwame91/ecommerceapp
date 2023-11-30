import 'package:ecommerce_app/models/sneaker_model.dart';
import 'package:flutter/services.dart' as the_bundle;

class Helper {
  Future<List<Sneakers>> getMaleSneakers() async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/men_shoes.json");
    final maleList = sneakersFromJson(data);
    return maleList;
  }

  Future<List<Sneakers>> getFemaleSneakers() async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/women_shoes.json");
    final femaleList = sneakersFromJson(data);
    return femaleList;
  }

  Future<List<Sneakers>> getKidSneakers() async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/kid_shoes.json");
    final kidList = sneakersFromJson(data);
    return kidList;
  }

  Future<Sneakers> getMaleSneakersById(String id) async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/men_shoes.json");
    final maleList = sneakersFromJson(data);

    final sneaker = maleList.firstWhere((sneaker) => sneaker.id == id);
    return sneaker;
  }

  Future<Sneakers> getFemaleSneakersById(String id) async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/women_shoes.json");
    final maleList = sneakersFromJson(data);

    final sneaker = maleList.firstWhere((sneaker) => sneaker.id == id);
    return sneaker;
  }

  Future<Sneakers> getKidsSneakersById(String id) async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/kid_shoes.json");
    final maleList = sneakersFromJson(data);

    final sneaker = maleList.firstWhere((sneaker) => sneaker.id == id);
    return sneaker;
  }
}
