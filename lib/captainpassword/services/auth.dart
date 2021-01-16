import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rehana/helpers/console.dart';
import 'package:captainpassword/lavendr/blocs/password.dart';
import 'package:captainpassword/lavendr/blocs/user.dart';
import 'package:rehana/locator.dart';
import 'package:captainpassword/lavendr/models/login_response.dart';
import 'package:captainpassword/lavendr/models/user.dart';

class AuthService {
  BehaviorSubject _user = BehaviorSubject.seeded(null);
  Stream get stream$ => _user.stream;
  User get user => _user.value;

  String get token => user != null && user.token != null ? user.token : null;

  void update(User newValue) {
    _user.add(newValue);
  }

  void updateUser(User user) async {
    update(user);
    await saveAuthToken();
  }

  /// LogIn using email and password
  Future<LoginResponse> logIn(login, password) async {
    LoginResponse response = await userBloc.logIn(login, password);
    if (response.success) {
      updateUser(response.data);
    }
    return response;
  }

  /// LogIn using auth token
  Future<LoginResponse> logInUsingAuthToken(String token) async {
    LoginResponse response = await userBloc.logInUsingAuthToken(token);
    if (response.success) {
      updateUser(response.data);
    }
    return response;
  }

  /// SignUp using email and password
  Future<LoginResponse> signUp(User user) async {
    LoginResponse response = await userBloc.signUp(user);
    if (response.success) {
      updateUser(response.data);
    }
    return response;
  }

  /*
  
  /// Send confirmation email
  Future<String> sendEmail(email, password) async {
    return _provider.sendEmail(email, password);
  }

  */

  /// LogOut
  Future<bool> logOut() async {
    ServiceManager<AuthService>().update(null);
    passwordBloc.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    return true;
  }

  Future<bool> saveAuthToken() async {
    try {
      if (ServiceManager<AuthService>().token.isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', ServiceManager<AuthService>().token);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      console(ConsoleLevel.Error, e.toString());
      return false;
    }
  }

  Future<String> loadAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
