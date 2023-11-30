import 'package:ecommerce_app/components/men_latest_shoes.dart';
import 'package:ecommerce_app/constants/appstyle.dart';
import 'package:ecommerce_app/models/sneaker_model.dart';
import 'package:ecommerce_app/services/helper.dart';
import 'package:ecommerce_app/widgets/custom_button.dart';
import 'package:ecommerce_app/widgets/custom_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ProductByCart extends StatefulWidget {
  const ProductByCart({super.key, required this.tabIndex});
  final int tabIndex;
  @override
  State<ProductByCart> createState() => _ProductByCartState();
}

class _ProductByCartState extends State<ProductByCart>
    with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  late Future<List<Sneakers>> _male;
  late Future<List<Sneakers>> _female;
  late Future<List<Sneakers>> _kids;
  void getMale() {
    _male = Helper().getMaleSneakers();
  }

  void getFemale() {
    _female = Helper().getFemaleSneakers();
  }

  void getKids() {
    _kids = Helper().getKidSneakers();
  }

  @override
  void initState() {
    super.initState();
    getMale();
    getFemale();
    getKids();
  }

  List<String> brand = [
    "assets/images/adidas.png",
    "assets/images/nike.png",
    "assets/images/gucci.png",
    "assets/images/jordan.png",
  ];
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
                    fit: BoxFit.fill),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6, 12, 16, 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            AntDesign.close,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            filter();
                          },
                          child: const Icon(
                            FontAwesome.sliders,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TabBar(
                    controller: _tabController,
                    padding: EdgeInsets.zero,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.transparent,
                    isScrollable: true,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: appstyle(24, Colors.white, FontWeight.bold),
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
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.175,
                left: 16,
                right: 12,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    MenLatestShoes(
                      male: _male,
                      size: size,
                    ),
                    MenLatestShoes(male: _female, size: size),
                    MenLatestShoes(male: _kids, size: size),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> filter() {
    double value = 100;
    Size size = MediaQuery.of(context).size;
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.white.withOpacity(0.5),
      context: context,
      builder: (context) => Container(
        height: size.height * 0.82,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 5,
              width: 40,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.black),
            ),
            SizedBox(
              height: size.height * 0.8,
              child: Column(
                children: [
                  const CustomSpacer(),
                  Text(
                    'Filter',
                    style: appstyle(20, Colors.black, FontWeight.bold),
                  ),
                  const CustomSpacer(),
                  Text(
                    'Gender',
                    style: appstyle(17, Colors.black, FontWeight.bold),
                  ),
                  const CustomSpacer(),
                  const Row(
                    children: [
                      CustomButton(
                        buttonColor: Colors.black,
                        label: "Men",
                      ),
                      CustomButton(
                        buttonColor: Colors.grey,
                        label: "Women",
                      ),
                      CustomButton(
                        buttonColor: Colors.grey,
                        label: "Kids",
                      )
                    ],
                  ),
                  const CustomSpacer(),
                  Text(
                    'Category',
                    style: appstyle(17, Colors.black, FontWeight.bold),
                  ),
                  const CustomSpacer(),
                  const Row(
                    children: [
                      CustomButton(
                        buttonColor: Colors.black,
                        label: "Shoes",
                      ),
                      CustomButton(
                        buttonColor: Colors.grey,
                        label: "Apparels",
                      ),
                      CustomButton(
                        buttonColor: Colors.grey,
                        label: "Accessories",
                      )
                    ],
                  ),
                  const CustomSpacer(),
                  Text(
                    'Price',
                    style: appstyle(20, Colors.black, FontWeight.bold),
                  ),
                  const CustomSpacer(),
                  Slider(
                    value: value,
                    max: 500,
                    activeColor: Colors.black,
                    thumbColor: Colors.black,
                    inactiveColor: Colors.grey,
                    divisions: 50,
                    label: value.toString(),
                    secondaryTrackValue: 200,
                    onChanged: (double value) {},
                  ),
                  const CustomSpacer(),
                  Text(
                    'Brand',
                    style: appstyle(20, Colors.black, FontWeight.bold),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    height: 100,
                    child: ListView.builder(
                      itemCount: brand.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(14))),
                            child: Image.asset(
                              brand[index],
                              height: 80,
                              width: 80,
                              color: Colors.black,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
