import 'package:bacg/model/app_state.dart';
import 'package:bacg/views/home_components/packs.dart';
import 'package:bacg/views/home_components/Settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'home_components/contacts.dart';
import 'home_components/rules.dart';

class Home extends StatefulWidget {
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
    return Scaffold(
      // key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        title: Center(
          child: SvgPicture.asset(
            'assets/logo.svg',
            height: 40,
          ),
        ),
        // title:

        // ,
        // Text(
        //   "Baku Consulting Group",
        //   style: Theme.of(context).textTheme.headline2,
        // ),
        leading: FlatButton(
          child:
              // Icon(drawerOpen ? Icons.close : Icons.menu, color: Colors.grey),
              _getIcon(drawerOpen ? 'close' : 'hamburger'),
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
            // height: 30,
            // width: 30,
            child: IconButton(
                // icon: Icon(Icons.account_circle, color: Colors.grey),
                icon: _getIcon('user'),
                onPressed: () {
                  setState(() {
                    currentWidgetName = 'settings';
                    closeDrawer();
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
                      'Packs',
                      style: Theme.of(context).textTheme.subtitle2,
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
                      style: Theme.of(context).textTheme.subtitle2,
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
                      style: Theme.of(context).textTheme.subtitle2,
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
                      'Log out',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle2,
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
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: setMainWidget(currentWidgetName),
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
      case 'packs':
        return Packs();
      case 'settings':
        return Settings();
      case 'rules':
        return Rules(initial: true);
      case 'contacts':
        return Contacts();
    }
  }

  Widget _getIcon(String name) {
    return SvgPicture.asset('assets/$name.svg', fit: BoxFit.cover);
  }
}
