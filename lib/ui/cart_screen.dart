import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/constants/appstyle.dart';
import 'package:ecommerce_app/widgets/checkout_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive/hive.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});
  final _cartBox = Hive.box('cart_box');
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
        "quantity": item['quantity'],
        "sizes": item['sizes'],
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
                                    MediaQuery.of(context).size.height * 0.157,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.all(12),
                                            child:
                                                //  data['imageUrl'] != null
                                                CachedNetworkImage(
                                              imageUrl: data['imageUrl'],
                                              width: 70,
                                              height: 70,
                                              fit: BoxFit.fill,
                                            )
                                            // : Container(
                                            //     color: Colors.grey.shade300,
                                            //     width: 70,
                                            //     height: 70,
                                            //     child: const Icon(
                                            //       Ionicons.image_outline,
                                            //       color: Colors.grey,
                                            //       size: 30,
                                            //     )),
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
                                              Row(
                                                children: [
                                                  Container(
                                                    constraints:
                                                        const BoxConstraints(
                                                      maxWidth: 160,
                                                    ),
                                                    child: Text(
                                                      data['name'],
                                                      style: appstyle(
                                                        18,
                                                        Colors.black,
                                                        FontWeight.bold,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      softWrap: false,
                                                      maxLines: 2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                data['category'],
                                                style: appstyle(14, Colors.grey,
                                                    FontWeight.w600),
                                              ),
                                              const SizedBox(),
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
                                                    "Size",
                                                    style: appstyle(
                                                        16,
                                                        Colors.grey,
                                                        FontWeight.w600),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "${data['sizes']?.join(', ') ?? 'N/A'}",
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(16))),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () {},
                                                  child: const Icon(
                                                    AntDesign.minussquare,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                Text(
                                                  data['quantity'].toString(),
                                                  style: appstyle(
                                                      12,
                                                      Colors.black,
                                                      FontWeight.w600),
                                                ),
                                                InkWell(
                                                  onTap: () {},
                                                  child: const Icon(
                                                    AntDesign.plussquare,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
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
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CheckoutButton(
                size: size,
                label: 'Proceed To Checkout',
                onTap: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
