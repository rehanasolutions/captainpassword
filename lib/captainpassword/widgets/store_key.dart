import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rehana/helpers/clipboard.dart';
import 'package:rehana/helpers/date_time.dart';
import 'package:rehana/helpers/toast.dart';
import 'package:rehana/locator.dart';
import 'package:rehana/services/dialog.dart';
import 'package:rehana/widgets/flexible_textfield.dart';
import 'package:captainpassword/captainpassword/constants.dart';
import 'package:captainpassword/captainpassword/services/key.dart';
import 'package:captainpassword/captainpassword/widgets/store_key_duration_drop_down_menu%20copy.dart';

class StoreKeyWidget extends StatefulWidget {
  final String completerId;
  StoreKeyWidget({Key key, this.completerId}) : super(key: key);

  @override
  _StoreKeyWidgetState createState() => new _StoreKeyWidgetState();
}

class _StoreKeyWidgetState extends State<StoreKeyWidget> {
  bool _keyVisible = false;

  String _duration = Constants.keyDurations[0].value;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _keyTextEditingController = new TextEditingController();

  changeDuration(value) {
    _duration = value;
  }

  _toggleKeyVisible() {
    setState(() {
      this._keyVisible = !this._keyVisible;
    });
  }

  _storeKey() async {
    if (_formKey.currentState.validate()) {
      ServiceManager<KeyService>()
          .storeKey(_keyTextEditingController.text, int.parse(_duration));
      showToast(context, "Key stored successfully!");

      this._closeDialog();
    }
  }

  _closeDialog() {
    ServiceManager<DialogService>().completeDialog(
        context: context,
        completerId: widget.completerId,
        result: {'success': true});
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Store key"),
      actionsPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.fromLTRB(16, 16, 16, 0),
      contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        // color: Colors.transparent,
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Text(
                    "You can store AES key for a limited duration which will be automatically loaded when adding or editing a Site.",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                Row(children: <Widget>[
                  FlexibleTextField(
                    decoration: InputDecoration(
                        labelText: 'Key',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _keyVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            semanticLabel:
                                _keyVisible ? 'Hide key' : 'Show key',
                          ),
                          onPressed: () {
                            this._toggleKeyVisible();
                          },
                        )),
                    fixedLengths: [16],
                    readOnly: false,
                    obscureText: !this._keyVisible,
                    controller: this._keyTextEditingController,
                  ),
                  IconButton(
                    icon: Icon(Icons.content_copy),
                    onPressed: () {
                      copyTextToClipboard(this._keyTextEditingController.text);
                      showToast(context, "Key copied!");
                      // locator<DialogService>().dialogComplete({'success': true});
                      // Navigator.of(context).pop();
                    },
                  )
                ]),
                Container(
                    // color: Colors.amber,
                    // width: 96,
                    height: 50,
                    child: Row(children: <Widget>[
                      SizedBox(
                          width: 96,
                          child: Text(
                            "Time:",
                          )),
                      new Flexible(
                          child: new StoreKeyDurationDropDownMenuWidget(
                        value: _duration,
                        onChanged: (value) => changeDuration(value),
                      )
                          //Text(_durationTextEditingController.text),
                          )
                    ])),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 2,
                        child: StreamBuilder(
                            stream: ServiceManager<KeyService>().keystream$,
                            builder: (context, storedKey) {
                              if (storedKey.data != null) {
                                return Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'You have already stored a key, storing new will replace it.',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ));
                              } else {
                                return SizedBox(width: 0, height: 0);
                              }
                            })),
                    StreamBuilder(
                        stream:
                            ServiceManager<KeyService>().remainingTimestream$,
                        builder: (context, timer) {
                          if (timer?.data != 0) {
                            return Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.orange[300],
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(2))),
                                    child: Padding(
                                        padding: EdgeInsets.all(4),
                                        child: Text(
                                          'Time left: ${formatSecondsTime(timer.data)}',
                                          style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 14,
                                          ),
                                        ))));
                          } else {
                            return SizedBox(width: 0, height: 0);
                          }
                        })
                  ],
                )
              ],
            ))),
      ),
      actions: <Widget>[
        RaisedButton(
          child: Text("Store"),
          onPressed: () {
            this._storeKey();
          },
        ),
        RaisedButton(
          child: Text("Cancel"),
          onPressed: () {
            this._closeDialog();
          },
        ),
      ],
    );
  }
}
