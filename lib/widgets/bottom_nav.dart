// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({
    Key? key,
    this.onTap,
    this.icon,
  }) : super(key: key);
  final void Function()? onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 38,
        width: 38,
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
