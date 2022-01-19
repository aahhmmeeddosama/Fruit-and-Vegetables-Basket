import 'package:flutter/material.dart';
import 'package:flutter_application_6/screens/signin_k.dart';
import '../model/http_exception.dart';
//for json
import 'dart:convert';

import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../services/authantication.dart' as s;

//with is mixin
class Auth with ChangeNotifier {
  String? _token; //token is private can't be accessed so we make the get

  DateTime? _expiryDate;
  String? _userId;
  Timer? _signTimer;

  bool get isSign {
    return token != null;
  }

//if the condition is acheived successfully return the token
  String? get token {
    if (_expiryDate != null &&
        //expiry date is after date and time of now
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String? get userId {
    return _userId;
  }

  String APIKEY = "";
  //Auth.Authantication(sign_in(email,password));
  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    //sign up
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=$APIKEY";

    try {
      final response = await http.post(Uri.parse(url),
          //body in form of map
          body: jsonEncode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      //decode the returned info
      final responseData = json.decode(response.body);
      //Httpexception to handle the errors that can happen and give me details about it
      if (responseData['error'] != null) {
        //error is title in response data contains a message
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      _autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      String userData = json.encode({
        'token': _token,
        'userId': _userId,
        //toIso as those are strings but expiry isn't
        'expiryDate': _expiryDate!.toIso8601String(),
      });
      prefs.setString('userData', userData);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signup(String email, String password) async {
    print(5);
    return _authenticate(email, password, "signUp");
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, "signInWithPassword");
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) return false;
    //extract the data and put it in map form
    final Map<String, Object> extractedData = json
        .decode(prefs.getString('userData') as String) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedData['expiryDate'] as String);
    //if it reach to the expiry date
    if (expiryDate.isBefore(DateTime.now())) return false;
    //as i extracted the data in form of shared prefrences
    //now when i take the data i getted in form of shared prefrences
    _token = extractedData['token'] as String;
    _userId = extractedData['userId'] as String;
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    _token == null;
    _userId == null;
    _expiryDate == null;
    //if its continued
    if (_signTimer != null) {
      _signTimer!.cancel();
      _signTimer = null;
    }
    notifyListeners();
    //delete sharedprefrences data
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _autoLogout() {
    if (_signTimer != null) {
      _signTimer!.cancel();
    }
    final expiryTime = _expiryDate!.difference(DateTime.now()).inSeconds;
    //do the logout only when the timer finish
    _signTimer = Timer(Duration(seconds: expiryTime), logout);
  }

  /////////////
  Future<void> _signupauthenticate(
      String email, String phone, String city) async {
    final url =
        "https://fruits-vegetables-basket-19e0d-default-rtdb.firebaseio.com/UserData/$_userId/";
    print("1");
    print(_userId);
    try {
      final response = await http.post(Uri.parse(url),
          body: jsonEncode({
            'email': email,
            'phone': phone,
            'city': city,
            'returnSecureToken': true
          }));
      final responseData = json.decode(response.body);
      //Httpexception to handle the errors that can happen and give me details about it
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      _autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      String userData = json.encode({
        'token': _token,
        'userId': _userId,
        //toIso as those are strings but expiry isn't
        'expiryDate': _expiryDate!.toIso8601String(),
      });
      prefs.setString('userData', userData);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> signUp1(String email, String phone, String city) async {
    print(2);
    return _signupauthenticate(email, phone, city);
  }
}
