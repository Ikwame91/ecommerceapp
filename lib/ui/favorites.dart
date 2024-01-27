import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/constants/appstyle.dart';
import 'package:ecommerce_app/controllers/favorites_notifier.dart';
import 'package:ecommerce_app/ui/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var favNotifier = Provider.of<FavoritesNotifier>(context);
    favNotifier.getfav();

    return Scaffold(
        body: SizedBox(
      height: size.height,
      width: size.width,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 40, 0, 0),
            height: size.height * 0.4,
            width: size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/top_image.png'),
                    fit: BoxFit.fill)),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'My Favorites',
                style: appstyle(40, Colors.white, FontWeight.bold),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 85),
              child: ListView.builder(
                  itemCount: favNotifier.fav.length,
                  itemBuilder: (BuildContext context, int index) {
                    final shoe = favNotifier.fav[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          height: size.height * 0.12,
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade500,
                                  spreadRadius: 5,
                                  blurRadius: 0.3,
                                  offset: const Offset(0, 1))
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: shoe['imageUrl'] != null
                                        ? CachedNetworkImage(
                                            imageUrl: shoe["imageUrl"],
                                            width: 70,
                                            height: 70,
                                            fit: BoxFit.fill,
                                          )
                                        : Container(
                                            color: Colors.grey.shade300,
                                            width: 70,
                                            height: 70,
                                            child: const Icon(
                                              Ionicons.image_outline,
                                              color: Colors.grey,
                                              size: 30,
                                            )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 12,
                                      left: 20,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          shoe['name'],
                                          style: appstyle(15, Colors.black,
                                              FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          shoe['category'],
                                          style: appstyle(14, Colors.black,
                                              FontWeight.w600),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${shoe['price']}",
                                          style: appstyle(15, Colors.black,
                                              FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: GestureDetector(
                                  onTap: () {
                                    favNotifier.deleteFav(shoe["key"]);
                                    favNotifier.ids.removeWhere(
                                        (element) => element == shoe['id']);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MainScreen()));
                                  },
                                  child: const Icon(Ionicons.md_heart_dislike),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })),
        ],
      ),
    ));
  }
}
