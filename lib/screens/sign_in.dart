import 'package:flutter/material.dart';
import 'package:fruit_shop/screens/home_screen.dart';
import 'package:fruit_shop/screens/sign_up.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _obsecure = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/signin/Fruits-and-Vegetables.jpg',
              width: size.width,
            ),
            Center(
              child: Column(
                children: [
                  Text("Fruits & Vegtables",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 28,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //The title that appear before the text area
                const Padding(
                  padding: EdgeInsets.only(left: 10, top: 20),
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                //size of the first text (Email)
                SizedBox(height: size.height * 0.04),
                TextFormField(
                  /*validator: (value) {
              if (value == null || value.isEmpty || value.contains('@')) {
                return 'Please enter some text';
              }
              return null;
            },*/
                  //To show the user the input that need to be entered
                  decoration: const InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.green,
                      )),
                ),
                //size of the first text (Password)
                SizedBox(height: size.height * 0.04),
                TextFormField(
                  /*validator: (value) {
              if (value == null || value.isEmpty || value.contains('@')) {
                return 'Please enter some text';
              }
              return null;
            },*/
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
                          _obsecure ? Icons.visibility_off : Icons.visibility,
                          color: Colors.green,
                        )),
                  ),
                  obscureText: _obsecure,

                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //const SignInTextField(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor, // background
                          onPrimary: Colors.white,
                          // foreground
                        ),
                        onPressed: () {
                          /*if (_form.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }*/
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HomeScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'LogIn',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(padding: EdgeInsets.only(bottom: 40.0)),
                          InkWell(
                            onTap: () {},
                            child: const Text("Forget Password?",
                                style: TextStyle(fontSize: 16)),
                          ),
                          const Padding(
                              padding: EdgeInsets.only(left: 20, top: 0)),
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
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
