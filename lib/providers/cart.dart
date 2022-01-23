import 'package:flutter/material.dart';
import 'package:fruit_shope/model/cart_item.dart' show  CartItem;
import 'package:fruit_shope/model/order_item.dart' show  OrderItem;


class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, CartItem) {
      total += CartItem.price * CartItem.quantity;
    });
    return total;
  }

  void addItem(String productId, double price, String title, String name) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (exisitingCartItem) => CartItem(
          id: exisitingCartItem.id,
          title: exisitingCartItem.title,
          price: exisitingCartItem.price,
          name: exisitingCartItem.name,
          quantity: exisitingCartItem.quantity + 1,
          //imagename: exisitingCartItem.imagename,
        ),
      );
    } else {
      _items.putIfAbsent(
        //law product asln msh mwgood (putIfAbsent)
        productId,
        () => CartItem(
          id: DateTime.now().toString(), //date el product et7at fe fl cart
          title: title,
          quantity: 1,
          price: price,
          name: name,
          //imagename: imagename
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String ProductId) {
    if (!_items.containsKey(ProductId)) {
      //law item not contain that key
      return; //stop ba2a
    }
    if (_items[ProductId]!.quantity > 1) {
      //nul????????????
      _items.update(
        ProductId,
        (exisitingCartItem) => CartItem(
          id: exisitingCartItem.id,
          title: exisitingCartItem.title,
          price: exisitingCartItem.price,
          name: exisitingCartItem.name,
          quantity: exisitingCartItem.quantity + 1,
          //imagename: exisitingCartItem.imagename
        ),
      );
    } else {
      _items.remove(ProductId);
    }
    notifyListeners();
  }

  void clear() {
    //clear all
    _items = {};
    notifyListeners();
  }
}
