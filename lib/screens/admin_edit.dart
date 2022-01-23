import 'package:flutter/material.dart';
import 'package:fruit_shope/Provider/products_provider.dart';
import 'package:fruit_shope/screens/edit_product.dart';
import 'package:fruit_shope/screens/user_item.dart';
import 'package:provider/provider.dart';

class UserProductScreen extends StatelessWidget {
  const UserProductScreen({Key? key}) : super(key: key);

  Future<void> _refreshproducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditProduct(
                          id: null,
                        )),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: _refreshproducts(context),
        builder: (context, AsyncSnapshot snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: () => _refreshproducts(context),
                    child: Consumer<Products>(
                      builder: (ctx, productsData, _) => Padding(
                        padding: const EdgeInsets.all(8),
                        child: ListView.builder(
                          itemCount: productsData.items.length,
                          itemBuilder: (_, int index) => Column(
                            children: [
                              UserProductItem(
                                productsData.items[index].id,
                                productsData.items[index].name,
                                productsData.items[index].imagename,
                              ),
                              Divider()
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
