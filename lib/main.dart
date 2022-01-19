import 'package:flutter/material.dart';
import 'package:product_detail/product_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: productdetail(),
      ),
    );
  }
}
