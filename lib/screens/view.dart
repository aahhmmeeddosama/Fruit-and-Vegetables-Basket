import 'package:flutter/material.dart';
import 'package:flutter_application_6/Provider/products_provider.dart';
import 'package:flutter_application_6/screens/productitem.dart';
import 'package:provider/provider.dart';

class view extends StatelessWidget {
  final bool fav;

  const view(this.fav);
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Products>(context);
    final products = fav ? data.FavouriteItems : data.items;
    return products.isEmpty
        ? Center(child: Text("No products"))
        : GridView.builder(
            padding: EdgeInsets.all(10),
            itemCount: products.length,
            itemBuilder: (context, index) => ChangeNotifierProvider.value(
              value: products[index],
              child: ProductItems(),
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
          );
  }
}
