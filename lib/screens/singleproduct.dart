import 'package:flutter/material.dart';
import '../Provider/products_provider.dart';
import 'package:provider/provider.dart';

class singleproduct extends StatelessWidget {
  singleproduct({Key? key, required this.id}) : super(key: key);
  String id;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productId = id;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight:200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(loadedProduct.name,
                  style: TextStyle(color: Theme.of(context).primaryColor)),
              background: Hero(
                tag: loadedProduct.id,
                child:
                    Image.network(loadedProduct.imagename, fit: BoxFit.cover),
              ),
            ),
          ),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              [
                SizedBox(height: 30),
                Text(
                  '${loadedProduct.price} EGP',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 30),
                ),
                SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: size.width,
                  child: Text(
                    loadedProduct.description,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ];
            }),
          ),
        ],
      ),
    );
  }
}
