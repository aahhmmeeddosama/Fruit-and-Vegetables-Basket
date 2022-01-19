import 'package:flutter/material.dart';
import 'package:profile_editing2/pages/profile_page.dart';
// import 'package:profile_editing2/pages/menu.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Information Editing',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.black,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  primary: Colors.green[500],
                  shadowColor: Colors.grey,
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0.0))))),
          inputDecorationTheme: InputDecorationTheme(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(0.0))),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              alignment: Alignment.centerLeft,
              primary: Colors.black,
            ),
          )),
      // home: MyAccount(),
     home: ProfilePage(),
    );
  }
}
