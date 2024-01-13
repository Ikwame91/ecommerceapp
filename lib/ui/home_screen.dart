import 'package:ecommerce_app/components/home_component.dart';
import 'package:ecommerce_app/constants/appstyle.dart';
import 'package:ecommerce_app/controllers/tabs_prodivier.dart';
import 'package:ecommerce_app/models/sneaker_model.dart';
import 'package:ecommerce_app/services/helper.dart';
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

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color(0xFFE2E2E2),
        body: SingleChildScrollView(
          child: SizedBox(
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
                          style: appstyletwo(
                              42, Colors.white, FontWeight.bold, 1.5),
                        ),
                        Text(
                          'Collection',
                          style: appstyletwo(
                            35,
                            Colors.white,
                            FontWeight.bold,
                            1.2,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TabBar(
                          tabAlignment: TabAlignment.start,
                          dividerColor: Colors.transparent,
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey.shade800),
                          labelPadding: const EdgeInsets.only(right: 20),
                          padding: EdgeInsets.zero,
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
                              male: _male,
                              tabIndex: tabsNotifier.firstTab == 0 ? 0 : -1,
                            ),
                            HomeComponent(
                              size: size,
                              male: _female,
                              tabIndex: tabsNotifier.firstTab == 1 ? 1 : -1,
                            ),
                            HomeComponent(
                              size: size,
                              male: _kids,
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
          ),
        ));
  }
}
