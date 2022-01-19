import 'package:flutter/material.dart';
import 'package:fruit_shop/screens/my_account.dart';

class personal_info extends StatelessWidget {
  const personal_info({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class MyHomePageState extends StatefulWidget {
  const MyHomePageState({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _form = GlobalKey<FormState>();
  final emailChecker = TextEditingController();
  final passChecker = TextEditingController();
  final repassChecker = TextEditingController();
  final usernameChecker = TextEditingController();
  final phoneChecker = TextEditingController();
  @override
  void dispose() {
    emailChecker.dispose();
    passChecker.dispose();
    repassChecker.dispose();
    usernameChecker.dispose();
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

  void _printuserState() {
    // ignore: avoid_print
    print("Fifth Text : ${usernameChecker.text}");
  }

  @override
  void initState() {
    super.initState();
    emailChecker.addListener(_printemailState);
    passChecker.addListener(_printpassState);
    usernameChecker.addListener(_printuserState);
    repassChecker.addListener(_printrepassState);
    phoneChecker.addListener(_printphoneState);
  }

  bool passenable = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Personal Information")),
      body: Container(
        child: Column(
          children: [
            AppBar(
              leading: Image.asset('assets/carrots.jpg'),
              title: const Text('abc'),
            ),
            Form(
              key: _form,
              child: Column(
                children: [
                  TextFormField(
                    controller: usernameChecker,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }

                      return null;
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.account_circle_outlined,
                      ),
                      hintText: "mohammed",
                      labelText: 'Username',
                    ),
                  ),
                  TextFormField(
                    controller: passChecker,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your city name';
                      }

                      return null;
                    },
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
                  TextFormField(
                    controller: emailChecker,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your city name';
                      }

                      return null;
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.email_rounded,
                      ),
                      hintText: "mohamed@miuegypt.edu.eg",
                      labelText: 'Email Address',
                    ),
                  ),
                  TextFormField(
                    controller: phoneChecker,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your city name';
                      }

                      return null;
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone_android_rounded,
                      ),
                      hintText: "0100030401",
                      labelText: 'Phone number',
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor, // background
                        onPrimary: Colors.white,
                        // foreground
                      ),
                      onPressed: () {
                        if (_form.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyAccount(),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 16),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
