import 'package:flutter/material.dart';
import 'dart:convert';
import 'product_provider.dart';
import 'package:http/http.dart' as http;
import '../model/http_exception.dart';

//with is mixin
class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
        imagename: 'assets/banana.jpg',
        name: 'Banana',
        price: 10.00,
        description: 'Fresh Banana Fruit',
        id: '9',
        title: 'Fruits'),
    Product(
        imagename: 'assets/orange.jpg',
        name: 'Orange',
        price: 7.50,
        description: 'Fresh Banana Fruit',
        id: '7',
        title: 'Fruits'),
    Product(
        imagename: 'assets/Strawberry.jpg',
        name: 'Strawberry',
        price: 20.00,
        description: 'Fresh Strawberry Fruit',
        id: '2',
        title: 'Fruits'),
    Product(
        imagename: 'assets/pomegranate.jpg',
        name: 'Pomegranate',
        price: 15.00,
        description: 'Fresh Pomegranate Fruit',
        id: '6',
        title: 'Fruits'),
    Product(
        imagename: 'assets/tomato.jpg',
        name: 'Tomato',
        price: 8.00,
        description: 'Fresh Tomato Vegetable',
        id: '11',
        title: 'Vegetables'),
    Product(
        imagename: 'assets/carrots.jpg',
        name: 'Carrot',
        price: 6.00,
        description: 'Fresh carrot Vegetable',
        id: '14',
        title: 'Vegetables'),
    Product(
        imagename: 'assets/cucumber.jpg',
        name: 'Cucumber',
        price: 5.00,
        description: 'Fresh Cucumber Vegetable',
        id: "10",
        title: 'Vegetables')
  ];
  String token = '';
  String userID = '';
  getData(String token, String userid, List<Product> products) {
    token = token;
    userID = userid;
    _items = products;
    notifyListeners();
  }

  List<Product> get items {
    //spread opertor
    return [..._items];
  }

//return list of favorite items
  List<Product> get FavouriteItems {
    return _items.where((product) => product.isFavourite).toList();
  }

  Product findById(String id) {
    //first where to get the first product that satisfy this data
    return _items.firstWhere((product) => product.id == id);
  }

  Future<void> fetchProducts([bool filterByUser = false]) async {
    final filteredString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userID"' : '';
    var url =
        'https://fruits-vegetables-basket-19e0d-default-rtdb.firebaseio.com/products.json?auth=$token&$filteredString';
    try {
      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body) as Map<String, dynamic>;
      if (data == null) {
        return;
      }
      url =
          'https://fruits-vegetables-basket-19e0d-default-rtdb.firebaseio.com/userFavourites/$userID.json?auth=$token';
      final favouriteResponse = await http.get(Uri.parse(url));
      final favouriteData = json.decode(favouriteResponse.body);
      final List<Product> gettedproducts = [];
      /*data.forEach((productid, productData) {
        gettedproducts.add(
          Product(
            id: productid,
            title: productData['title'],
            description: productData['description'],
            imagename: productData['imagename'],
            price: productData['price'],
            name: productData['name'],
            isFavourite: favouriteData == null
                ? false
                : favouriteData[productid] ?? false,
          ),
        );
      });*/
      //_items = gettedproducts;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addProduct(Product product) async {
    final url =
        'https://fruits-vegetables-basket-19e0d-default-rtdb.firebaseio.com/products.json?auth=$token';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imagename': product.imagename,
            'creatorId': userID,
            'name': product.name
          }));
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        imagename: product.imagename,
        name: product.name,
        price: product.price,
        description: product.description,
        title: product.title,
      );
      _items.add(newProduct);
      //insert can add data in the begin while add at the end
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateProduct(String id, Product newproduct) async {
    final index = _items.indexWhere((product) => product.id == id);
    if (index >= 0) {
      final url =
          'https://fruits-vegetables-basket-19e0d-default-rtdb.firebaseio.com/products/$id.json?auth=$token';
      await http.patch(Uri.parse(url),
          body: json.encode({
            'title': newproduct.title,
            'description': newproduct.description,
            'price': newproduct.price,
            'imagename': newproduct.imagename,
            'name': newproduct.name
          }));
      _items[index] = newproduct;
      notifyListeners();
    } else {
      print("nothing");
    }
  }

  Future<void> deleteProduct(String id, Product newproduct) async {
    final url =
        'https://fruits-vegetables-basket-19e0d-default-rtdb.firebaseio.com/products/$id.json?auth=$token';
    final index = _items.indexWhere((product) => product.id == id);
    Product? existingData = _items[index];
    _items.removeAt(index);
    notifyListeners();

    final response = await http.delete(Uri.parse(url));
    if (response.statusCode >= 400) {
      items.insert(index, existingData);

      notifyListeners();
      throw HttpException("This product can't be deleted");
    }
    existingData = null;
  }
}
