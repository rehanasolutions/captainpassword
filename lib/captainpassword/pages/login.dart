import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rehana/dialogs/loading.dart';
import 'package:rehana/helpers/console.dart';
import 'package:rehana/helpers/toast.dart';
import 'package:rehana/locator.dart';
import 'package:rehana/services/navigation.dart';
import 'package:rehana/services/dialog.dart';
import 'package:rehana/dialogs/info.dart';
import 'package:captainpassword/captainpassword/services/auth.dart';
import 'package:captainpassword/lavendr/models/login_response.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = "", _password = "";
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  // _gotoHome() {
  //   new Timer(Duration(seconds: 1), () {
  //     ServiceManager<NavigationService>()
  //         .navigateTo(Routes.HOME, replace: false);
  //   });
  // }

  // _sendEmail() async {
  //   String result =
  //       await ServiceManager<AuthService>().sendEmail(_email, _password);
  //   if (result != null) {
  //     ServiceManager<DialogService>().showDialog(context, new InfoDialog(),
  //         data: {'title': 'Error', 'text': result});
  //   } else {
  //     ServiceManager<DialogService>().showDialog(context, new InfoDialog(),
  //         data: {'title': 'Success', 'text': "Verification email sent."});
  //   }
  // }

  _login() async {
    var formState = _formKey.currentState;

    if (formState.validate()) {
      formState.save();
      String _loadingDialogCompleterId = ServiceManager<DialogService>()
          .showDialog(context, new LoadingDialog(),
              data: {'text': 'Logging in...'});

      LoginResponse result =
          await ServiceManager<AuthService>().logIn(_email, _password);

      ServiceManager<DialogService>().completeDialog(
          context: context,
          completerId: _loadingDialogCompleterId,
          result: null);

      _handleLoginResult(result);
    } else {
      ServiceManager<DialogService>().showDialog(context, new InfoDialog(),
          data: {'title': 'Error', 'text': 'Please fill all fields.'});
    }
  }

  void _handleLoginResult(LoginResponse result) {
    if (result.success) {
      _saveSession(result);
      ServiceManager<NavigationService>().goBack(result: true);
      // _gotoHome();
    } else {
      // if (result.toLowerCase().contains("verified")) {
      //   ServiceManager<DialogService>()
      //       .showDialog(context, new ActionsDialog(), data: {
      //     'title': 'Error',
      //     'text': "You have not verified your account.",
      //     'actions': [
      //       {'text': 'Send email again', 'onPressed': _sendEmail},
      //       {'text': "Cancel"}
      //     ]
      //   });
      // } else
      ServiceManager<DialogService>().showDialog(context, new InfoDialog(),
          data: {'title': 'Error', 'text': result.message});
    }
  }

  _loginUsingAuthToken(token) async {
    String _loadingDialogCompleterId = ServiceManager<DialogService>()
        .showDialog(context, new LoadingDialog(), data: {'text': 'Loading...'});

    LoginResponse result =
        await ServiceManager<AuthService>().logInUsingAuthToken(token);

    ServiceManager<DialogService>().completeDialog(
        context: context, completerId: _loadingDialogCompleterId, result: null);

    // PasswordBloc bloc = new PasswordBloc();
    // bloc.createTable();
    // List<Password> passwords = List.from([
    //   new Password(
    //       name: "Google mail",
    //       url: "gmail.com",
    //       login: "test@gmail.com",
    //       password: "password123",
    //       folder: "Mail",
    //       encrypted: false,
    //       notes: "")
    // ]);
    // bloc.insertRows(passwords);

    // PasswordsResponse rows = await bloc.getRows();
    // rows.data[0].name = rows.data[0].name + " shughal!";
    // bloc.updateRows(rows.data[0]);

    _handleAuthLoginResult(result);
  }

  void _handleAuthLoginResult(LoginResponse result) async {
    if (result.success) {
      _saveSession(result);
      ServiceManager<NavigationService>().goBack(result: true);
      // _gotoHome();
    } else {
      ServiceManager<AuthService>().logOut();
      // showToast(context, "Session expired!");

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String email = prefs.getString('email');
      if (email?.isNotEmpty ?? false) {
        _emailController.text = email;
      }
    }
  }

  // _googleLogIn() async {
  //   String _loadingDialogCompleterId = ServiceManager<DialogService>()
  //       .showDialog(context, new LoadingDialog(), data: {'text': 'Loading...'});

  //   String result = await ServiceManager<AuthService>().googleLogIn();

  //   ServiceManager<DialogService>().completeDialog(
  //       context: context, completerId: _loadingDialogCompleterId, result: null);

  //   _handleLoginResult(result);
  // }

  void _loadSession() async {
    String token = await ServiceManager<AuthService>().loadAuthToken();
    console(ConsoleLevel.Info, 'Token: $token');
    if ((token?.isNotEmpty ?? false)) {
      _loginUsingAuthToken(token);
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String email = prefs.getString('email');
      if (email?.isNotEmpty ?? false) {
        _emailController.text = email;
      }
    }
  }

  void _saveSession(LoginResponse result) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', _email);
  }

  void initState() {
    super.initState();

    _loadSession();
    // _emailController.text = _email;
    // _passwordController.text = _password;
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
                  controller: _emailController,
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
                  controller: _passwordController,
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
                    child: Text("Login"),
                    onPressed: () => _login(),
                  )),
              SizedBox(
                  width: 192,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.indigoAccent)),
                    child: Text("Google Login"),
                    onPressed: () => showToast(context, "Not implemented yet!"),
                  )),
            ],
          ),
        ));
  }
}
