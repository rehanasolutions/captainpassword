import 'package:flutter/material.dart';
import 'package:rehana/dialogs/base.dart';
import 'package:captainpassword/captainpassword/widgets/store_key.dart';

class StoreKeyDialog extends BaseDialog {
  @override
  void show(BuildContext context, String completerId, {dynamic data}) {
    showDialog(
        context: context,
        builder: (context) => StoreKeyWidget(completerId: completerId));
  }
}
