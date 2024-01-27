import 'package:ecommerce_app/constants/appstyle.dart';
import 'package:ecommerce_app/controllers/favorites_notifier.dart';
import 'package:ecommerce_app/ui/favorites.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  const ProductCard(
      {super.key,
      required this.price,
      required this.category,
      required this.id,
      required this.image,
      required this.name});
  final String price;
  final String name;
  final String category;
  final String id;
  final String image;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    var favoritesNotifier =
        Provider.of<FavoritesNotifier>(context, listen: true);
    favoritesNotifier.getFavorites();
    bool selected = true;
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.white,
                spreadRadius: 1,
                blurRadius: 0.6,
                offset: Offset(1, 1))
          ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: size.height * 0.2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          widget.image,
                          scale: 0.2,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      right: 15,
                      top: 10,
                      child: GestureDetector(
                          onTap: () async {
                            if (favoritesNotifier.ids.contains(widget.id)) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Favorites()));
                            } else {
                              favoritesNotifier.createFav({
                                "id": widget.id,
                                "name": widget.name,
                                "imageUrl": widget.image,
                                "price": widget.price,
                                "category": widget.category,
                              });
                            }
                            setState(() {});
                          },
                          child: favoritesNotifier.ids.contains(widget.id)
                              ? const Icon(AntDesign.heart)
                              : const Icon(AntDesign.hearto)))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style:
                          appstyletwo(31, Colors.black, FontWeight.bold, 1.0),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    size.height > 700
                        ? const SizedBox(
                            height: 10,
                          )
                        : const SizedBox(
                            height: 5,
                          ),
                    Text(
                      widget.category,
                      style:
                          appstyletwo(28, Colors.black, FontWeight.w500, 0.8),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.price,
                      style:
                          appstyletwo(30, Colors.black, FontWeight.bold, 1.1),
                    ),
                    Row(
                      children: [
                        Text(
                          'Colors',
                          style: appstyle(18, Colors.grey, FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        ChoiceChip(
                          label: const Text(''),
                          selected: selected,
                          visualDensity: VisualDensity.compact,
                          selectedColor: const Color.fromRGBO(224, 224, 224, 1),
                          onSelected: (value) {},
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
