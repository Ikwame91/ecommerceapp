import 'package:ecommerce_app/components/product_by_cart.dart';
import 'package:ecommerce_app/constants/appstyle.dart';
import 'package:ecommerce_app/controllers/productscreen_provider.dart';
import 'package:ecommerce_app/models/sneaker_model.dart';
import 'package:ecommerce_app/ui/product_screen_details.dart';
import 'package:ecommerce_app/widgets/latest_shoes.dart';
import 'package:ecommerce_app/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class HomeComponent extends StatelessWidget {
  const HomeComponent({
    super.key,
    required this.size,
    required Future<List<Sneakers>> male,
    required this.tabIndex,
  }) : _male = male;

  final Size size;
  final Future<List<Sneakers>> _male;

  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductScreenNotifier>(context);
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.42,
          child: FutureBuilder<List<Sneakers>>(
            future: _male,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                final male = snapshot.data;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: male!.length,
                  itemBuilder: (context, index) {
                    final shoe = snapshot.data![index];
                    return GestureDetector(
                      onTap: () {
                        productNotifier.shoeSizes = shoe.sizes;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetails(
                                    id: shoe.id, category: shoe.category)));
                      },
                      child: ProductCard(
                        price: "\$${shoe.price}",
                        category: shoe.category,
                        name: shoe.name,
                        id: shoe.id,
                        image: shoe.imageUrl[0],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 10, 5, 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Latest Shoes',
                    style: appstyle(
                      22,
                      Colors.black,
                      FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProductByCart(tabIndex: tabIndex)));
                    },
                    child: Row(
                      children: [
                        Text(
                          'Show All',
                          style: appstyle(
                            22,
                            Colors.black,
                            FontWeight.w500,
                          ),
                        ),
                        const Icon(
                          AntDesign.caretright,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.1,
          child: FutureBuilder<List<Sneakers>>(
            future: _male,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                final male = snapshot.data;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: male!.length,
                  itemBuilder: (context, index) {
                    final shoe = snapshot.data![index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LatestShoes(
                        size: size,
                        imageurl: shoe.imageUrl[1],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
