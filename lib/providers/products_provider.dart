import 'package:flutter/material.dart';
import 'dart:convert';
import 'product_provider.dart';
import 'package:http/http.dart' as http;
import '../model/http_exception.dart';
import 'package:network_image_mock/network_image_mock.dart';

//with is mixin
class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
        imagename:
            'https://www.seekpng.com/png/detail/34-341853_banana-png-image-with-transparent-background-1-pound.png',
        name: 'Banana',
        price: 10.00,
        description: 'Fresh Banana Fruit',
        id: '9',
        title: 'Fruits'),
    Product(
        imagename:
            'https://healthjade.com/wp-content/uploads/2017/10/orange-fruit.jpg',
        name: 'Orange',
        price: 7.50,
        description: 'Fresh Banana Fruit',
        id: '7',
        title: 'Fruits'),
    Product(
        imagename:
            'https://pharmanewsonline.com/wp-content/uploads/2021/08/Berry.jpg',
        name: 'Strawberry',
        price: 20.00,
        description: 'Fresh Strawberry Fruit',
        id: '2',
        title: 'Fruits'),
    Product(
        imagename:
            'https://png.pngitem.com/pimgs/s/134-1343541_download-pomegranate-png-clipart-pomegranate-png-transparent-png.png',
        name: 'Pomegranate',
        price: 15.00,
        description: 'Fresh Pomegranate Fruit',
        id: '6',
        title: 'Fruits'),
    Product(
        imagename:
            'https://www.pngitem.com/pimgs/m/21-214249_tomato-png-transparent-tomato-png-png-download.png',
        name: 'Tomato',
        price: 8.00,
        description: 'Fresh Tomato Vegetable',
        id: '11',
        title: 'Vegetables'),
    Product(
        imagename:
            'https://www.kindpng.com/picc/m/111-1115732_carrots-png-image-transparent-carrots-png-png-download.png',
        name: 'Carrot',
        price: 6.00,
        description: 'Fresh carrot Vegetable',
        id: '14',
        title: 'Vegetables'),
    Product(
        imagename:
            'https://www.pngkit.com/png/detail/340-3405491_cucumbers-png-photos-transparent-background-cucumber-transparent.png',
        name: 'Cucumber',
        price: 5.00,
        description: 'Fresh Cucumber Vegetable',
        id: "10",
        title: 'Vegetables')
  ];
  String token = '';
  String userID = '';
  getData(String Usertoken, String userid, List<Product> products) {
    token = Usertoken;
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
        'https://fruitapp-8455c-default-rtdb.firebaseio.com/products.json?auth=$token&$filteredString';
    try {
      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body) as Map<String, dynamic>;
      if (data == null) {
        return;
      }
      url =
          'https://fruitapp-8455c-default-rtdb.firebaseio.com/userFavourites/$userID.json?auth=$token';
      final favouriteResponse = await http.get(Uri.parse(url));
      final favouriteData = json.decode(favouriteResponse.body);
      final List<Product> gettedproducts = [];
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  //marian
  Future<void> addProduct(Product product) async {
    const url =
        'https://fruitapp-8455c-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imagename': product.imagename,
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
      print(e);
      throw e;
    }
  }

  Future<void> updateProduct(String id, Product newproduct) async {
    final index = _items.indexWhere((product) => product.id == id);
    if (index >= 0) {
      final url =
          'https://fruitapp-8455c-default-rtdb.firebaseio.com/products/$id.json?auth=$token';
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

  Future<void> deleteProduct(String id) async {
    final url =
        'https://fruitapp-8455c-default-rtdb.firebaseio.com/products/$id.json?auth=$token';
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
