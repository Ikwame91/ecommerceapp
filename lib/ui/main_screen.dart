import 'package:ecommerce_app/controllers/mainscreen_provider.dart';
import 'package:ecommerce_app/ui/cart_screen.dart';
import 'package:ecommerce_app/ui/home_screen.dart';
import 'package:ecommerce_app/ui/profile_screen.dart';
import 'package:ecommerce_app/ui/search_screen.dart';
import 'package:ecommerce_app/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final List<Widget> pageList = [
    const HomeScreen(),
    const SearchScreen(),
    const HomeScreen(),
    // const HomeScreen(),
    const CartScreen(),
    const ProfilScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child) {
        return Scaffold(
          body: pageList[mainScreenNotifier.currentIndex],
          bottomNavigationBar: SafeArea(
            child: Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BottomNav(
                    onTap: () {
                      mainScreenNotifier.changeIndex = 0;
                    },
                    icon: mainScreenNotifier.currentIndex == 0
                        ? Ionicons.home
                        : Ionicons.home_outline,
                  ),
                  BottomNav(
                    onTap: () {
                      mainScreenNotifier.changeIndex = 1;
                    },
                    icon: mainScreenNotifier.currentIndex == 1
                        ? Ionicons.search
                        : Ionicons.search_outline,
                  ),
                  BottomNav(
                    onTap: () {
                      mainScreenNotifier.changeIndex = 2;
                    },
                    icon: mainScreenNotifier.currentIndex == 2
                        ? Ionicons.add_circle
                        : Ionicons.add_circle_outline,
                  ),
                  BottomNav(
                    onTap: () {
                      mainScreenNotifier.changeIndex = 3;
                    },
                    icon: mainScreenNotifier.currentIndex == 3
                        ? Ionicons.cart
                        : Ionicons.cart_outline,
                  ),
                  BottomNav(
                    onTap: () {
                      mainScreenNotifier.changeIndex = 4;
                    },
                    icon: mainScreenNotifier.currentIndex == 4
                        ? Ionicons.person
                        : Ionicons.person_outline,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
