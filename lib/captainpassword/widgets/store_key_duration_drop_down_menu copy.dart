import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:rehana/widgets/drop_down_menu.dart';
import 'package:captainpassword/captainpassword/constants.dart';

class StoreKeyDurationDropDownMenuWidget extends StatefulWidget {
  final ValueChanged<dynamic> onChanged;
  final dynamic value;
  StoreKeyDurationDropDownMenuWidget({Key key, this.value, this.onChanged})
      : super(key: key);

  @override
  StoreKeyDurationDropDownMenuWidgetState createState() {
    return StoreKeyDurationDropDownMenuWidgetState(this.value);
  }
}

class StoreKeyDurationDropDownMenuWidgetState
    extends State<StoreKeyDurationDropDownMenuWidget> {
  dynamic _curValue;

  StoreKeyDurationDropDownMenuWidgetState(dynamic value) {
    _curValue = value;
  }

  @override
  Widget build(BuildContext context) {
    return new DropDownMenuWidget(
      value: _curValue,
      itemList: Constants.keyDurations,
      onChanged: (value) => widget.onChanged(value),
    );
  }
}
