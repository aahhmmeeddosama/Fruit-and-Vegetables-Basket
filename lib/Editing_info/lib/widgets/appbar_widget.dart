import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    iconTheme: IconThemeData(
        color: Colors
            .green[500]), 
    leading: BackButton(),
    backgroundColor: Colors.transparent,
    elevation: 0, //shadow eswed kda mdy2 el screen
  );
}
