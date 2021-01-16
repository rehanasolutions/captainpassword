import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:rehana/widgets/drop_down_menu.dart';
import 'package:captainpassword/captainpassword/constants.dart';

class FolderDropDownMenuWidget extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String value;
  FolderDropDownMenuWidget({Key key, this.value = "Other", this.onChanged})
      : super(key: key);

  @override
  FolderDropDownMenuWidgetState createState() {
    return FolderDropDownMenuWidgetState(
        this.value); // (this._FolderDropDownMenuWidget);
  }
}

class FolderDropDownMenuWidgetState extends State<FolderDropDownMenuWidget> {
  String _curValue;

  FolderDropDownMenuWidgetState(String value) {
    _curValue = value;
  }

  changeValue(value) {
    // widget.onChanged(value);
    setState(() {
      _curValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new DropDownMenuWidget(
      value: _curValue,
      itemList: Constants.folders,
      onChanged: (value) => widget.onChanged(value),
    );
  }
}
