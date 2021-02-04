// import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:captainpassword/captainpassword/widgets/password_entry_list_tile.dart';
import 'package:captainpassword/levendr/models/password.dart';

class PasswordsListWidget extends StatelessWidget {
  final List<Password> list;
  final ValueChanged<dynamic> itemClicked;

  PasswordsListWidget({Key key, this.list, this.itemClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return PasswordEntryListTileWidget(
                document: list[index], itemClicked: itemClicked);
          });
    });
  }
}
