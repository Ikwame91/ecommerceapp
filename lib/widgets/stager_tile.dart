import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/constants/appstyle.dart';
import 'package:flutter/material.dart';

class StagerTile extends StatefulWidget {
  const StagerTile(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.price});
  final String imageUrl;
  final String name;
  final String price;
  @override
  State<StagerTile> createState() => _StagerTileState();
}

class _StagerTileState extends State<StagerTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: widget.imageUrl,
                fit: BoxFit.cover,
              ),
              Container(
                padding: const EdgeInsetsDirectional.only(top: 12),
                height: 70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: appstyletwo(16, Colors.black, FontWeight.w700, 1),
                    ),
                    Text(
                      widget.price,
                      style: appstyle(
                        16,
                        Colors.black,
                        FontWeight.w500,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
