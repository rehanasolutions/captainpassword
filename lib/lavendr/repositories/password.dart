import 'package:captainpassword/lavendr/api_providers/password.dart';
import 'package:captainpassword/lavendr/models/api_result.dart';
import 'package:captainpassword/lavendr/models/get_passwords_response.dart';
import 'package:captainpassword/lavendr/models/password.dart';

class PasswordRepository {
  final passwordApiProvider = PasswordApiProvider();

  /// Create table
  Future<APIResult> createTable() async {
    return passwordApiProvider.createTable();
  }

  /// Insert rows
  Future<APIResult> insertRows(List<Password> passwords) async {
    return passwordApiProvider.insertRows(passwords);
  }

  /// Get rows
  Future<PasswordsResponse> getRows() async {
    return passwordApiProvider.getRows();
  }

  /// Update rows
  Future<APIResult> updateRows(Password password) async {
    return passwordApiProvider.updateRows(password);
  }
}
