// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:rehana/locator.dart';
import 'package:rehana/services/navigation.dart';
import 'package:captainpassword/captainpassword/constants.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // routes: Routes.routesMap,
      // initialRoute: StartPage.routeName,
      title: Constants.TITLE,
      navigatorKey: ServiceManager<NavigationService>().navigatorKey,
      onGenerateRoute: (settings) => Constants.getRouteSettings(settings),
      // initialRoute: 'start',
      home: Constants.homePage,
      theme: Constants.theme,
      // builder: (context, widget) => Navigator(
      //   onGenerateRoute: (settings) => MaterialPageRoute(
      //     builder: (context) => DialogManager(
      //       child: widget,
      //     ),
      //   ),
      // ),
    );
  }
}
