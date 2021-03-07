import 'package:captainpassword/levendr/models/user.dart';

class LoginResponse {
  bool success;
  String message;
  User data;

  LoginResponse({this.success, this.message, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    message = json['Message'];
    data = User.fromJson(json['Data']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Success'] = this.success;
    data['Message'] = this.message;
    data['Data'] = this.data.toJson();
    return data;
  }
}
