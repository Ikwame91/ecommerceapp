import 'package:ecommerce_app/constants/appstyle.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.label,
      required this.buttonColor,
      this.onpress});
  final String label;
  final Color buttonColor;
  final void Function()? onpress;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onpress,
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width * 0.25,
        decoration: BoxDecoration(
            border: Border.all(
                width: 1, color: buttonColor, style: BorderStyle.solid),
            borderRadius: const BorderRadius.all(Radius.circular(9))),
        child: Center(
          child: Text(
            label,
            style: appstyle(20, buttonColor, FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
