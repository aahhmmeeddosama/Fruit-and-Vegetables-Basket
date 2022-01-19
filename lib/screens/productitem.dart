import 'package:flutter/material.dart';
import 'package:flutter_application_6/Provider/auth.dart';
import 'package:flutter_application_6/Provider/cart.dart';
import 'package:flutter_application_6/Provider/product_provider.dart';
import 'package:flutter_application_6/screens/product_details.dart';
import 'package:provider/provider.dart';

class ProductItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final AuthenticationData = Provider.of<Auth>(context, listen: false);

    //ClipRRect as i will use the grid list that
    //doen't have the smooth edges

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailPage(),
            ),
          ),
          child: Hero(
            tag: product.id,
            child: FadeInImage(
              placeholder: AssetImage('assets/download.png'),
              image: AssetImage(product.imagename),
              fit: BoxFit.cover,
            ),
          ),
        ),
        footer: GridTileBar(
            backgroundColor: Colors.black,
            title: Text(product.name),
            leading: Consumer<Product>(
              builder: (context, Product, _) => IconButton(
                onPressed: () {
                  product.toogleFavourite(
                      AuthenticationData.token!, AuthenticationData.userId!);
                },
                icon: Icon(product.isFavourite
                    ? Icons.favorite
                    : Icons.favorite_outline),
              ),
            ),
            trailing: IconButton(
                icon: Icon(Icons.shopping_basket),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(),
                      ));
                  Scaffold.of(context).hideCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Added in Cart Successfully'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                })),
      ),
    );
  }
}
