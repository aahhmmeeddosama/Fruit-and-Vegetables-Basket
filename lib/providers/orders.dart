import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fruit_shope/Provider/cart.dart';
import 'package:fruit_shope/Provider/product_provider.dart';
import 'package:fruit_shope/Provider/products_provider.dart';
import 'package:fruit_shope/model/cart_products.dart';
import 'package:http/http.dart' as http;
import 'package:fruit_shope/model/cart_item.dart' show  CartItem;
import 'package:fruit_shope/model/order_item.dart' show  OrderItem;



//with is mixin
class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  String token = '';
  String userID = '';

  getData(String Usertoken, String userid, List<OrderItem> orders) {
    token = Usertoken;
    userID = userid;
    _orders = orders;
    notifyListeners();
  }

  List<OrderItem> get orders {
    //spread opertor
    return [..._orders];
  }

  Future<void> fetchOrders() async {
    final url =
        'https://fruits-vegetables-basket-19e0d-default-rtdb.firebaseio.com/orders/$userID.json?auth=$token';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<OrderItem> loadedOrders = [];
      extractedData.forEach((OrderId, ordertData) {
        loadedOrders.add(
          OrderItem(
            id: OrderId,
            amont: ordertData['amount'],
            dateTime: DateTime.parse(ordertData['dateTime']),
            products: (ordertData['products'] as List<dynamic>)
                .map((item) => CartItem(
              id: item['id'],
              price: item['price'],
              quantity: item['quantity'],
              title: item['title'],
              name: item['name'],
              //imagename: item['imagename']
            ))
                .toList(),
          ),
        );
      });
      _orders = loadedOrders.reversed.toList(); //akher order yegy awel wahd
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addOrder(List<CartItem> cartProduct, double total) async {
    final url =
        'https://fruits-vegetables-basket-19e0d-default-rtdb.firebaseio.com/orders/$userID.json?auth=$token';
    try {
      final timestamp = DateTime.now();
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'amount': total,
            'dateTime': timestamp.toIso8601String(),
            'product': cartProduct
                .map((cp) => {
              'id': cp.id,
              'title': cp.title,
              'quantity': cp.quantity,
              'price': cp.price,
            })
                .toList(),
          }));
      _orders.insert(
          0,
          OrderItem(
            id: json.decode(response.body)['name'],
            amont: total,
            dateTime: timestamp,
            products: cartProduct,
          ));
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
