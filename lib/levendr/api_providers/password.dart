import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:captainpassword/environment.dart';
import 'package:rehana/locator.dart';
import 'package:captainpassword/captainpassword/services/auth.dart';
import 'package:captainpassword/levendr/enums/column_condition.dart';
import 'package:captainpassword/levendr/models/api_result.dart';
import 'package:captainpassword/levendr/models/password_update_request.dart';
import 'package:captainpassword/levendr/models/get_passwords_response.dart';
import 'package:captainpassword/levendr/models/password.dart';
import 'package:captainpassword/levendr/models/query_search_item.dart';
import 'package:captainpassword/levendr/tables/password.dart';

class PasswordApiProvider {
  /// Decode Login Response
  APIResult decodeResponse(dynamic responseBody) {
    dynamic responseJson = json.decode(responseBody);
    APIResult response = new APIResult.fromJson(responseJson);
    return response;
  }

  PasswordsResponse decodePasswordsResponse(dynamic responseBody) {
    dynamic responseJson = json.decode(responseBody);
    PasswordsResponse response = new PasswordsResponse.fromJson(responseJson);
    return response;
  }

  /// Create table
  Future<APIResult> createTable() async {
    // Using Uri.http caused the ? symbol to be converted too which is invalid
    // final url = new Uri.http(
    //     "${Environment.APIUrl}", "/API/Table/CreateTable?table=Passwords");
    final url =
        "http://${Environment.APIUrl}/API/Table/CreateTable?table=Passwords";

    final headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${ServiceManager<AuthService>().token}'
    };

    dynamic columnsJson = PasswordTable.columns.map((e) => e.toJson()).toList();
    final body = json.encoder.convert(columnsJson);

    http.Response response;
    String error;

    try {
      response = await http.post(url, headers: headers, body: body);
    } catch (e) {
      error = e.toString();
    }

    if (error != null) {
      return new APIResult(success: false, message: error);
    } else {
      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the Password response
        APIResult result = decodeResponse(response.body);
        return result;
      } else {
        // If that call was not successful, throw an error.
        return new APIResult(success: false, message: response.reasonPhrase);
      }
    }
  }

  /// Get rows
  Future<PasswordsResponse> getRows() async {
    // final url = new Uri.http(
    //     "${Environment.APIUrl}", "/API/Table/CreateTable?table=Passwords");
    final url =
        "http://${Environment.APIUrl}/API/Table/GetRows?table=Passwords";

    final headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${ServiceManager<AuthService>().token}'
    };

    http.Response response;
    String error;

    try {
      response = await http.post(url, headers: headers);
    } catch (e) {
      error = e.toString();
    }

    if (error != null) {
      return new PasswordsResponse(success: false, message: error);
    } else {
      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the Password response
        PasswordsResponse result = decodePasswordsResponse(response.body);
        return result;
      } else {
        // If that call was not successful, throw an error.
        return new PasswordsResponse(
            success: false, message: response.reasonPhrase);
      }
    }
  }

  /// Insert rows
  Future<APIResult> insertRows(List<Password> passwords) async {
    // final url = new Uri.http(
    //     "${Environment.APIUrl}", "/API/Table/CreateTable?table=Passwords");
    final url =
        "http://${Environment.APIUrl}/API/Table/InsertRows?table=Passwords";

    final headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${ServiceManager<AuthService>().token}'
    };

    final body = json.encoder.convert(passwords);

    http.Response response;
    String error;

    try {
      response = await http.post(url, headers: headers, body: body);
    } catch (e) {
      error = e.toString();
    }

    if (error != null) {
      return new APIResult(success: false, message: error);
    } else {
      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the Password response
        APIResult result = decodeResponse(response.body);
        return result;
      } else {
        // If that call was not successful, throw an error.
        return new APIResult(success: false, message: response.reasonPhrase);
      }
    }
  }

  /// Update rows
  Future<APIResult> updateRows(Password password) async {
    // final url = new Uri.http(
    //     "${Environment.APIUrl}", "/API/Table/CreateTable?table=Passwords");
    final url =
        "http://${Environment.APIUrl}/API/Table/UpdateRows?table=Passwords";

    final headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${ServiceManager<AuthService>().token}'
    };

    PasswordUpdateRequest request = new PasswordUpdateRequest();
    request.data = password;
    request.parameters = List.from([
      new QuerySearchItem(
          name: "Id",
          value: password.id,
          caseSensitive: false,
          condition: ColumnCondition.Equal)
    ]);

    final body = json.encoder.convert(request.toJson());

    http.Response response;
    String error;

    try {
      response = await http.post(url, headers: headers, body: body);
    } catch (e) {
      error = e.toString();
    }

    if (error != null) {
      return new APIResult(success: false, message: error);
    } else {
      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the Password response
        APIResult result = decodeResponse(response.body);
        return result;
      } else {
        // If that call was not successful, throw an error.
        return new APIResult(success: false, message: response.reasonPhrase);
      }
    }
  }

  /// Get passwords
  Future<PasswordsResponse> getPasswords() async {
    // final url = new Uri.http(
    //     "${Environment.APIUrl}", "/API/Table/CreateTable?table=Passwords");
    final url = "http://${Environment.APIUrl}/API/Passwords";

    final headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${ServiceManager<AuthService>().token}'
    };

    http.Response response;
    String error;

    try {
      response = await http.get(url, headers: headers);
    } catch (e) {
      error = e.toString();
    }

    if (error != null) {
      return new PasswordsResponse(success: false, message: error);
    } else {
      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the Password response
        PasswordsResponse result = decodePasswordsResponse(response.body);
        return result;
      } else {
        // If that call was not successful, throw an error.
        return new PasswordsResponse(
            success: false, message: response.reasonPhrase);
      }
    }
  }

  /// Insert password
  Future<APIResult> insertPassword(Password password) async {
    // final url = new Uri.http(
    //     "${Environment.APIUrl}", "/API/Table/CreateTable?table=Passwords");
    final url = "http://${Environment.APIUrl}/API/Passwords";

    final headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${ServiceManager<AuthService>().token}'
    };

    final body = json.encoder.convert(password);

    http.Response response;
    String error;

    try {
      response = await http.post(url, headers: headers, body: body);
    } catch (e) {
      error = e.toString();
    }

    if (error != null) {
      return new APIResult(success: false, message: error);
    } else {
      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the Password response
        APIResult result = decodeResponse(response.body);
        return result;
      } else {
        // If that call was not successful, throw an error.
        return new APIResult(success: false, message: response.reasonPhrase);
      }
    }
  }

  /// Update password
  Future<APIResult> updatePassword(Password password) async {
    // final url = new Uri.http(
    //     "${Environment.APIUrl}", "/API/Table/CreateTable?table=Passwords");
    final url = "http://${Environment.APIUrl}/API/Passwords/${password.id}";

    final headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${ServiceManager<AuthService>().token}'
    };

    final body = json.encoder.convert(password);

    http.Response response;
    String error;

    try {
      response = await http.put(url, headers: headers, body: body);
    } catch (e) {
      error = e.toString();
    }

    if (error != null) {
      return new APIResult(success: false, message: error);
    } else {
      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the Password response
        APIResult result = decodeResponse(response.body);
        return result;
      } else {
        // If that call was not successful, throw an error.
        return new APIResult(success: false, message: response.reasonPhrase);
      }
    }
  }
}
