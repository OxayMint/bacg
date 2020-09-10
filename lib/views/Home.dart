import 'package:bacg/views/home_components/packs.dart';
import 'package:bacg/views/home_components/Settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    return Scaffold(
      // key: _scaffoldKey,
      appBar: AppBar(
        //title: SvgPicture.asset('assets/logo-white.svg', height: 40,),
        title: Text(
          "Baku Consulting Group",
          style: Theme.of(context).textTheme.headline2,
        ),
        leading: FlatButton(
          child:
              Icon(drawerOpen ? Icons.close : Icons.menu, color: Colors.white),
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
          IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                setState(() {
                  currentWidgetName = 'settings';
                  closeDrawer();
                });
              }),
          // ,
          SizedBox(
            width: 10,
          )
        ],
      ),
      // drawer:
      body: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.view_list,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(
                  'Packs',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                onTap: () {
                  setState(() {
                    currentWidgetName = 'packs';
                    closeDrawer();
                  });
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.pan_tool,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(
                  'Rules',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                onTap: () {
                  setState(() {
                    currentWidgetName = 'rules';
                    closeDrawer();
                  });
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.phone,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(
                  'Contacts',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                onTap: () {
                  setState(() {
                    currentWidgetName = 'contacts';
                    closeDrawer();
                  });
                },
              ),
              Expanded(
                child: Container(),
              ),
              ListTile(
                leading: Icon(
                  Icons.power_settings_new,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(
                  'Log out',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                onTap: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/login', (route) => false);
                },
              ),
            ],
          ),
        ),
        body: setMainWidget(currentWidgetName),
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
}
