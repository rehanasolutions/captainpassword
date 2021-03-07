import 'package:captainpassword/levendr/models/password.dart';

class PasswordsResponse {
  bool success;
  String message;
  List<Password> data;

  PasswordsResponse({this.success, this.message, this.data});

  PasswordsResponse.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    message = json['Message'];
    List temp = List.from((json['Data']).map((e) => Password.fromJson(e)));
    data = List.from(temp);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Success'] = this.success;
    data['Message'] = this.message;
    data['Data'] = List.from(this.data.map((e) => e.toJson()));
    return data;
  }
}
