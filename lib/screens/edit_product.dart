import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruit_shope/Provider/product_provider.dart';
import 'package:fruit_shope/Provider/products_provider.dart';
import 'package:provider/provider.dart';

class EditProduct extends StatefulWidget {
  //static const routeName = '/edit-product';
  const EditProduct({Key? key, required this.id}) : super(key: key);
  final id;
  @override
  _EditProductState createState() => _EditProductState(id);
  //State<EditProduct> createState() => _EditProductState(id);
}

//int ID = id;
@override
class _EditProductState extends State<EditProduct> {
  final _price = FocusNode();
  final _description = FocusNode();
  final _image = FocusNode();
  final _imageUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _editedProduct = Product(
      id: '', title: '', description: '', price: 0, imagename: '', name: '');
  var _initialValues = {
    'title': '',
    'description': '',
    'price': '',
    'imagename': '',
    'name': ''
  };
  var _isLoading = false;
  var _isInit = true;

  _EditProductState(this.id);
  final id;
  @override
  void initState() {
    super.initState();
    _imageUrlController.addListener((_updateImage));
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      //final productId = ModalRoute.of(context)!.settings.arguments as String;
      if (id != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(id);
        _initialValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'imagename': _editedProduct.imagename,
          'name': _editedProduct.name,
        };
        _imageUrlController.text = _editedProduct.imagename;
      }
      _isInit = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _imageUrlController.removeListener(_updateImage);
    _price.dispose();
    _imageUrlController.dispose();
    _image.dispose();
    _description.dispose();
  }

  void _updateImage() {
    if (!_image.hasFocus) {
      if (_imageUrlController.text.isEmpty ||
          (!_imageUrlController.text.startsWith('http') ||
              _imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') ||
              !_imageUrlController.text.endsWith('.jpg') ||
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedProduct.id != null) {
      await Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
      //Navigator.of(context).pop();
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct);
        //Navigator.of(context).pop();
      } catch (e) {
        await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('An error occured!'),
                  content: Text('Something went wrong.'),
                  actions: [
                    FlatButton(
                      child: Text('Okay!'),
                      onPressed: () {
                        Navigator.pop(
                          ctx,
                        );
                      },
                    )
                  ],
                ));
      }
    }
    setState(() {
      _isLoading = false;
    });

    Navigator.pop(
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Edit Product'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.all(8),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _initialValues['title'],
                      decoration: InputDecoration(labelText: 'Title'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_price);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please set a value';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            description: _editedProduct.description,
                            name: _editedProduct.name,
                            imagename: _editedProduct.imagename,
                            price: _editedProduct.price,
                            title: value!,
                            isFavourite: _editedProduct.isFavourite);
                      },
                    ),
                    TextFormField(
                      initialValue: _initialValues['price'],
                      decoration: const InputDecoration(labelText: 'price'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_description);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a price';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid price';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Please enter anumber greater than 0';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            description: _editedProduct.description,
                            name: _editedProduct.name,
                            imagename: _editedProduct.imagename,
                            price: double.parse(value!),
                            title: _editedProduct.title,
                            isFavourite: _editedProduct.isFavourite);
                      },
                    ),
                    TextFormField(
                      initialValue: _initialValues['description'],
                      decoration: InputDecoration(labelText: 'description'),
                      maxLines: 2,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_description);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please set a value';
                        }
                        if (value.length < 5) {
                          return 'Description Should be greater than 5 characters';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            description: value!,
                            name: _editedProduct.name,
                            imagename: _editedProduct.imagename,
                            price: _editedProduct.price,
                            title: _editedProduct.title,
                            isFavourite: _editedProduct.isFavourite);
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(top: 8, right: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? Text('Enter a url')
                              : FittedBox(
                                  child: Image.network(_imageUrlController.text,
                                      fit: BoxFit.cover),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _imageUrlController,
                            decoration: InputDecoration(labelText: 'Image'),
                            maxLines: 2,
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.next,
                            focusNode: _image,
                            onFieldSubmitted: (value) => _saveForm(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an image url';
                              }
                              if (value.endsWith('.png') &&
                                  value.endsWith('.jpg') &&
                                  value.endsWith('.jpeg')) {
                                return "please enter a valid url";
                              }

                              return null;
                            },
                            onSaved: (value) {
                              _editedProduct = Product(
                                  id: _editedProduct.id,
                                  description: _editedProduct.description,
                                  name: _editedProduct.name,
                                  imagename: value!,
                                  price: _editedProduct.price,
                                  title: _editedProduct.title,
                                  isFavourite: _editedProduct.isFavourite);
                            },
                            onEditingComplete: () {
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
