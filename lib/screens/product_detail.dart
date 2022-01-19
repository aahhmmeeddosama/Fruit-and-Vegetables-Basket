import 'package:flutter/material.dart';

class productdetail extends StatefulWidget {
  const productdetail({Key? key}) : super(key: key);

  @override
  _productdetailState createState() => _productdetailState();
}

class _productdetailState extends State<productdetail> {
  bool _isFavorited = false;

  final _formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController nameController2 = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();

    nameController2.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _isFavorited = false;
      } else {
        _isFavorited = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context, false),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Column(
                children: [
                  Image.asset('assets/Tomato_je.jpeg'),
                  Row(children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Tomato',
                          style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Text(
                              'EGP',
                              style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              '5',
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Quantity',
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 200.0,
                      height: 10,
                    ),
                    Container(
                      child: IconButton(
                        icon: (_isFavorited
                            ? Icon(
                                Icons.star,
                                size: 40.0,
                              )
                            : Icon(
                                Icons.star_border,
                                size: 40.0,
                              )),
                        color: Colors.red[500],
                        onPressed: _toggleFavorite,
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 10,
                  ),
                  Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'enter Quantity in KG',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter Quantity';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                              ),
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('processing data')),
                                  );
                                }

                                print('text field : ${nameController.text}');
                              },
                              child: Text('Ok'),
                            )),
                        Row(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              'Comment',
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: nameController2,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'leave comment',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter your comment';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                              ),
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('processing data')),
                                  );
                                }

                                print('text field : ${nameController2.text}');
                              },
                              child: Text('Ok'),
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              side: BorderSide(width: 3),
                              elevation: 6,
                            ),
                            onPressed: () {},
                            child: Text('Add to cart')),
                      ],
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
