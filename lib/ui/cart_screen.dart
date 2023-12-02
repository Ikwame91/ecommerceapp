import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/constants/appstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive/hive.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});
  final _cartBox = Hive.box('cart_box');
  @override
  Widget build(BuildContext context) {
    List<dynamic> cart = [];
    final cartData = _cartBox.keys.map((key) {
      final item = _cartBox.get(key);
      return {
        "key": key,
        "id": item['id'],
        "category": item['category'],
        "name": item['name'],
        "price": item['price'],
        "imageUrl": item['imageUrl'],
        "sizes": item['sizes'] ?? [],
        "quantity": item['quantity'],
      };
    }).toList();
    cart = cartData.reversed.toList();
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.pop(context);
                //   },
                //   child: const Icon(
                //     AntDesign.close,
                //     color: Colors.black,
                //     size: 30,
                //   ),
                // ),
                Text(
                  'My Cart',
                  style: appstyle(36, Colors.black, FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: ListView.builder(
                      itemCount: cart.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final data = cart[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Slidable(
                              key: const ValueKey(0),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    flex: 1,
                                    onPressed: (context) {},
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    icon: Ionicons.trash_outline,
                                    label: 'Delete',
                                  ),
                                ],
                              ),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.6),
                                      blurRadius: 0.3,
                                      spreadRadius: 5,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: data['imageUrl'] != null
                                          ? CachedNetworkImage(
                                              imageUrl: data['imageUrl'],
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
                                              )), // or any other widget you want to show for null
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12, left: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            data['name'],
                                            style: appstyle(18, Colors.black,
                                                FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            data['category'],
                                            style: appstyle(14, Colors.grey,
                                                FontWeight.w600),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                data['price'],
                                                style: appstyle(
                                                    18,
                                                    Colors.black,
                                                    FontWeight.w600),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                "Size:",
                                                style: appstyle(16, Colors.grey,
                                                    FontWeight.w600),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "Sizes: ${data['sizes']?.join(', ') ?? 'N/A'}",
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
