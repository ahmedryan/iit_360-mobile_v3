import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iit_360/services/service_constants.dart' as Constants;
import 'package:iit_360/services/service_google_signin_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CrModel {
  String crEmail;
  String crSemester;

  CrModel({required this.crEmail, required this.crSemester});
}

class AuthProvider with ChangeNotifier {
  String? displayName;
  String? email;
  String? photoUrl;
  bool authStatus = false;
  bool crStatus = false;
  String? crSemester;
  String? token;

  bool get getAuthStatus {
    return authStatus;
  }

  bool get getCrStatus {
    return crStatus;
  }

  String? get getDisplayName {
    return displayName;
  }

  String? get getEmail {
    return email;
  }

  String? get getToken {
    return token;
  }

  String? get getPhotoUrl {
    return photoUrl;
  }

  Future onLogin() async {
    final user = await GoogleSignInApi.signIn();

    if (user != null) {
      var userAuthentication = await user.authentication;
      print('..........id token: ${userAuthentication.idToken}..........');
      print(
          '..........access token: ${userAuthentication.accessToken}..........');

      bool isIitian = await checkIitian(user.email);
      if (!isIitian) {
        onLogout();
        return false;
      }

      displayName = user.displayName;
      email = user.email;
      photoUrl = user.photoUrl;
      authStatus = true;
      token = userAuthentication.accessToken;

      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setString('usermail', user.email);
      print('usermail stored in prefs..........');

      fetchAndSetCrStatus(email.toString());
    } else {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.remove('usermail');
      displayName = email = photoUrl = null;
      authStatus = false;
    }

    print('login');
    notifyListeners();
  }

  Future<bool> onAutoLogin() async {
    final user = await GoogleSignInApi.checkSignIn();

    print(user);

    if (user != null) {
      var userAuthentication = await user.authentication;
      print('..........id token: ${userAuthentication.idToken}..........');
      print(
          '..........access token: ${userAuthentication.accessToken}..........');

      bool isIitian = await checkIitian(user.email);
      if (!isIitian) {
        onLogout();
        return false;
      }

      displayName = user.displayName;
      email = user.email;
      photoUrl = user.photoUrl;
      authStatus = true;
      token = userAuthentication.accessToken;

      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setString('usermail', user.email);
      print('usermail stored in prefs..........');

      fetchAndSetCrStatus(email.toString());
    } else {
      displayName = email = photoUrl = null;
      authStatus = false;
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.remove('usermail');
      print('usermail removed from prefs..........');
      return false;
    }

    print('checkSignIn');
    notifyListeners();
    return true;
  }

  Future onLogout() async {
    displayName = email = photoUrl = crSemester = null;
    authStatus = crStatus = false;
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.remove('usermail');
    print('usermail removed from prefs..........');
    await GoogleSignInApi.signOut();
    notifyListeners();
  }

  Future checkIitian(String email) {
    final url = Uri.parse('${Constants.host}/api/iitians/getiitian/$email');

    return http.get(url).then(
      (response) async {
        if (response.statusCode == 200) {
          return true;
        } else {
          return false;
        }
      },
    ).catchError((err) {
      print(err);
    });
  }

  Future<void> fetchAndSetCrStatus(String email) {
    final url = Uri.parse('${Constants.host}/api/crs/getcr/$email');

    return http.get(url).then(
      (response) async {
        final crData = json.decode(response.body);

        if (crData['status'] == 404) {
          return;
        }

        final loadedCr = CrModel(
          crEmail: crData['crMailId'],
          crSemester: crData['semester'],
        );

        crStatus = true;
        crSemester = loadedCr.crSemester;

        print(crSemester);

        notifyListeners();
      },
    ).catchError((err) {
      print(err);
    });
  }
}
