import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/auth.dart';
import '../screens/home_screen.dart';
import '../screens/sign_up.dart';

import '../model/http_exception.dart';

class sign_in extends StatefulWidget {
  static const routeName = '/Sign-in-updated';
  const sign_in({Key? key}) : super(key: key);

  @override
  _sign_inState createState() => _sign_inState();
}

enum AuthMode { Login, SignUp }

class _sign_inState extends State<sign_in> with SingleTickerProviderStateMixin {
  final _form = GlobalKey<FormState>();
  final emailChecker = TextEditingController();
  final passChecker = TextEditingController();
  bool _isloading = false;
  final AuthMode _authMode = AuthMode.Login;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;
  final Map<String, String> _SignIn_Map = {
    "email": "",
    "password": "",
  };
  @override
  void dispose() {
    super.dispose();
    emailChecker.dispose();
    passChecker.dispose();
    _controller.dispose();
  }

  void _printemailState() {
    // ignore: avoid_print
    print("First Text : ${emailChecker.text}");
  }

  void _printpassState() {
    // ignore: avoid_print
    print("Second Text : ${passChecker.text}");
  }

  @override
  void initState() {
    super.initState();
    //used single mixin for vsync
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, -0.30), end: const Offset(0, 0.30))
            .animate(
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
    );
    //to appear in a time = 1 and disappear in another that is 1.0
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller, curve: Curves.fastLinearToSlowEaseIn),
    );
    emailChecker.addListener(_printemailState);
    passChecker.addListener(_printpassState);
  }

  Future<void> _submit() async {
    if (!_form.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    _form.currentState!.save();
    setState(() {
      _isloading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        await Provider.of<Auth>(context, listen: false)
            .login(_SignIn_Map['email']!, _SignIn_Map['password']!);
      }
    } on HttpException catch (error) {
      String errormessage = 'Authentication failed';
      if (error.toString().contains("EMAIL_EXISTS")) {
        errormessage = "email is already in use";
      } else if (error.toString().contains("INVALID_EMAIL")) {
        errormessage = "Invalid email";
      } else if (error.toString().contains("WEAK_PASSWORD")) {
        errormessage = "Passwork is too weak";
      } else if (error.toString().contains("EMAIL_NOT_FOUND")) {
        errormessage = "Couldn't find user with that email";
      } else if (error.toString().contains("INVALID_PASSWORD")) {
        errormessage = " invalid password";
      }
      _showErrorDialog(errormessage);
    } catch (error) {
      String errorMessage = "Coudn't Authenticate";
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isloading = false;
    });
  }

  void _showErrorDialog(String errormessage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error Occured"),
        content: Text(errormessage),
        actions: [
          FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('okay')),
        ],
      ),
    );
  }

  bool _obsecure = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /*Image.asset(
              'assets/signin/Fruits-and-Vegetables.jpg',
              width: size.width,
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    "Fruits & Vegtables",
                    //primary color that is green found in the main
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //The title that appear before the text area
                const Padding(
                  padding: EdgeInsets.only(left: 10, top: 200),
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),*/
            //const Padding(padding: EdgeInsets.all(0), child: sign_in()),
            //add the image and full the screen width

            Padding(
              padding: const EdgeInsets.only(top: 5.0, bottom: 50.0),
              child: (Form(
                key: _form,
                child: Padding(
                  padding: EdgeInsets.only(top: size.height / 2),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailChecker,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !value.contains('@')) {
                            return 'Incorrect email';
                          }

                          return null;
                        },
                        onSaved: (value) {
                          _SignIn_Map['email'] = value.toString();
                        },
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: passChecker,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is not entered';
                          }
                          if (value.length <= 8) {
                            return 'Password is not correct';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          //To show the user the input that need to be entered
                          hintText: 'Password',
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.green,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                // Toggle light when tapped.
                                _obsecure = !_obsecure;
                              });
                            },
                            child: Icon(
                              _obsecure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        obscureText: _obsecure,
                        onSaved: (value) {
                          _SignIn_Map['password'] = value.toString();
                        },
                      ),
                      if (_isloading) const CircularProgressIndicator(),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //const SignInTextField(),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Theme.of(context)
                                    .primaryColor, // background
                                onPrimary: Colors.white,
                                // foreground
                              ),
                              onPressed: () {
                                if (_form.currentState!.validate()) {
                                  // If the form is valid, display a snackbar. In the real world,
                                  // you'd often call a server or save the information in a database.
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Processing Data')),
                                  );
                                  _submit();
                                }
                              },
                              child: const Text(
                                'LogIn',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),

              /* Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsets.only(bottom: size.height / 1)),
                    InkWell(
                      onTap: () {},
                      child: const Text("Forget Password?",
                          style: TextStyle(fontSize: 16)),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 20, top: 0)),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()),
                        );
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),*/
            ),
          ],
        ),
      ),
    );
  }
}
