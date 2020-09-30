import 'package:bacg/model/app_state.dart';
import 'package:bacg/services/localization.service.dart';
import 'package:bacg/views/home_components/packs.dart';
import 'package:bacg/views/home_components/Settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'home_components/contacts.dart';
import 'home_components/rules.dart';

class Home extends StatefulWidget {
  // Home({key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  String currentWidgetName = 'packs';
  bool drawerOpen = false;
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    // if (!appState.rulesAccepted) {
    //   currentWidgetName = 'rules';
    // }
    return Scaffold(
      // key: _scaffoldKey,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        title: Center(
          child: SvgPicture.asset(
            'assets/logo.svg',
            height: 40,
          ),
        ),
        leading: FlatButton(
          child: _getIcon(drawerOpen ? 'close' : 'hamburger', Colors.grey),
          onPressed: () {
            if (_scaffoldKey.currentState.isDrawerOpen) {
              _scaffoldKey.currentState.openEndDrawer();
            } else {
              _scaffoldKey.currentState.openDrawer();
            }
            setState(() {
              drawerOpen = _scaffoldKey.currentState.isDrawerOpen;
            });
          },
        ),
        actions: [
          SizedBox(
            child: IconButton(
                icon: _getIcon('user', Colors.grey),
                onPressed: () {
                  setState(() {
                    if (appState.isAnonymous) {
                      appState.logout();
                    } else {
                      currentWidgetName = 'settings';
                      closeDrawer();
                    }
                  });
                }),
          ),
          // ,
          SizedBox(
            width: 10,
          )
        ],
      ),
      // drawer:
      body: Scaffold(
        // drawerEdgeDragWidth: double.infinity,
        key: _scaffoldKey,
        drawer: Container(
          width: double.infinity,
          child: Drawer(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: ,
                children: [
                  ListTile(
                    title: Text(
                      Localized('packs').value,
                      style: Theme.of(context).textTheme.headline2,
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      setState(() {
                        currentWidgetName = 'packs';
                        closeDrawer();
                      });
                    },
                  ),
                  Divider(
                    color: Colors.black87,
                  ),
                  ListTile(
                    title: Text(
                      'Rules',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    onTap: () {
                      setState(() {
                        currentWidgetName = 'rules';
                        closeDrawer();
                      });
                    },
                  ),
                  Divider(
                    color: Colors.black87,
                  ),
                  ListTile(
                    title: Text(
                      'Contacts',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    onTap: () {
                      setState(() {
                        currentWidgetName = 'contacts';
                        closeDrawer();
                      });
                    },
                  ),
                  Divider(
                    color: Colors.black87,
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Divider(
                    color: Colors.black12,
                  ),
                  ListTile(
                    title: Text(
                      appState.isAnonymous ? 'Log in' : 'Log out',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    onTap: () {
                      appState.logout();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: setMainWidget(
              appState.rulesAccepted ? currentWidgetName : 'rules'),
        ),
      ),
    );
  }

  void closeDrawer() {
    _scaffoldKey.currentState.openEndDrawer();

    setState(() {
      drawerOpen = _scaffoldKey.currentState.isDrawerOpen;
    });
  }

  Widget setMainWidget(String name) {
    switch (name) {
      case 'settings':
        return Settings();
      case 'rules':
        return Rules();
      case 'contacts':
        return Contacts();
      default:
        return Packs();
    }
  }

  Widget _getIcon(String name, Color col) {
    return SvgPicture.asset(
      'assets/$name.svg',
      fit: BoxFit.cover,
      color: col,
    );
  }
}
