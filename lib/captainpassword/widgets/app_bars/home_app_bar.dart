import 'dart:async';

import 'package:captainpassword/theme.dart';
import 'package:flutter/material.dart';
import 'package:rehana/helpers/toast.dart';
import 'package:rehana/locator.dart';
import 'package:rehana/models/app_bar_item.dart';
import 'package:captainpassword/captainpassword/services/auth.dart';
import 'package:rehana/services/dialog.dart';
import 'package:rehana/services/navigation.dart';
import 'package:captainpassword/captainpassword/constants.dart';
import 'package:captainpassword/captainpassword/dialogs/store_key.dart';
import 'package:captainpassword/captainpassword/services/key.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  HomeAppBar({Key key, this.title})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _HomeAppBarState createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  AppBarItem _selectedItem; // The app's "state".

  List<AppBarItem> _getAppBarItems() {
    if (ServiceManager<KeyService>().currentRemainingTime > 0) {
      return <AppBarItem>[
        AppBarItem(title: Constants.KEY_REMOVE, icon: Icons.delete),
        AppBarItem(title: Constants.AUTH_LOGOUT, icon: Icons.power_settings_new)
      ];
    } else {
      return <AppBarItem>[
        AppBarItem(title: Constants.KEY_STORE, icon: Icons.vpn_key),
        AppBarItem(title: Constants.AUTH_LOGOUT, icon: Icons.power_settings_new)
      ];
    }
  }

  void _select(AppBarItem item) {
    // Causes the app to rebuild with the new _selectedItem.
    setState(() {
      _selectedItem = item;
      if (_selectedItem.title == Constants.KEY_STORE) {
        _storeKey();
      } else if (_selectedItem.title == Constants.KEY_REMOVE) {
        _removeKey();
      } else if (_selectedItem.title == Constants.AUTH_LOGOUT) {
        _logOut();
      }
    });
  }

  Future _storeKey() async {
    ServiceManager<DialogService>()
        .showDialog(context, new StoreKeyDialog(), data: null);
  }

  void _removeKey() {
    ServiceManager<KeyService>().removeKey();
    showToast(context, "Key removed successfully!");
  }

  void _logOut() async {
    ServiceManager<AuthService>().logOut();
    ServiceManager<NavigationService>().goBack(result: true);
  }

  @override
  void initState() {
    super.initState();
    _selectedItem = _getAppBarItems()[0];
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _selectedItem = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      actions: [
        PopupMenuButton<AppBarItem>(
          onSelected: _select,
          itemBuilder: (BuildContext context) {
            return _getAppBarItems().map((AppBarItem item) {
              return PopupMenuItem<AppBarItem>(
                  value: item,
                  child: Row(children: [
                    Icon(
                      item.icon,
                      color: LevendrTheme.lightTheme.primaryColor,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Text(item.title),
                    )
                  ]));
            }).toList();
          },
        )
      ],
    );
  }
}
