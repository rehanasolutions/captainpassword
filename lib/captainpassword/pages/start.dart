import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rehana/locator.dart';
import 'package:captainpassword/captainpassword/services/auth.dart';
import 'package:rehana/services/navigation.dart';
import 'package:captainpassword/captainpassword/constants.dart';

class StartPage extends StatelessWidget {
  _gotoHome() async {
    await ServiceManager<NavigationService>().navigateTo(Routes.HOME);
    _startTimer();
  }

  _gotoLoginSignup() async {
    dynamic result = await ServiceManager<NavigationService>()
        .navigateTo(Routes.LOGINSIGNUP);
    if (result != null && result == true) {
      _gotoHome();
    } else {
      _gotoLoginSignup();
    }
  }

  _navigate(Timer timer) async {
    timer.cancel();
    timer = null;
    if (ServiceManager<AuthService>().user != null) {
      _gotoHome();
    } else {
      _gotoLoginSignup();
    }
  }

  _startTimer() {
    Timer timer;
    timer = new Timer(const Duration(milliseconds: 1000), () {
      timer.cancel();
      _navigate(timer);
    });
  }

  @override
  Widget build(BuildContext context) {
    _startTimer();

    return Stack(children: [
      Positioned.fill(
        child: Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
      )
      // Center(
      //   child: CircularProgressIndicator(),
      // )
    ]);
  }
}
