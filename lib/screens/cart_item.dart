import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;
  //final String imagename;
  final String name;

  CartItem(
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.name,
    this.title,
    //this.imagename
  );

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (innerContext) => AlertDialog(
            title: Text('Are you sure!'),
            content: Text('Do you want to remove the cart item?'),
            actions: <Widget>[
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(innerContext).pop(false);
                },
              ),
              FlatButton(
                child: Text("Yes"),
                onPressed: () {
                  Navigator.of(innerContext).pop(true);
                },
              )
            ],
          ),
        );
      },
      onDismissed: (direction) {
        // if(direction == DismissDirection.endToStart) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
        // }
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: FittedBox(
                child: Text(name),
              ), /*child: CircleAvatar(
                  radius: 200,
                  backgroundColor: Colors.transparent,
                  backgroundImage: //NetworkImage(imagename),
                ),*/
            )),
            title: Text(name),
            subtitle: Text("Total:  ${(price * quantity)} \EGP"),
            trailing: Text("$quantity x"),
          ),
        ),
      ),
    );
  }
}
