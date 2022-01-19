import 'package:flutter/material.dart';

class OrderItem{
  final product_name;
  final amount;
  final List<OrderItem> products;
  final dateTime;
  OrderItem({
    this.product_name,
    this.amount,
    required this.products,
    this.dateTime
  });
}

class Orders with ChangeNotifier{
  List<OrderItem> _orders=[];
  var authToken;
  var userId;
  getData(authToken,uId , List<OrderItem> orders){
    authToken=authToken;
    userId=uId;
    _orders=orders;
    notifyListeners();
  }

  List<OrderItem> get orders{
    return[..._orders];
  }

}