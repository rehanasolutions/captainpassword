import 'package:flutter/material.dart';
import 'package:rehana/locator.dart';
import 'package:captainpassword/captainpassword/services/auth.dart';
import 'package:captainpassword/captainpassword/pages/login.dart';
import 'package:captainpassword/captainpassword/pages/signup.dart';
import 'package:captainpassword/captainpassword/constants.dart';

class LoginSignupPage extends StatefulWidget {
  LoginSignupPage({Key key}) : super(key: key);

  @override
  _LoginSignupPageState createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  String _mode = Constants.AUTH_LOGIN;

  // gotoHome() {
  //   new Timer(
  //       Duration(seconds: 1),
  //       () => ServiceManager<NavigationService>()
  //           .navigateTo(Routes.HOME, replace: true));
  // }

  _gotoLogin() {
    setState(() {
      _mode = Constants.AUTH_LOGIN;
    });
  }

  _gotoSignup() {
    setState(() {
      _mode = Constants.AUTH_SIGNUP;
    });
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ServiceManager<AuthService>().user != null) {
        // _gotoHome();
      }
    });
  }

  Widget getView() {
    List<Widget> view = [
      Expanded(
          flex: 2,
          child: Align(
              alignment: Alignment.center,
              child:
                  _mode == Constants.AUTH_LOGIN ? LoginPage() : SignupPage())),
      Expanded(
          flex: 1,
          child: Center(
              child: SizedBox(
                  width: 192,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.indigoAccent)),
                    child: Text(
                        "${_mode == Constants.AUTH_LOGIN ? 'Signup' : 'Login'} instead"),
                    onPressed: () => _mode == Constants.AUTH_LOGIN
                        ? _gotoSignup()
                        : _gotoLogin(),
                  ))))
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: view,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_mode == Constants.AUTH_LOGIN ? 'Login' : 'Sign up'),
        ),
        body: getView());
  }
}
