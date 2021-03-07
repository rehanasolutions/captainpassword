import 'package:captainpassword/levendr/models/permission.dart';
import 'package:captainpassword/levendr/models/role.dart';

class User {
  int id;
  String username;
  String fullname;
  String email;
  String password;
  Role role;
  List<Permission> permissions;
  String token;

  User(
      {this.id,
      this.username,
      this.fullname,
      this.email,
      this.password,
      this.role,
      this.permissions,
      this.token});

  User.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    username = json['Username'];
    fullname = json['Fullname'];
    email = json['Email'];
    password = json['Password'];
    role = Role.fromJson(json['Role']);
    permissions = List<Permission>.from(
        json['Permissions'].map((model) => Permission.fromJson(model)));
    token = json['Token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Username'] = this.username;
    data['Fullname'] = this.fullname;
    data['Email'] = this.email;
    data['Password'] = this.password;
    data['Token'] = this.token;
    return data;
  }
}
