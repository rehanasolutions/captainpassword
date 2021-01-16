import 'package:flutter/material.dart';
import 'package:rehana/dialogs/base.dart';
import 'package:captainpassword/captainpassword/widgets/add_edit_site.dart';

class AddEditSiteDialog extends BaseDialog {
  @override
  void show(BuildContext context, String completerId, {dynamic data}) {
    showDialog(
        context: context,
        builder: (context) =>
            AddEditSiteWidget(completerId: completerId, document: data));
  }
}
