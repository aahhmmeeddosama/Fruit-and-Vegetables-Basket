import 'package:flutter/material.dart';

class CartItem{
  final product_name;
  final product_picture;
  final product_quantity;
  final product_price;
  CartItem({
    this.product_name,
    this.product_picture,
    this.product_quantity,
    this.product_price
});
}

class Cart with ChangeNotifier{
  Map<String, CartItem> _items={};
  Map<String, CartItem> get items{
    return {..._items};
  }
  int get itemCount{
    return _items.length;
  }
  double get totalAmount{
    var total=0.0;
    _items.forEach((key, CartItem) {
      total+= CartItem.product_price*CartItem.product_quantity;
    });
    return total;
  }

  void addItem(productName,productPrice ){
    if(_items.containsKey(productName)){
      _items.update(productName, (existingCartItem) => CartItem(
        product_name:existingCartItem.product_name,
        product_price: existingCartItem.product_price,
        product_quantity: existingCartItem.product_quantity+1,

      ));
    }else{
      _items.putIfAbsent((productName), () => CartItem(
        product_name: DateTime.now().toString(),
        product_quantity: 1,
        product_price: productPrice,
      ),);
      
    }
    notifyListeners();
  }

  void removItem(productName){
    _items.remove(productName);
    notifyListeners();
  }

  void removSingleItem(productName){
    if(!_items.containsKey(productName))
      return;
    if(_items[productName]!.product_quantity>1){
      _items.update(productName, (existingCartItem) => CartItem(
        product_name:existingCartItem.product_name,
        product_price: existingCartItem.product_price,
        product_quantity: existingCartItem.product_quantity-1,
      ));
    }else{
      _items.remove(productName);
    }
    notifyListeners();
  }

  void clear(){
    _items={};
    notifyListeners();
  }

}