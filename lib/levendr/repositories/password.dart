import 'package:captainpassword/levendr/api_providers/password.dart';
import 'package:captainpassword/levendr/models/api_result.dart';
import 'package:captainpassword/levendr/models/get_passwords_response.dart';
import 'package:captainpassword/levendr/models/password.dart';

class PasswordRepository {
  final passwordApiProvider = PasswordApiProvider();

  /// Create table
  Future<APIResult> createTable() async {
    return passwordApiProvider.createTable();
  }

  /// Get rows
  Future<PasswordsResponse> getRows() async {
    return passwordApiProvider.getRows();
  }

  /// Insert rows
  Future<APIResult> insertRows(List<Password> passwords) async {
    return passwordApiProvider.insertRows(passwords);
  }

  /// Update rows
  Future<APIResult> updateRows(Password password) async {
    return passwordApiProvider.updateRows(password);
  }

  /// Get passwords
  Future<PasswordsResponse> getPasswords() async {
    return passwordApiProvider.getPasswords();
  }

  /// Insert password
  Future<APIResult> insertPassword(Password password) async {
    return passwordApiProvider.insertPassword(password);
  }

  /// Update password
  Future<APIResult> updatePassword(Password password) async {
    return passwordApiProvider.updatePassword(password);
  }
}
