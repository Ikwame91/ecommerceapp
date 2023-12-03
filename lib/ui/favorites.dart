import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  final _favBox = Hive.box("fav_box");
  _deleteFav(int key) async {
    await _favBox.delete(key);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<dynamic> _fav = [];

    return Scaffold(
        body: SizedBox(
      height: MediaQuery.of(context).size.height,
      width: size.width,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 40, 0, 0),
            height: size.height * 0.4,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/top_image.png'),
                    fit: BoxFit.cover)),
          ),
        ],
      ),
    ));
  }
}
