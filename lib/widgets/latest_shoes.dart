import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LatestShoes extends StatelessWidget {
  const LatestShoes({
    super.key,
    required this.size,
    required this.imageurl,
  });

  final Size size;
  final String imageurl;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size.width * 0.28,
        height: size.height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.6),
                blurRadius: 10,
                spreadRadius: 1,
                offset: const Offset(0, 3))
          ],
        ),
        child: CachedNetworkImage(
          imageUrl: imageurl,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ));
  }
}
