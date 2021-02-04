import 'package:rxdart/subjects.dart';
import 'package:captainpassword/levendr/models/login_response.dart';
import 'package:captainpassword/levendr/models/user.dart';
import 'package:captainpassword/levendr/repositories/user.dart';
// import 'package:rxdart/rxdart.dart';

class UserBloc {
  final repository = UserRepository();

  PublishSubject<User> _userFetcher;
  Stream<User> get stream$ => _userFetcher.stream;

  /// LogIn using email and password
  Future<LoginResponse> logIn(login, password) async {
    if (_userFetcher == null) {
      _userFetcher = PublishSubject<User>();
    }

    LoginResponse result = await repository.logIn(login, password);
    _userFetcher.sink.add(result.data);
    return result;
  }

  /// LogIn using auth token
  Future<LoginResponse> logInUsingAuthToken(String token) async {
    if (_userFetcher == null) {
      _userFetcher = PublishSubject<User>();
    }

    LoginResponse result = await repository.logInUsingAuthToken(token);
    _userFetcher.sink.add(result.data);
    return result;
  }

  /// SignUp using email and password
  Future<LoginResponse> signUp(User user) async {
    if (_userFetcher == null) {
      _userFetcher = PublishSubject<User>();
    }

    LoginResponse result = await repository.signUp(user);
    _userFetcher.sink.add(result.data);
    return result;
  }

  dispose() {
    if (_userFetcher != null) {
      _userFetcher.close();
    }
  }

  /*
  
  /// Send confirmation email
  Future<String> sendEmail(email, password) async {
    return _provider.sendEmail(email, password);
  }

  */
}

final UserBloc userBloc = new UserBloc();
