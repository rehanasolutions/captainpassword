import 'package:flutter/material.dart';
import 'package:rehana/dialogs/about_app.dart';
import 'package:rehana/helpers/toast.dart';
import 'package:rehana/locator.dart';
import 'package:rehana/models/drawer_item.dart';
import 'package:captainpassword/captainpassword/services/auth.dart';
import 'package:rehana/services/dialog.dart';
import 'package:rehana/services/navigation.dart';
import 'package:captainpassword/captainpassword/constants.dart';
import 'package:captainpassword/captainpassword/dialogs/store_key.dart';
import 'package:captainpassword/captainpassword/services/key.dart';

class NavDrawer extends StatelessWidget {
  List<DrawerItem> _getDrawerActions() {
    List<DrawerItem> actions = <DrawerItem>[];
    if (ServiceManager<KeyService>().currentRemainingTime > 0) {
      actions = [
        ...actions,
        DrawerItem(
            title: Constants.KEY_REMOVE,
            icon: Icons.border_color,
            onTap: _removeKey),
      ];
    } else {
      actions = [
        ...actions,
        DrawerItem(
            title: Constants.KEY_STORE,
            icon: Icons.border_color,
            onTap: _storeKey),
      ];
    }

    if (ServiceManager<AuthService>().user == null) {
      actions = [
        ...actions,
        DrawerItem(
            title: Constants.AUTH_LOGIN,
            icon: Icons.account_circle,
            onTap: _logIn),
      ];
    } else {
      actions = [
        ...actions,
        DrawerItem(
            title: Constants.AUTH_LOGOUT,
            icon: Icons.account_circle,
            onTap: _logOut),
      ];
    }

    actions = [
      ...actions,
      DrawerItem(title: "About", icon: Icons.info, onTap: _showAboutDialog)
    ];

    return actions;
  }

  void _storeKey(context) async {
    Navigator.of(context, rootNavigator: true).pop();
    ServiceManager<DialogService>()
        .showDialog(context, new StoreKeyDialog(), data: null);
  }

  void _removeKey(context) {
    Navigator.of(context, rootNavigator: true).pop();
    ServiceManager<KeyService>().removeKey();
    showToast(context, "Key removed successfully!");
  }

  void _logIn(context) {
    Navigator.of(context, rootNavigator: true).pop();
    ServiceManager<NavigationService>().goBack();
    // locator<NavigationService>().navigateTo(Routes.LOGINSIGNUP);
  }

  void _logOut(context) {
    Navigator.of(context, rootNavigator: true).pop();
    ServiceManager<AuthService>().logOut();
    ServiceManager<NavigationService>().navigateTo(Routes.START);
  }

  void _showAboutDialog(context) {
    // Navigator.of(context, rootNavigator: true).pop();
    ServiceManager<DialogService>()
        .showDialog(context, new AboutAppDialog(), data: null);
  }

  Widget _getDrawerHeader() {
    return DrawerHeader(
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Image(
            image: AssetImage('assets/app_icon.png'),
            height: 64,
          ),
          Text(
            Constants.TITLE,
            style: TextStyle(color: Colors.white, fontSize: 25),
          )
        ]),
        padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          // image: DecorationImage(
          //     fit: BoxFit.fill, image: AssetImage('assets/app_icon.png')),
        ));
  }

  List<Widget> _getView(context) {
    List<Widget> view = [_getDrawerHeader()];

    view = [
      ...view,
      ..._getDrawerActions()
          .map<Widget>((action) => ListTile(
                leading: Icon(action.icon),
                title: Text(action.title),
                onTap: () => {action.onTap(context)},
              ))
          .toList()
    ];

    return view;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: _getView(context)),
    );
  }
}
