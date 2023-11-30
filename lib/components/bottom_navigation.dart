import 'package:ecommerce_app/controllers/mainscreen_provider.dart';
import 'package:ecommerce_app/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class BottomNavigationBarr extends StatelessWidget {
  const BottomNavigationBarr({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child) {
        return SafeArea(
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
                    mainScreenNotifier.currentIndex = 0;
                  },
                  icon: mainScreenNotifier.currentIndex == 0
                      ? Ionicons.home
                      : Ionicons.home_outline,
                ),
                BottomNav(
                  onTap: () {
                    mainScreenNotifier.currentIndex = 1;
                  },
                  icon: mainScreenNotifier.currentIndex == 1
                      ? Ionicons.search
                      : Ionicons.search_outline,
                ),
                BottomNav(
                  onTap: () {
                    mainScreenNotifier.currentIndex = 2;
                  },
                  icon: mainScreenNotifier.currentIndex == 2
                      ? Ionicons.add_circle
                      : Ionicons.add_circle_outline,
                ),
                BottomNav(
                  onTap: () {
                    mainScreenNotifier.currentIndex = 3;
                  },
                  icon: mainScreenNotifier.currentIndex == 3
                      ? Ionicons.cart
                      : Ionicons.cart_outline,
                ),
                BottomNav(
                  onTap: () {
                    mainScreenNotifier.currentIndex = 4;
                  },
                  icon: mainScreenNotifier.currentIndex == 4
                      ? Ionicons.person
                      : Ionicons.person_outline,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
