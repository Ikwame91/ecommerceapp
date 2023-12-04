import 'package:ecommerce_app/components/home_component.dart';
import 'package:ecommerce_app/constants/appstyle.dart';
import 'package:ecommerce_app/controllers/productscreen_provider.dart';
import 'package:ecommerce_app/controllers/tabs_prodivier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductScreenNotifier>(context);
    productNotifier.getMale();
    productNotifier.getFemale();
    productNotifier.getKids();
    // var favoriteNotifuer = Provider.of<FavoritesNotifier>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color(0xFFE2E2E2),
        body: SizedBox(
          height: 812.h,
          width: 375.w,
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
                        padding: EdgeInsets.zero,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: Colors.transparent,
                        controller: _tabController,
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
              ),
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.3),
                child: Container(
                  padding: const EdgeInsets.only(left: 12),
                  child: Consumer<TabsNotifiier>(
                    builder: (context, tabsNotifier, child) {
                      return TabBarView(
                        controller: _tabController,
                        children: [
                          HomeComponent(
                            size: size,
                            male: productNotifier.male,
                            tabIndex: tabsNotifier.firstTab == 0 ? 0 : -1,
                          ),
                          HomeComponent(
                            size: size,
                            male: productNotifier.female,
                            tabIndex: tabsNotifier.firstTab == 1 ? 1 : -1,
                          ),
                          HomeComponent(
                            size: size,
                            male: productNotifier.kids,
                            tabIndex: tabsNotifier.firstTab == 2 ? 2 : -1,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
