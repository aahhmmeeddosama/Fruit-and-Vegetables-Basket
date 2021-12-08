import 'package:flutter/material.dart';
import 'package:fruit_shop/model/cart_products.dart';

import 'checkout.dart';



class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('cart'),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {}),
        ],
      ),
      body: CartProducts(), 
      bottomNavigationBar: new Container(
        color:  Colors.white,
        child: Row(
          children: [
            Expanded(child: ListTile(
              title: Text("Total:"),
              subtitle: Text("\$150"),
            )),
            Expanded(
                child:
                MaterialButton(
                    onPressed:(){
                      Navigator.push(context,MaterialPageRoute(builder: (context) =>  Checkout()),);
                    },
                    child:Text("Check out", style: TextStyle(color: Colors.white)),
                  color: Theme.of(context).primaryColor,

                ),
            )
          ],
        ),
      ),
    );
  }
}
