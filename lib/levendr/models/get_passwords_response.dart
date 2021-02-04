import 'package:captainpassword/levendr/models/password.dart';

class PasswordsResponse {
  bool success;
  String message;
  List<Password> data;

  PasswordsResponse({this.success, this.message, this.data});

  PasswordsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    List temp = List.from((json['data']).map((e) => Password.fromJson(e)));
    data = List.from(temp);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['data'] = List.from(this.data.map((e) => e.toJson()));
    return data;
  }
}
