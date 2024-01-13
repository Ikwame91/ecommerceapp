import 'package:ecommerce_app/components/bottom_navigation.dart';
import 'package:ecommerce_app/controllers/mainscreen_provider.dart';
import 'package:ecommerce_app/ui/cart_screen.dart';
import 'package:ecommerce_app/ui/favorites.dart';
import 'package:ecommerce_app/ui/home_screen.dart';
import 'package:ecommerce_app/ui/profile_screen.dart';
import 'package:ecommerce_app/ui/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final List<Widget> pageList = [
    const HomeScreen(),
    const SearchScreen(),
    const Favorites(),
    const CartScreen(),
    const ProfilScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child) {
        return Scaffold(
          body: pageList[mainScreenNotifier.currentIndex],
          bottomNavigationBar: const BottomNavigationBarr(),
        );
      },
    );
  }
}
