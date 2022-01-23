import 'package:flutter/material.dart';
import 'package:fruit_shope/data/cart_data.dart';

/*
class FruitsAndVegs {
  final String picture;
  final String name;
  final String price;
  final String quantity;
  FruitsAndVegs(this.picture, this.name, this.price, this.quantity);
}
*/
class CartProducts extends StatefulWidget {
  const CartProducts({Key? key}) : super(key: key);

  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: product_on_the_cart.length,
      itemBuilder: (context, index) {
        return Single_cart_product(
          product_name: product_on_the_cart[index]["name"],
          product_picture: product_on_the_cart[index]["picture"],
          product_quantity: product_on_the_cart[index]["quantity"],
          product_price: product_on_the_cart[index]["price"],
        );
      },
    );
  }
}

class Single_cart_product extends StatelessWidget {
  final product_name;
  final product_picture;
  final product_quantity;
  final product_price;
  Single_cart_product(
      {this.product_name,
      this.product_picture,
      this.product_quantity,
      this.product_price});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(5, 5),
            blurRadius: 10,
          )
        ],
      ),
      child: Card(
        child: ListTile(
          leading: Image.asset(
            product_picture,
            width: 50.0,
          ),
          title: Text(product_name),
          subtitle: Column(
            children: [
              Row(
                children: [],
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Text("Price:"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Text(
                      product_price,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 2.0, 2.0, 2.0),
                    child: Text("Quantity:"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Text(
                      product_quantity,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove_circle),
                    onPressed: () {},
                  ),
                  const Text('1'),
                  IconButton(
                    icon: const Icon(Icons.add_circle),
                    onPressed: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
