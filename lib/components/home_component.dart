import 'package:ecommerce_app/constants/appstyle.dart';
import 'package:ecommerce_app/models/sneaker_model.dart';
import 'package:ecommerce_app/widgets/latest_shoes.dart';
import 'package:ecommerce_app/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class HomeComponent extends StatelessWidget {
  const HomeComponent({
    super.key,
    required this.size,
    required Future<List<Sneakers>> male,
  }) : _male = male;

  final Size size;
  final Future<List<Sneakers>> _male;

  @override
  Widget build(BuildContext context) {
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
                    return ProductCard(
                      price: "\$${shoe.price}",
                      category: shoe.category,
                      name: shoe.name,
                      id: shoe.id,
                      image: shoe.imageUrl[0],
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
                  Row(
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
                      )
                    ],
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
