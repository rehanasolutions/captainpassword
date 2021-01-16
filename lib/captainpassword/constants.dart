// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:captainpassword/theme.dart';
import 'package:flutter/material.dart';
import 'package:rehana/models/label_value.dart';
import 'package:captainpassword/captainpassword/pages/login.dart';
import 'package:captainpassword/captainpassword/pages/loginsignup.dart';
import 'package:captainpassword/captainpassword/pages/signup.dart';
import 'package:captainpassword/captainpassword/pages/home.dart';
import 'package:captainpassword/captainpassword/pages/start.dart';

class Routes {
  static const String START = "start";
  static const String LOGIN = "login";
  static const String SIGNUP = "signup";
  static const String LOGINSIGNUP = "loginsignup";
  static const String HOME = "home";
  static const String BRANCH_DETAIL = "branch_detail";
}

class Constants {
  static const String TITLE = "CaptainPassword";
  static const String ABOUT_TEXT =
      "Copyright © 2021 Rehana\nCreated by Syed Zeeshan Akhtar";

  static const String AUTH_LOGIN = "Login";
  static const String AUTH_LOGOUT = "Logout";
  static const String AUTH_SIGNUP = "Signup";

  static const String KEY_STORE = "Store key";
  static const String KEY_REMOVE = "Remove key";

  static List<LabelValuePair> folders = [
    LabelValuePair(label: 'Arts', value: 'Arts'),
    LabelValuePair(label: 'Business', value: 'Business'),
    LabelValuePair(label: 'Development', value: 'Development'),
    LabelValuePair(label: 'Education', value: 'Education'),
    LabelValuePair(label: 'Email', value: 'Email'),
    LabelValuePair(label: 'Entertainment', value: 'Entertainment'),
    LabelValuePair(label: 'Finance', value: 'Finance'),
    LabelValuePair(label: 'Games', value: 'Games'),
    LabelValuePair(label: 'Hosting', value: 'Hosting'),
    LabelValuePair(label: 'Housing', value: 'Housing'),
    LabelValuePair(label: 'Internet', value: 'Internet'),
    LabelValuePair(label: 'Mobile', value: 'Mobile'),
    LabelValuePair(label: 'News/Reference', value: 'News/Reference'),
    LabelValuePair(label: 'Productivity Tools', value: 'Productivity Tools'),
    LabelValuePair(label: 'Shopping', value: 'Shopping'),
    LabelValuePair(label: 'Social', value: 'Social'),
    LabelValuePair(label: 'Travel', value: 'Travel'),
    LabelValuePair(label: 'Other', value: 'Other')
  ];

  static List<LabelValuePair> keyDurations = [
    LabelValuePair(label: '1 minute', value: '60'),
    LabelValuePair(label: '5 minutes', value: '300'),
    LabelValuePair(label: '30 minutes', value: '1800'),
    LabelValuePair(label: '1 hour', value: '3600'),
    LabelValuePair(label: '5 hours', value: '18000'),
    LabelValuePair(label: '1 day', value: '86400')
  ];

  // static const Map<String, Map<String, String>> routes = {
  //   'start': {'routeName': 'start', 'key': 'KEY_START'},
  //   'home': {'routeName': 'home', 'key': 'KEY_HOME'}
  // };

  static getRouteSettings(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.HOME:
        return MaterialPageRoute(builder: (context) => HomePage());
      case Routes.LOGIN:
        return MaterialPageRoute(
            builder: (context) => LoginPage(), fullscreenDialog: true);
      case Routes.SIGNUP:
        return MaterialPageRoute(
            builder: (context) => SignupPage(), fullscreenDialog: true);
      case Routes.LOGINSIGNUP:
        return MaterialPageRoute(
            builder: (context) => LoginSignupPage(), fullscreenDialog: true);
      case Routes.START:
      default:
        return MaterialPageRoute(builder: (context) => StartPage());
    }
  }

  static get homePage => StartPage();
  static get theme => LevendrTheme.lightTheme;
}
