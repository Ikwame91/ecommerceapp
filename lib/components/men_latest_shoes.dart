import 'package:ecommerce_app/models/sneaker_model.dart';
import 'package:ecommerce_app/widgets/stager_tile.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class MenLatestShoes extends StatelessWidget {
  const MenLatestShoes({
    super.key,
    required Future<List<Sneakers>> male,
    required this.size,
  }) : _male = male;

  final Future<List<Sneakers>> _male;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Sneakers>>(
      future: _male,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else {
          final male = snapshot.data;
          return StaggeredGridView.countBuilder(
            padding: EdgeInsets.zero,
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 16,
            scrollDirection: Axis.vertical,
            itemCount: male!.length,
            staggeredTileBuilder: (index) => StaggeredTile.extent(
              (index % 2 == 0) ? 1 : 1,
              (index % 4 == 1 || index % 4 == 3)
                  ? size.height * 0.36
                  : size.height * 0.32,
            ),
            itemBuilder: (context, index) {
              final shoe = snapshot.data![index];
              return StagerTile(
                imageUrl: shoe.imageUrl[1],
                name: shoe.name,
                price: "\$${shoe.price}",
              );
            },
          );
        }
      },
    );
  }
}
