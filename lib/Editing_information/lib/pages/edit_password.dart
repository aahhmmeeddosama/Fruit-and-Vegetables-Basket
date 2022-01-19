import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'package:profile_editing2/user/user_data.dart';
import 'package:profile_editing2/widgets/appbar_widget.dart';

class EditPasswordFormPage extends StatefulWidget {
  const EditPasswordFormPage({Key? key}) : super(key: key);

  @override
  EditPasswordFormPageState createState() {
    return EditPasswordFormPageState();
  }
}

class EditPasswordFormPageState extends State<EditPasswordFormPage> {
  final _formKey = GlobalKey<FormState>();
  final PasswordController = TextEditingController();
  var user = UserData.myUser;

  @override
  void dispose() {
    PasswordController.dispose();
    super.dispose();
  }

  void updateUserValue(String password) {
    user.password = password;
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
                  width: 330,
                  child: const Text(
                    "Add New Password",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 40, 16, 0),
                      child: SizedBox(
                          height: 200,
                          width: 250,
                          child: TextFormField(
                            // first name
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter new password';
                              } 
                              else if(value.length < 8){
                                return 'Enter strong password at least 8 characters';
                              }
                              return null;
                            },
                            decoration:
                                InputDecoration(labelText: 'new password'),
                            controller: PasswordController,
                          ))),
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: 330,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {  //b3d mdos update yrg3 ll screen 
                            if (_formKey.currentState!.validate()) {
                                updateUserValue(PasswordController.text);
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
                        width: 330,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {  //b3d mdos update yrg3 ll screen 
                             PasswordController.clear();
                             Navigator.pop(context);
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ))
                      ), 
            ],
          ),
        ));
  }
}
