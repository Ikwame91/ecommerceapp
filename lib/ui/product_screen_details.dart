import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/constants/appstyle.dart';
import 'package:ecommerce_app/controllers/productscreen_provider.dart';
import 'package:ecommerce_app/models/sneaker_model.dart';
import 'package:ecommerce_app/services/helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.id, required this.category});
  final String id;
  final String category;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late Future<Sneakers> _sneakers;

  void getShoes() {
    final helper = Helper();
    _sneakers = widget.category == "Men's Running"
        ? helper.getMaleSneakersById(widget.id)
        : widget.category == "Women's Running"
            ? helper.getMaleSneakersById(widget.id)
            : helper.getKidsSneakersById(widget.id);
  }

  @override
  void initState() {
    super.initState();
    getShoes();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return FutureBuilder<Sneakers>(
      future: _sneakers,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else {
          final sneaker = snapshot.data;
          return Consumer<ProductScreenNotifier>(
            builder: (context, productNotifier, child) {
              return Scaffold(
                body: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      leadingWidth: 0,
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                productNotifier.shoeSizes.clear();
                              },
                              child: const Icon(
                                AntDesign.close,
                                color: Colors.black,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(
                                Ionicons.ellipsis_horizontal,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                      pinned: true,
                      snap: false,
                      floating: true,
                      backgroundColor: Colors.yellow,
                      expandedHeight: size.height * 0.32,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          children: [
                            SizedBox(
                              height: size.height * 0.5,
                              width: size.width,
                              child: PageView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: sneaker!.imageUrl.length,
                                onPageChanged: (page) {
                                  productNotifier.activePage = page;
                                },
                                itemBuilder: (context, index) {
                                  return Stack(
                                    children: [
                                      Container(
                                        height: size.height * 0.4,
                                        width: size.width,
                                        color: Colors.grey.shade300,
                                        child: CachedNetworkImage(
                                          imageUrl: sneaker.imageUrl[index],
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      const Positioned(
                                        top: 60,
                                        right: 20,
                                        child: Icon(
                                          AntDesign.hearto,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        left: 0,
                                        height: size.height * 0.15,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List<Widget>.generate(
                                            sneaker.imageUrl.length,
                                            (index) => Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: CircleAvatar(
                                                radius: 8,
                                                backgroundColor: productNotifier
                                                            .activepage !=
                                                        index
                                                    ? Colors.grey
                                                    : Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                        child: Container(
                          width: size.width,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  sneaker.name,
                                  style: appstyle(
                                    38,
                                    Colors.black,
                                    FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      sneaker.category,
                                      style: appstyle(
                                        20,
                                        Colors.grey,
                                        FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    RatingBar.builder(
                                      initialRating: 4,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 22,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 1.0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        if (kDebugMode) {
                                          print(rating);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "\$${sneaker.price}",
                                      style: appstyle(
                                        26,
                                        Colors.black,
                                        FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Colors",
                                          style: appstyle(
                                            18,
                                            Colors.black,
                                            FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const CircleAvatar(
                                          radius: 7,
                                          backgroundColor: Colors.black,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const CircleAvatar(
                                          radius: 7,
                                          backgroundColor: Colors.orange,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Select sizes',
                                          style: appstyle(
                                            20,
                                            Colors.black,
                                            FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          'view size guide',
                                          style: appstyle(
                                            18,
                                            Colors.grey,
                                            FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 40,
                                      child: ListView.builder(
                                        itemCount:
                                            productNotifier.shoeSizes.length,
                                        scrollDirection: Axis.horizontal,
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (context, index) {
                                          final size =
                                              productNotifier.shoeSizes[index];
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: ChoiceChip(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(60),
                                                side: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1,
                                                    style: BorderStyle.solid),
                                              ),
                                              selectedColor: Colors.black,
                                              disabledColor: Colors.white,
                                              label: Text(
                                                size['size'],
                                                style: appstyle(
                                                    18,
                                                    size['isSelected']
                                                        ? Colors.white
                                                        : Colors.black,
                                                    FontWeight.w600),
                                              ),
                                              selected: size['isSelected'],
                                              onSelected: (newState) {
                                                productNotifier
                                                    .toggleCheck(index);
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Divider(
                                  indent: 10,
                                  color: Colors.black,
                                  endIndent: 10,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: size.width,
                                  child: Text(
                                    sneaker.title,
                                    style: appstyle(
                                        26, Colors.black, FontWeight.w600),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: size.width,
                                  child: Text(
                                    sneaker.description,
                                    style: appstyle(
                                        14, Colors.black, FontWeight.normal),
                                  ),
                                ),
                                Text(
                                  sneaker.description,
                                  style: appstyle(
                                      14, Colors.black, FontWeight.normal),
                                ),
                                Text(
                                  sneaker.description,
                                  style: appstyle(
                                      14, Colors.black, FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
