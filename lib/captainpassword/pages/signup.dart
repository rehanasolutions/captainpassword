import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rehana/dialogs/loading.dart';
import 'package:rehana/locator.dart';
import 'package:rehana/services/navigation.dart';
import 'package:rehana/services/dialog.dart';
import 'package:rehana/dialogs/info.dart';
import 'package:captainpassword/captainpassword/services/auth.dart';
import 'package:captainpassword/levendr/models/login_response.dart';
import 'package:captainpassword/levendr/models/user.dart';
import 'package:captainpassword/captainpassword/constants.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _email = "akhtar.syedzeeshan@gmail.com", _password = "2Speakers";

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  _gotoHome() {
    new Timer(Duration(seconds: 1),
        () => ServiceManager<NavigationService>().navigateTo(Routes.HOME));
  }

  _signup() async {
    var formState = _formKey.currentState;

    if (formState.validate()) {
      formState.save();
      String _loadingDialogCompleterId = ServiceManager<DialogService>()
          .showDialog(context, new LoadingDialog(),
              data: {'text': 'Signing up...'});

      LoginResponse result = await ServiceManager<AuthService>()
          .signUp(new User(username: _email, password: _password));

      ServiceManager<DialogService>().completeDialog(
          context: context,
          completerId: _loadingDialogCompleterId,
          result: null);

      _handleSignupResult(result);
    } else {
      ServiceManager<DialogService>().showDialog(context, new InfoDialog(),
          data: {'title': 'Error', 'text': 'Please fill all fields.'});
    }
  }

  void _handleSignupResult(LoginResponse result) {
    if (result.success) {
      _saveSession(result);
      ServiceManager<NavigationService>().goBack(result: true);
      // _gotoHome();
    } else {
      ServiceManager<DialogService>().showDialog(context, new InfoDialog(),
          data: {'title': 'Error', 'text': result.message});
    }
  }

  void _saveSession(LoginResponse result) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', _email);
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ServiceManager<AuthService>().user != null) {
        _gotoHome();
        // locator<NavigationService>().navigateTo(ROUTES.HOME);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                  validator: (input) {
                    if (input.isEmpty) {
                      return "Please type an email!";
                    }
                    return null;
                  },
                  onSaved: (input) => _email = input,
                  decoration: InputDecoration(
                    labelText: "Email",
                  )),
              TextFormField(
                  validator: (input) {
                    if (input.length < 6) {
                      return "Password Needs to be at least 6 characters!";
                    }
                    return null;
                  },
                  onSaved: (input) => _password = input,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                  )),
              SizedBox(
                  width: 192,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.indigoAccent)),
                    child: Text("Signup"),
                    onPressed: () => _signup(),
                  )),
            ],
          ),
        ));
  }
}
