import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rehana/dialogs/info.dart';
import 'package:rehana/helpers/clipboard.dart';
import 'package:rehana/helpers/console.dart';
import 'package:rehana/helpers/toast.dart';
import 'package:rehana/helpers/security.dart';
import 'package:rehana/locator.dart';
import 'package:rehana/services/dialog.dart';
import 'package:rehana/services/url.dart';
import 'package:rehana/widgets/flexible_textfield.dart';
import 'package:rehana/widgets/orientational_column_row.dart';
import 'package:captainpassword/lavendr/blocs/password.dart';
import 'package:captainpassword/lavendr/models/api_result.dart';
import 'package:captainpassword/lavendr/models/password.dart';
import 'package:captainpassword/captainpassword/services/key.dart';
import 'package:captainpassword/captainpassword/widgets/folder_drop_down_menu.dart';

class AddEditSiteWidget extends StatefulWidget {
  final Password document;
  final String completerId;
  AddEditSiteWidget({Key key, this.completerId, this.document})
      : super(key: key);

  @override
  _AddEditSiteWidgetState createState() =>
      new _AddEditSiteWidgetState(document);
}

class _AddEditSiteWidgetState extends State<AddEditSiteWidget> {
  bool _isEncrypted = false;
  bool _keyVisible = false;
  bool _passwordVisible = false;

  String _folder = "Other";
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameTextEditingController =
      new TextEditingController();
  // TextEditingController _folderTextEditingController =
  //     new TextEditingController();

  TextEditingController _urlTextEditingController = new TextEditingController();
  TextEditingController _loginTextEditingController =
      new TextEditingController();
  TextEditingController _passwordTextEditingController =
      new TextEditingController();
  TextEditingController _keyTextEditingController = new TextEditingController();
  TextEditingController _notesTextEditingController =
      new TextEditingController();

  _AddEditSiteWidgetState(Password document) {
    if (ServiceManager<KeyService>().currentKey != null) {
      _keyTextEditingController.text = ServiceManager<KeyService>().currentKey;
    }
    if (document != null) {
      _isEncrypted = document.encrypted;

      _nameTextEditingController.text = document.name;
      _loginTextEditingController.text = document.login;
      _notesTextEditingController.text = document.notes;
      _urlTextEditingController.text = document.url;
      // _folderTextEditingController.text = document.folder;
      _folder = document.folder;

      if (!_isEncrypted) {
        _passwordTextEditingController.text = document.password;
      }
    }
  }

  Widget _encryptionCheckBox() {
    return new Container(
        // color: Colors.amber,
        height: 58,
        child: Padding(
            padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
            child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  Text("AES Encryption:"),
                  Checkbox(
                      value: _isEncrypted,
                      onChanged: (value) => _changeEncrypted(value)),
                ])));
  }

  changeFolder(value) {
    _folder = value;
  }

  Widget _encryptionInput() {
    return new Flexible(
        child: Row(children: <Widget>[
      new FlexibleTextField(
        readOnly: false,
        fixedLengths: [16],
        decoration: InputDecoration(
            labelText: 'Encryption Key',
            suffixIcon: IconButton(
              icon: Icon(
                _keyVisible ? Icons.visibility : Icons.visibility_off,
                semanticLabel: _keyVisible ? 'Hide key' : 'Show key',
              ),
              onPressed: () {
                this._toggleKeyVisible();
              },
            )),
        obscureText: !this._keyVisible,
        controller: this._keyTextEditingController,
      ),
      IconButton(
        icon: Icon(Icons.code),
        onPressed: () {
          this._decryptPassword();
        },
      )
    ]));
  }

  _togglePasswordVisible() {
    setState(() {
      this._passwordVisible = !this._passwordVisible;
    });
  }

  _toggleKeyVisible() {
    setState(() {
      this._keyVisible = !this._keyVisible;
    });
  }

  _changeEncrypted(value) {
    setState(() {
      this._isEncrypted = value;
      // widget.document.encrypted = value;
    });
  }

  _decryptPassword() {
    if (widget.document != null) {
      setState(() {
        if (widget.document.password != null &&
            widget.document.password.length > 0 &&
            _keyTextEditingController.text != null &&
            _keyTextEditingController.text.length > 0) {
          String decryptedResult = Security.decrypt(
              _keyTextEditingController.text, widget.document.password);
          if (decryptedResult != null) {
            this._passwordTextEditingController.text = decryptedResult;
          } else {
            showToast(context, "Wrong AES key!");
          }
        }
      });
    }
  }

  _saveSite() async {
    if (_formKey.currentState.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.

      // locator<DialogService>().dialogComplete({'success': true});
      // Navigator.of(context).pop();
      // locator<DialogService>().dialogComplete({'success': true});
      // Navigator.of(context).pop();

      // ------------------------------------
      /* Ways of showing messages */
      // 1

      APIResult result;

      Password password = Password(
          url: _urlTextEditingController.text,
          name: _nameTextEditingController.text,
          login: _loginTextEditingController.text,
          password: _isEncrypted
              ? Security.encrypt(_keyTextEditingController.text,
                  _passwordTextEditingController.text)
              : _passwordTextEditingController.text,
          folder: _folder,
          notes: _notesTextEditingController.text,
          encrypted: _isEncrypted);

      if (widget.document != null) {
        // Update document
        password.id = widget.document.id;
        result = await passwordBloc.updatePassword(password);
      } else {
        result = await passwordBloc.insertPassword(password);
      }

      if (result.success) {
        showToast(context, "Saved successfully!");
        ServiceManager<DialogService>().completeDialog(
            context: context,
            completerId: widget.completerId,
            result: {'success': true});
      } else {
        showToast(context, "Could not save!");
        ServiceManager<DialogService>().completeDialog(
            context: context,
            completerId: widget.completerId,
            result: {'success': false});
      }

      // 2
      // await locator<DialogService>().show(context, new InfoDialog(),
      //     data: {'title': 'Success!', 'text': 'Saved successfully!'});

      // 3
      // locator<ScaffoldHelperService>().showSnackBar('Saved!');
      // Scaffold.of(context)
      //     .showSnackBar(SnackBar(content: Text('Processing Data')));

      // ------------------------------------
      // String key = this._keyTextEditingController.text;
      // String password = this._passwordTextEditingController.text;

      // if (this._isEncrypted && (key == null || key.length != 16)) {
      //   locator<DialogService>().show(context, new InfoDialog(), data: {
      //     'title': 'Error!',
      //     'text': 'Key should be 16 characters long!'
      //   });
      //   console(ConsoleLevel.Error, "Key invalid");
      // } else if (password == null || password.length == 0) {
      //   locator<DialogService>().show(context, new InfoDialog(),
      //       data: {'title': 'Error!', 'text': 'Password is not valid!'});
      //   console(ConsoleLevel.Error, "Password invalid");
      // } else {
      //   locator<DialogService>().dialogComplete({'success': true});
      //   Navigator.of(context).pop();
      // }

    }
  }

  _openUrl(url) async {
    bool result = await ServiceManager<UrlService>().openUrl(url);
    if (!result) {
      ServiceManager<DialogService>().showDialog(context, new InfoDialog(),
          data: {'title': 'Error!', 'text': 'Url is not valid!'});
    }
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _decryptPassword();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isScreenWide =
        MediaQuery.of(context).size.width >= 480 || size.width > size.height;
    int columns = isScreenWide ? 2 : 1;

    console(ConsoleLevel.Info, "Columns: " + columns.toString());

    // final double itemHeight = 82; //(size.height - kToolbarHeight - 24) / 2;
    // final double itemWidth = size.width / columns - 64;

    return AlertDialog(
      title: Text(widget.document != null ? "Update site" : "Add Site"),
      // TextField(
      //   readOnly: false,
      //   decoration: InputDecoration(labelText: 'Name'),
      //   controller: this._nameTextEditingController,
      // ),
      actionsPadding: EdgeInsets.all(0),
      // buttonPadding: EdgeInsets.all(value),
      titlePadding: EdgeInsets.fromLTRB(16, 16, 16, 0),
      contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        // color: Colors.transparent,
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(
              // defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              // columnWidths: {0: FixedColumnWidth(128), 1: FixedColumnWidth(360)},
              // columnWidths: {
              //   0: FractionColumnWidth(0.3),
              //   1: FractionColumnWidth(0.6)
              // },
              // border: TableBorder.all(),
              children: [
                // Divider(
                //   height: 4,
                //   thickness: 1,
                // ),
                Row(children: <Widget>[
                  FlexibleTextField(
                    readOnly: false,
                    decoration: InputDecoration(labelText: 'Name'),
                    controller: this._nameTextEditingController,
                    minLength: 1,
                  ),
                  IconButton(
                    icon: Icon(Icons.content_copy),
                    onPressed: () {
                      copyTextToClipboard(this._nameTextEditingController.text);
                      showToast(context, "Name copied!");
                      // locator<DialogService>().dialogComplete({'success': true});
                      // Navigator.of(context).pop();
                    },
                  )
                ]),
                Row(children: <Widget>[
                  FlexibleTextField(
                    readOnly: false,
                    decoration: InputDecoration(labelText: 'Url'),
                    controller: this._urlTextEditingController,
                    minLength: 1,
                  ),
                  IconButton(
                    icon: Icon(Icons.content_copy),
                    onPressed: () {
                      copyTextToClipboard(this._urlTextEditingController.text);
                      showToast(context, "Url copied!");
                      // locator<DialogService>().dialogComplete({'success': true});
                      // Navigator.of(context).pop();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.open_in_browser),
                    onPressed: () {
                      this._openUrl(this._urlTextEditingController.text);
                    },
                  )
                ]),
                Row(children: <Widget>[
                  FlexibleTextField(
                    readOnly: false,
                    decoration: InputDecoration(labelText: 'Login'),
                    controller: this._loginTextEditingController,
                    minLength: 1,
                  ),
                  IconButton(
                    icon: Icon(Icons.content_copy),
                    onPressed: () {
                      copyTextToClipboard(
                          this._loginTextEditingController.text);
                      showToast(context, "Login copied!");
                      // locator<DialogService>().dialogComplete({'success': true});
                      // Navigator.of(context).pop();
                    },
                  )
                ]),
                Row(children: <Widget>[
                  FlexibleTextField(
                    decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            semanticLabel: _passwordVisible
                                ? 'Hide password'
                                : 'Show password',
                          ),
                          onPressed: () {
                            this._togglePasswordVisible();
                          },
                        )),
                    minLength: 1,
                    readOnly: false,
                    obscureText: !this._passwordVisible,
                    controller: this._passwordTextEditingController,
                  ),
                  IconButton(
                    icon: Icon(Icons.content_copy),
                    onPressed: () {
                      copyTextToClipboard(
                          this._passwordTextEditingController.text);
                      showToast(context, "Password copied!");
                      // locator<DialogService>().dialogComplete({'success': true});
                      // Navigator.of(context).pop();
                    },
                  )
                ]),
                OrientationalColumnRow(
                  children: _isEncrypted
                      ? <Widget>[
                          _encryptionCheckBox(),
                          _encryptionInput(),
                        ]
                      : <Widget>[
                          _encryptionCheckBox(),
                        ],
                ),
                Row(children: <Widget>[
                  FlexibleTextField(
                    readOnly: false,
                    decoration: InputDecoration(labelText: 'Notes'),
                    controller: this._notesTextEditingController,
                    minLength: 0,
                  ),
                ]),
                Container(
                    // color: Colors.amber,
                    // width: 96,
                    height: 50,
                    child: Row(children: <Widget>[
                      SizedBox(
                          width: 96,
                          child: Text(
                            "Folder:",
                          )),
                      new Flexible(
                          child: new FolderDropDownMenuWidget(
                        value: _folder,
                        onChanged: (value) => changeFolder(value),
                      )
                          //Text(_folderTextEditingController.text),
                          )
                    ])),
              ],
            ))),
      ),
      actions: <Widget>[
        RaisedButton(
          child: Text("Save"),
          onPressed: () {
            this._saveSite();
          },
        ),
        RaisedButton(
          child: Text("Cancel"),
          onPressed: () => ServiceManager<DialogService>().completeDialog(
              context: context,
              completerId: widget.completerId,
              result: {'success': false}),
        ),
      ],
    );
  }
}
