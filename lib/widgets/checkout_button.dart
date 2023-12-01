import 'package:ecommerce_app/constants/appstyle.dart';
import 'package:flutter/material.dart';

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({
    super.key,
    required this.size,
    required this.label,
    this.onTap,
  });

  final Size size;
  final String label;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(28),
        ),
        height: 55,
        width: size.width * 0.9,
        child: Center(
          child: Text(
            label,
            style: appstyle(18, Colors.white, FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
