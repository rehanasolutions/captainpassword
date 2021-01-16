import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:captainpassword/environment.dart';
import 'package:captainpassword/lavendr/models/login_response.dart';
import 'package:captainpassword/lavendr/models/user.dart';

class UserApiProvider {
  /// Decode Login Response
  LoginResponse decodeLoginResponse(dynamic responseBody) {
    dynamic responseJson = json.decode(responseBody);
    LoginResponse response = new LoginResponse.fromJson(responseJson);
    return response;
  }

  /// LogIn using email and password
  Future<LoginResponse> logIn(username, password) async {
    final url = new Uri.http("${Environment.APIUrl}", "/API/User/Login");
    final headers = {'Content-type': 'application/json'};
    final body =
        json.encoder.convert({"username": username, "password": password});

    http.Response response;
    String error;

    try {
      response = await http.post(url, headers: headers, body: body);
    } catch (e) {
      error = e.toString();
    }

    if (error != null) {
      return new LoginResponse(success: false, message: error);
    } else {
      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the User response
        LoginResponse result = decodeLoginResponse(response.body);
        return result;
      } else {
        // If that call was not successful, throw an error.
        return new LoginResponse(
            success: false, message: response.reasonPhrase);
      }
    }
  }

  /// LogIn using auth token
  Future<LoginResponse> logInUsingAuthToken(String token) async {
    final url = new Uri.http("${Environment.APIUrl}", "/API/User/AuthLogin");
    final headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    http.Response response;
    String error;

    try {
      response = await http.post(url, headers: headers);
    } catch (e) {
      error = e.toString();
    }

    if (error != null) {
      return new LoginResponse(success: false, message: error);
    } else {
      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the User response
        LoginResponse result = decodeLoginResponse(response.body);
        return result;
      } else {
        // If that call was not successful, throw an error.
        return new LoginResponse(
            success: false, message: response.reasonPhrase);
      }
    }
  }

  /// LogIn using email and password
  Future<LoginResponse> signUp(User user) async {
    final url = new Uri.http("${Environment.APIUrl}", "/API/User/Signup");

    if (user.username == null) {
      user.username = user.email;
    }

    final headers = {'Content-type': 'application/json'};
    final body = json.encoder
        .convert({"username": user.username, "password": user.password});

    http.Response response;
    String error;

    try {
      response = await http.post(url, headers: headers, body: body);
    } catch (e) {
      error = e.toString();
    }

    if (error != null) {
      return new LoginResponse(success: false, message: error);
    } else {
      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the User response
        LoginResponse result = decodeLoginResponse(response.body);
        return result;
      } else {
        // If that call was not successful, throw an error.
        return new LoginResponse(
            success: false, message: response.reasonPhrase);
      }
    }
  }

  /*
  /// Send confirmation email
  @override
  Future<String> sendEmail(email, password) async {
    return null;
  }
  */

}
