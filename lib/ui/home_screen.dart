import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/constants/appstyle.dart';
import 'package:ecommerce_app/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color(0xFFE2E2E2),
        body: SizedBox(
          height: size.height,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 40, 0, 0),
                height: size.height * 0.4,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/top_image.png'),
                        fit: BoxFit.cover)),
                child: SizedBox(
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sporting Shoe',
                        style:
                            appstyletwo(42, Colors.white, FontWeight.bold, 1.5),
                      ),
                      Text('Collection',
                          style: appstyletwo(
                              35, Colors.white, FontWeight.bold, 1.2)),
                      const SizedBox(
                        height: 25,
                      ),
                      TabBar(
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Colors.transparent,
                          controller: _tabController,
                          isScrollable: true,
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.grey,
                          labelStyle:
                              appstyle(24, Colors.white, FontWeight.bold),
                          tabs: const [
                            Tab(
                              text: 'Men Shoes',
                            ),
                            Tab(
                              text: 'Women Shoes',
                            ),
                            Tab(
                              text: 'Kids Shoes',
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.3),
                child: Container(
                  padding: const EdgeInsets.only(left: 12),
                  child: TabBarView(controller: _tabController, children: [
                    Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.42,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return ProductCard(
                                price: '\$34.00',
                                category: 'Men Shoes',
                                name: 'Nike Air Max 270',
                                id: '1',
                                image:
                                    "https://d326fntlu7tb1e.cloudfront.net/uploads/dc18ed7c-2061-43e7-9efa-a5fba1b2a1dd-IG2753.webp",
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 10, 5, 15),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: size.width * 0.28,
                                  height: size.height,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.6),
                                          blurRadius: 10,
                                          spreadRadius: 1,
                                          offset: const Offset(0, 3))
                                    ],
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "https://d326fntlu7tb1e.cloudfront.net/uploads/dc18ed7c-2061-43e7-9efa-a5fba1b2a1dd-IG2753.webp",
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: size.height * 0.45,
                          color: Colors.green,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: size.height * 0.45,
                          color: Colors.blue,
                        )
                      ],
                    )
                  ]),
                ),
              )
            ],
          ),
        ));
  }
}
