import 'package:captainpassword/lavendr/models/user.dart';

class LoginResponse {
  bool success;
  String message;
  User data;

  LoginResponse({this.success, this.message, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = User.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['data'] = this.data.toJson();
    return data;
  }
}
