import 'package:flutter/material.dart';
import 'package:rehana/helpers/console.dart';
import 'package:captainpassword/lavendr/blocs/password.dart';
import 'package:captainpassword/captainpassword/dialogs/add_edit_site.dart';
import 'package:rehana/locator.dart';
import 'package:captainpassword/lavendr/models/password.dart';
import 'package:rehana/services/search.dart';

import 'package:captainpassword/captainpassword/widgets/passwords_list.dart';
import 'package:rehana/widgets/search.dart';

import 'package:rehana/services/dialog.dart';

class PasswordsPage extends StatelessWidget {
  final TextEditingController _searchTextEditingController =
      new TextEditingController();

  /// Reloads data from bloc
  reloadData() {
    passwordBloc.getPasswords();
  }

  _openAddUpdateDialog(BuildContext context, Password model) {
    String completerId = ServiceManager<DialogService>()
        .showDialog(context, new AddEditSiteDialog(), data: model);
    ServiceManager<DialogService>().onDialogComplete(completerId).then((value) {
      if (value != null && value['success'] == true) {
        console(ConsoleLevel.Info, 'Should update');
        reloadData();
      } else {
        console(ConsoleLevel.Info, 'Should not update');
      }
    });
  }

  List<Password> _getFilteredList(List<Password> documents) {
    List<Password> result = [];
    if (documents.length > 0) {
      if (_searchTextEditingController.text != null &&
          _searchTextEditingController.text.length > 0) {
        String text = _searchTextEditingController.text.toLowerCase();
        result = documents
            .where((x) =>
                x.url.toLowerCase().contains(text) ||
                x.login.toLowerCase().contains(text))
            .toList();
      } else {
        result = documents.toList();
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    reloadData();
    return StreamBuilder(
        stream: passwordBloc.stream$,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return StreamBuilder(
                stream: ServiceManager<SearchService>().stream$,
                builder: (context, searchStream) {
                  List<Password> documents = snapshot.data;
                  List<Password> filteredDocuments =
                      _getFilteredList(documents);
                  return Container(
                    child: Column(children: [
                      // KeyWidget(controller: _keyTextEditingController),
                      Padding(
                          padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
                          child: SearchWidget(
                            controller: this._searchTextEditingController,
                          )),
                      Flexible(
                          child: PasswordsListWidget(
                              list: filteredDocuments,
                              itemClicked: (doc) =>
                                  _openAddUpdateDialog(context, doc)))
                    ]),
                  );
                });
          }
        });
  }
}
