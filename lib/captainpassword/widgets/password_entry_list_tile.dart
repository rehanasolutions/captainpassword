import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:captainpassword/lavendr/models/password.dart';

class PasswordEntryListTileWidget extends StatelessWidget {
  final Password document;
  final ValueChanged<dynamic> itemClicked;
  final int resultsPerpage = 8;

  PasswordEntryListTileWidget({Key key, this.document, this.itemClicked})
      : super(key: key);

  createNetworkImageUrl(String url) {
    return 'http://' +
        (("" + url).replaceAll('https://', '').replaceAll('http://', '') +
                '/favicon.ico')
            .replaceAll('//', '/');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
        // padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          // border: Border.all(width: 3.0),
          border: Border.all(color: Colors.grey[300], width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          // boxShadow: <BoxShadow>[
          //   new BoxShadow(
          //     spreadRadius: 0.0,
          //     color: Colors.grey[600],
          //     blurRadius: 1.0,
          //     offset: new Offset(0.0, 1.0),
          //   ),
          // ]
        ),
        child: ListTile(
          dense: false,
          isThreeLine: true,
          title: Text(document.name,
              style: TextStyle(fontWeight: FontWeight.w500)),
          subtitle: Text(document.login),
          leading: Icon(
            Icons.image,
            size: 48,
          ),
          onTap: () => itemClicked(document),
        ));
  }
}
