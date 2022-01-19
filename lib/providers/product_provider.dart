import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//with is mixin
class Product with ChangeNotifier {
  @required
  String id;
  @required
  String imagename;
  @required
  String name;
  @required
  double price;
  @required
  String title;
  bool isFavourite;
  @required
  String description;
  Product(
      {required this.imagename,
      required this.name,
      required this.price,
      required this.description,
      required this.title,
      required this.id,
      this.isFavourite = false});

  //to make toogle favourite
  void _setFavouriteValue(bool newValue) {
    isFavourite = newValue;
    notifyListeners();
  }

  Future<void> toogleFavourite(String token, String userId) async {
    //save the previous toogle inorder if it was failed to do it so that return to its previous state
    final previoustoogle = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();

    final url =
        'https://fruits-vegetables-basket-19e0d-default-rtdb.firebaseio.com/userFavourites/$userId/$id.json?auth=$token';
    try {
      final response =
          //.put to update one data only
          await http.put(Uri.parse(url), body: json.encode(isFavourite));
      if (response.statusCode >= 400) {
        _setFavouriteValue(previoustoogle);
      }
    } catch (error) {
      _setFavouriteValue(previoustoogle);
    }
  }
}
