import 'package:flutter/material.dart';
import 'package:profile_editing2/user/user_data.dart';
import 'package:profile_editing2/widgets/appbar_widget.dart';

class EditDescriptionFormPage extends StatefulWidget {
  @override
  _EditDescriptionFormPageState createState() =>
      _EditDescriptionFormPageState();
}

class _EditDescriptionFormPageState extends State<EditDescriptionFormPage> {
  final _formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  var user = UserData.myUser;

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  void updateUserValue(String description) {
    user.aboutMeDescription = description;
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
                    width: 350,
                    child: const Text(
                      "Add description: ",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )),
                Padding(
                    padding: EdgeInsets.all(20),
                    child: SizedBox(
                        height: 250,
                        width: 350,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length > 200) {
                              return 'Please describe yourself but keep it under 200 characters.';
                            }
                            return null;
                          },
                          controller: descriptionController,
                          textAlignVertical: TextAlignVertical.top,
                          decoration: const InputDecoration(
                              alignLabelWithHint: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(10, 15, 10, 100),
                              hintMaxLines: 3,
                              hintText: 'Write a little bit about yourself.'),
                        ))),
                Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: 350,
                          height:50,
                          child: ElevatedButton(
                            onPressed: () {
                              //b3d mktb new description w ados update yrg3 ll page
                              if (_formKey.currentState!.validate()) {
                                updateUserValue(descriptionController.text);
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
                             descriptionController.clear();
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
