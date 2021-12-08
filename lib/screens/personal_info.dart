import 'package:flutter/material.dart';

class personal_info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool passenable = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Personal Information")),
      body: Container(
        child: Column(
          children: [
            AppBar(
              leading: Image.asset('assets/carrots.jpg'),
              title: Text('Ahmed'),
            ),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.account_circle_outlined,
                ),
                hintText: "mohammed",
                labelText: 'Username',
              ),
            ),
            TextField(
              obscureText:
                  passenable, //if passenable == true, show **, else show password character
              decoration: InputDecoration(
                  hintText: "Pass1234",
                  labelText: "New password",
                  prefixIcon: IconButton(
                      onPressed: () {
                        //add Icon button at end of TextField
                        setState(() {
                          //refresh UI
                          if (passenable) {
                            //if passenable == true, make it false
                            passenable = false;
                          } else {
                            passenable =
                                true; //if passenable == false, make it true
                          }
                        });
                      },
                      icon: Icon(passenable == true
                          ? Icons.remove_red_eye
                          : Icons.password))
                  //eye icon if passenable = true, else, Icon is ***__
                  ),
            ),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.email_rounded,
                ),
                hintText: "mohamed@miuegypt.edu.eg",
                labelText: 'Email Address',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.phone_android_rounded,
                ),
                 hintText: "0100030401",
                labelText: 'Phone number',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
