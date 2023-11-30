import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/controllers/productscreen_provider.dart';
import 'package:ecommerce_app/models/sneaker_model.dart';
import 'package:ecommerce_app/services/helper.dart';
import 'package:flutter/material.dart';
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
  final PageController pageController = PageController();

  late Future<Sneakers> _sneakers;

  void getShoes() {
    if (widget.category == "Men's Running") {
      _sneakers = Helper().getMaleSneakersById(widget.id);
    } else if (widget.category == "Women's Running") {
      _sneakers = Helper().getMaleSneakersById(widget.id);
    } else {
      _sneakers = Helper().getKidsSneakersById(widget.id);
    }
  }

  @override
  void initState() {
    super.initState();
    getShoes();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(Ionicons.ellipsis_horizontal),
                            )
                          ],
                        ),
                      ),
                      pinned: true,
                      snap: false,
                      floating: true,
                      backgroundColor: Colors.transparent,
                      expandedHeight: size.height,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          children: [
                            SizedBox(
                              height: size.height * 0.5,
                              width: size.width,
                              child: PageView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: sneaker!.imageUrl.length,
                                  controller: pageController,
                                  onPageChanged: (page) {
                                    productNotifier.activePage = page;
                                  },
                                  itemBuilder: (context, int index) {
                                    return Stack(
                                      children: [
                                        Container(
                                          height: size.height * 0.39,
                                          width: size.width,
                                          color: Colors.grey.shade300,
                                          child: CachedNetworkImage(
                                            imageUrl: sneaker.imageUrl[index],
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Positioned(
                                            top: size.height * 0.9,
                                            right: 20,
                                            child: Icon(
                                              AntDesign.heart,
                                              color: Colors.grey,
                                            )),
                                        Positioned(
                                            bottom: 0,
                                            right: 0,
                                            left: 0,
                                            height: size.height * 0.3,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: List<Widget>.generate(
                                                  sneaker.imageUrl.length,
                                                  (index) => Padding(
                                                    padding: EdgeInsets.all(5),
                                                    child: CircleAvatar(
                                                      radius: 8,
                                                      backgroundColor:
                                                          productNotifier
                                                                      .activepage !=
                                                                  index
                                                              ? Colors.grey
                                                              : Colors.black,
                                                    ),
                                                  ),
                                                )))
                                      ],
                                    );
                                  }),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            });
          }
        });
  }
}
