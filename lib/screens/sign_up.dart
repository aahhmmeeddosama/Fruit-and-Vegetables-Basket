import 'package:flutter/material.dart';
import 'package:flutter_application_6/Provider/auth.dart';
import '../model/http_exception.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  static const routeName = '/sign-up';
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

enum AuthMode { login, signUp }

class _SignUpState extends State<SignUp> {
  final _form = GlobalKey<FormState>();
  final emailChecker = TextEditingController();
  final passChecker = TextEditingController();
  final repassChecker = TextEditingController();
  final cityChecker = TextEditingController();
  final phoneChecker = TextEditingController();
  bool _isloading = false;
  final AuthMode _authMode = AuthMode.signUp;
  final Map<String, String> _SignUp_Map = {
    'email': '',
    'password': '',
    'phone': '',
    'city': ''
  };
  @override
  void dispose() {
    emailChecker.dispose();
    passChecker.dispose();
    repassChecker.dispose();
    cityChecker.dispose();
    phoneChecker.dispose();
    super.dispose();
  }

  void _printemailState() {
    // ignore: avoid_print
    print("First Text : ${emailChecker.text}");
  }

  void _printpassState() {
    // ignore: avoid_print
    print("Second Text : ${passChecker.text}");
  }

  void _printrepassState() {
    // ignore: avoid_print
    print("Third Text : ${repassChecker.text}");
  }

  void _printphoneState() {
    // ignore: avoid_print
    print("Fourth Text : ${phoneChecker.text}");
  }

  void _printcityState() {
    // ignore: avoid_print
    print("Fifth Text : ${cityChecker.text}");
  }

  @override
  void initState() {
    super.initState();
    emailChecker.addListener(_printemailState);
    passChecker.addListener(_printpassState);
    cityChecker.addListener(_printcityState);
    repassChecker.addListener(_printrepassState);
    phoneChecker.addListener(_printphoneState);
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
      if (_authMode == AuthMode.signUp) {
        print(3);
        await Provider.of<Auth>(context, listen: false).signup(
          _SignUp_Map['email']!,
          _SignUp_Map['password']!,
        );
        print(4);
        await Provider.of<Auth>(context, listen: false).signUp1(
          _SignUp_Map['email']!,
          _SignUp_Map['phone']!,
          _SignUp_Map['city']!,
        );
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
      String errorMessage = "Coudn't Authnticate";
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
              Text(
                "Sign Up",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 200, bottom: 30),
              ),
              Form(
                key: _form,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailChecker,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _SignUp_Map['email'] = value.toString();
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.mail,
                              color: Theme.of(context).primaryColor),
                          hintText: 'Please enter your email',
                          labelText: 'Email *',
                        ),
                      ),
                      TextFormField(
                        controller: passChecker,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length <= 8) {
                            return 'Password is too short need to be more than 8 characters';
                          }

                          return null;
                        },
                        onSaved: (value) {
                          _SignUp_Map['password'] = value.toString();
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock,
                              color: Theme.of(context).primaryColor),
                          hintText: 'Please enter your password',
                          labelText: 'Password *',
                        ),
                        obscureText: true,
                      ),
                      TextFormField(
                          controller: repassChecker,
                          validator: (value) {
                            if (value != passChecker.text) {
                              return "Password don't match";
                            }

                            return null;
                          },
                          onSaved: (value) {
                            _SignUp_Map['repassword'] = value.toString();
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock,
                                color: Theme.of(context).primaryColor),
                            hintText: 'Please-re enter your password',
                            labelText: 'Re-Enter Password *',
                          ),
                          obscureText: true),
                      TextFormField(
                        controller: phoneChecker,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }

                          return null;
                        },
                        onSaved: (value) {
                          _SignUp_Map['phone'] = value.toString();
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone,
                              color: Theme.of(context).primaryColor),
                          hintText: 'Please enter your phone number',
                          labelText: 'Phone *',
                        ),
                      ),
                      TextFormField(
                        controller: cityChecker,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your city name';
                          }

                          return null;
                        },
                        onSaved: (value) {
                          _SignUp_Map['city'] = value.toString();
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.home,
                              color: Theme.of(context).primaryColor),
                          hintText: 'Please enter your city name',
                          labelText: 'City *',
                        ),
                      ),
                      if (_isloading) const CircularProgressIndicator(),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary:
                                Theme.of(context).primaryColor, // background
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
                            'Sign Up',
                            style: TextStyle(fontSize: 16),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
