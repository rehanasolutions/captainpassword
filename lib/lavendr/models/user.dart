import 'package:captainpassword/lavendr/models/permission.dart';
import 'package:captainpassword/lavendr/models/role.dart';

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
    id = json['id'];
    username = json['username'];
    fullname = json['fullname'];
    email = json['email'];
    password = json['password'];
    role = Role.fromJson(json['role']);
    permissions = List<Permission>.from(
        json['permissions'].map((model) => Permission.fromJson(model)));
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['password'] = this.password;
    data['token'] = this.token;
    return data;
  }
}
