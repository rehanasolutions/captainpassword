import 'package:captainpassword/theme.dart';
import 'package:flutter/material.dart';
import 'package:rehana/helpers/console.dart';
import 'package:rehana/services/navigation.dart';
import 'package:captainpassword/captainpassword/dialogs/add_edit_site.dart';
import 'package:rehana/locator.dart';
import 'package:captainpassword/captainpassword/widgets/app_bars/home_app_bar.dart';
import 'package:captainpassword/captainpassword/widgets/drawers/nav_drawer.dart';
import 'package:captainpassword/captainpassword/pages/passwords.dart';
import 'package:rehana/services/dialog.dart';
import 'package:captainpassword/captainpassword/services/auth.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  final String _title = "Passwords Manager";
  final _passwordsPage = PasswordsPage();

  @override
  void initState() {
    _controller = TabController(
      length: 1,
      vsync: this,
    );

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ServiceManager<AuthService>().user == null) {
        ServiceManager<NavigationService>().goBack();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<String> docPaths;

  Future addNewSite(BuildContext context) async {
    String completerId = ServiceManager<DialogService>()
        .showDialog(context, new AddEditSiteDialog(), data: null);
    ServiceManager<DialogService>().onDialogComplete(completerId).then((value) {
      if (value != null && value['success'] == true) {
        console(ConsoleLevel.Info, 'Should update');
        _passwordsPage.reloadData();
      } else {
        console(ConsoleLevel.Info, 'Should not update');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('HOME_KEY'), //locator<ScaffoldHelperService>().scaffoldKey,
      drawer: NavDrawer(),
      appBar: HomeAppBar(
        title: _title,
      ),
      body: Container(
          color: LevendrTheme.lightTheme.cardColor,
          child: Stack(
              children: [] //AnimatedBackgroundWidget.getBackground()
                ..add(Container(
                    // decoration: BoxDecoration(
                    //     color: Colors.amber,
                    //     gradient: LinearGradient(
                    //         colors: [Colors.black, Colors.blueGrey[900]],
                    //         begin: Alignment.topLeft,
                    //         end: Alignment.bottomRight)),
                    child: Column(
                  children: [
                    TabBar(
                      controller: _controller,
                      tabs: [
                        Tab(
                          text: "Passwords",
                          icon: Icon(Icons.library_books),
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _controller,
                        children: [_passwordsPage],
                      ),
                    )
                  ],
                ))))),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          addNewSite(context);
        },
      ),
    );
  }
}
