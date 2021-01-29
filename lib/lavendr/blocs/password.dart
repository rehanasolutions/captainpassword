import 'package:rxdart/subjects.dart';
import 'package:captainpassword/lavendr/models/api_result.dart';
import 'package:captainpassword/lavendr/models/get_passwords_response.dart';
import 'package:captainpassword/lavendr/models/password.dart';
import 'package:captainpassword/lavendr/repositories/password.dart';
// import 'package:rxdart/rxdart.dart';

class PasswordBloc {
  final repository = PasswordRepository();

  PublishSubject<List<Password>> _passwordsFetcher;
  Stream<List<Password>> get stream$ => _passwordsFetcher.stream;

  /// Create table
  Future<APIResult> createTable() async {
    APIResult result = await repository.createTable();
    return result;
  }

  /// Get rows
  Future<PasswordsResponse> getRows() async {
    if (_passwordsFetcher == null) {
      _passwordsFetcher = PublishSubject<List<Password>>();
    }

    PasswordsResponse result = await repository.getRows();
    _passwordsFetcher.sink.add(result.data);

    return result;
  }

  /// Insert rows
  Future<APIResult> insertRows(List<Password> passwords) async {
    APIResult result = await repository.insertRows(passwords);
    return result;
  }

  /// Update rows
  Future<APIResult> updateRows(Password password) async {
    APIResult result = await repository.updateRows(password);
    return result;
  }

  /// Get passwords
  Future<PasswordsResponse> getPasswords() async {
    if (_passwordsFetcher == null) {
      _passwordsFetcher = PublishSubject<List<Password>>();
    }

    PasswordsResponse result = await repository.getPasswords();
    _passwordsFetcher.sink.add(result.data);

    return result;
  }

  /// Insert password
  Future<APIResult> insertPassword(Password password) async {
    APIResult result = await repository.insertPassword(password);
    return result;
  }

  /// Update password
  Future<APIResult> updatePassword(Password password) async {
    APIResult result = await repository.updatePassword(password);
    return result;
  }

  clear() {
    if (_passwordsFetcher != null) {
      _passwordsFetcher.sink.add(null);
      dispose();
    }
  }

  dispose() {
    if (_passwordsFetcher != null) {
      _passwordsFetcher.close();
      _passwordsFetcher = null;
    }
  }
}

final PasswordBloc passwordBloc = PasswordBloc();
