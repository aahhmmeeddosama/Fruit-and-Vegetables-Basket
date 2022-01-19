import 'package:flutter/material.dart';
// import 'package:edit_profile_info/screens/personal_info.dart';
import 'package:profile_editing2/pages/profile_page.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: const Text("MY ACCOUNT"),
          ),
          Card(
              child: ListTile(
            leading: Icon(
              Icons.favorite_rounded,
              color: Theme.of(context).primaryColor,
            ),
            title: const Text("Wishlist"),
          )),
          Card(
            child: ListTile(
              leading: Icon(
                Icons.payment_rounded,
                color: Theme.of(context).primaryColor,
              ),
              title: const Text("Cart"),
            ),
          ),
          Card(
              child: ListTile(
            leading: Icon(
              Icons.local_shipping_rounded,
              color: Theme.of(context).primaryColor,
            ),
            title: const Text("Shipped"),
          )),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              );
            },
            child: Card(
                child: ListTile(
                  leading: Icon(
                    Icons.people_outline_rounded,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: const Text("Profile Edit"),
                  
                )),
          ),
          // Card(
          //     child: ListTile(
          //   leading: Icon(
          //     Icons.card_giftcard_rounded,
          //     color: Theme.of(context).primaryColor,
          //   ),
          //   title: const Text("Gift Cards"),
          // )),
          Card(
              child: ListTile(
            leading: Icon(
              Icons.location_on_rounded,
              color: Theme.of(context).primaryColor,
            ),
            title: const Text("Addresses"),
          )),
          Card(
              child: ListTile(
            leading: Icon(
              Icons.grid_view_rounded,
              color: Theme.of(context).primaryColor,
            ),
            title: const Text("Recently Viewed"),
          )),
        ],
      ),
    );
  }
}
