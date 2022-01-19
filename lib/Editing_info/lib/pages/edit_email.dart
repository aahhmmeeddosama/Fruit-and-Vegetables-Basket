import 'package:flutter/material.dart';
import 'package:profile_editing2/user/user_data.dart';
import 'package:profile_editing2/widgets/appbar_widget.dart';
import 'package:email_validator/email_validator.dart';
// import 'package:firebase_core/firebase_core.dart';

class EditEmailFormPage extends StatefulWidget {
  const EditEmailFormPage({Key? key}) : super(key: key);

  @override
  EditEmailFormPageState createState() {
    return EditEmailFormPageState();
  }
}

class EditEmailFormPageState extends State<EditEmailFormPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  var user = UserData.myUser;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void updateUserValue(String email) {
    user.email = email;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                    width: 320,
                    child: const Text(
                      "What's your email?",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: SizedBox(
                        height: 100,
                        width: 320,
                        child: TextFormField(
                          //validation
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              //fadya
                              return 'Enter your email';
                            } else if (value.contains('@')) {
                              // return 'add email';
                              return null;
                            } //else
                            // return null;
                            return 'it must contain @';
                          },
                          decoration: const InputDecoration(
                              labelText: 'Add Your Email Address Here.. '),
                          controller: emailController,
                        ))),
                Padding(
                    padding: EdgeInsets.only(top: 150),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: 350,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate() &&
                                  EmailValidator.validate(
                                      emailController.text)) {
                                updateUserValue(emailController.text);
                                Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              'Update',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ))
                        ),
                        Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: 350,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {  //b3d mdos update yrg3 ll screen 
                             emailController.clear();
                             Navigator.pop(context);
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ))
                      ), 
              ]),
        ));
  }
}
