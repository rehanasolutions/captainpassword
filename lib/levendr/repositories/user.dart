import 'package:captainpassword/levendr/api_providers/user.dart';
import 'package:captainpassword/levendr/models/login_response.dart';
import 'package:captainpassword/levendr/models/user.dart';

class UserRepository {
  final userApiProvider = UserApiProvider();

  /// LogIn using username and password
  Future<LoginResponse> logIn(username, password) async {
    return userApiProvider.logIn(username, password);
  }

  /// LogIn using auth token
  Future<LoginResponse> logInUsingAuthToken(String token) async {
    return userApiProvider.logInUsingAuthToken(token);
  }

  /// SignUp using username and password
  Future<LoginResponse> signUp(User user) async {
    return userApiProvider.signUp(user);
  }

  /*
  /// Send confirmation email
  Future<String> sendEmail(email, password) async {
    return null;
  }
  */
}
