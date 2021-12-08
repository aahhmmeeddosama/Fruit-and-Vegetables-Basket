
import 'package:flutter/material.dart';



class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Vegetable")),
      body: ListView(
        children: [
          AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text("MY ACCOUNT"),

          ),
          Card(
              child: ListTile(
                leading: Icon(
                  Icons.favorite_rounded,
                  color: Theme.of(context).primaryColor
    ,
                ),
                title: Text("Wishlist"),
              )),
          Card(
            child: ListTile(
              leading: Icon(
                Icons.payment_rounded,
                color: Theme.of(context).primaryColor,
              ),
              title: Text("Payment"),
            ),
          ),
          Card(
              child: ListTile(
                leading: Icon(
                  Icons.local_shipping_rounded,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text("Shipped"),
              )),
          Card(
              child: ListTile(
                leading: Icon(
                  Icons.people_outline_rounded,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text("Profile"),
              )),
          Card(
              child: ListTile(
                leading: Icon(
                  Icons.card_giftcard_rounded,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text("Gift Cards"),
              )),
          Card(
              child: ListTile(
                leading: Icon(
                  Icons.location_on_rounded,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text("Addresses"),
              )),
          Card(
              child: ListTile(
                leading: Icon(
                  Icons.grid_view_rounded,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text("Recently Viewed"),
              )),
        ],
        // shrinkWrap: true,
      ),
    );
  }
}
