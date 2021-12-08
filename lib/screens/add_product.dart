import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruit_shop/screens/home_screen.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed tp Pick image :$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          reverse: true,
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.only(left: 50, bottom: 100)),
              Text("Add New Product",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor)),
              const Padding(padding: EdgeInsets.only(left: 200, bottom: 30)),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon:
                  Icon(Icons.notes, color: Theme.of(context).primaryColor),
                  hintText: 'Please enter your new product name',
                  labelText: 'Product Name',
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.category,
                      color: Theme.of(context).primaryColor),
                  hintText: 'Please choose your product category',
                  labelText: 'Product Category *',
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon:
                  Icon(Icons.paid, color: Theme.of(context).primaryColor),
                  hintText: 'Please enter your product price',
                  labelText: 'Product Price *',
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon:
                  Icon(Icons.image, color: Theme.of(context).primaryColor),
                  hintText: 'Please choose your product image',
                  labelText: 'Product Image *',
                ),
              ),
              ElevatedButton(
                  onPressed: () => pickImage(),
                  child: const Text('Choose Image')),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor, // background
                    onPrimary: Colors.white,
                    // foreground
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HomeScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Add',
                    style: TextStyle(fontSize: 16),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
