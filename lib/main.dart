import 'package:bacg/components/verify.dart';
import 'package:bacg/model/app_state.dart';
import 'package:bacg/services/local_data.service.dart';
import 'package:bacg/services/localization.service.dart';
import 'package:bacg/views/Loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'views/Home.dart';
import 'views/Login.dart';
import 'package:bacg/services/main.service.dart' as service;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.blue, // navigation bar color
    statusBarColor: Colors.black, // status bar color
  ));
  // SystemChrome.setSystemUIOverlayStyle(
  //     SystemUiOverlayStyle(statusBarColor: Colors.black));
  await LocalData.getInstance.init();
  await Localization.getInstance.init();
  runApp(BacgApp());
}

class BacgApp extends StatelessWidget {
  BacgApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>(
      create: (context) => AppState(),
      child: Consumer<AppState>(builder: (context, state, widget) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'BACG',
          theme: ThemeData(
            primarySwatch:
                Colors.green, //MaterialColor(Color.fromARGB(a, r, g, b)),
            // accentColor: Colors.green,
            // accentColor: Color.fromRGBO(255, 110, 115, 1),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            inputDecorationTheme: InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(242, 242, 242, 1)),
                borderRadius: BorderRadius.circular(2),
              ),
              labelStyle: TextStyle(color: Color.fromRGBO(143, 143, 143, 1)),
              fillColor: Color.fromRGBO(247, 247, 247, 1),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(143, 143, 143, 1)),
                borderRadius: BorderRadius.circular(2),
              ),
              isDense: true,
              contentPadding: EdgeInsets.all(11),
              filled: true,
            ),
            textTheme: TextTheme(
              headline1: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 24,
                  // color: Colors.black87,
                  color: Color.fromRGBO(72, 72, 72, 1),
                  fontWeight: FontWeight.w700), //Black big headline
              headline2: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 20,
                  color: Color.fromRGBO(72, 72, 72, 1),
                  // color: Colors.black87,
                  fontWeight: FontWeight.w700), //Black headline
              headline3: TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                  color: Colors.white,
                  letterSpacing: 2), //White bold headline
              bodyText1: TextStyle(
                  fontFamily: "ProximaNova",
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
              bodyText2: TextStyle(
                fontFamily: "ProximaNova",
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
              caption: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 12,
                // color: Colors.grey,
                color: Color.fromRGBO(72, 72, 72, 1),
                fontWeight: FontWeight.w600,
              ),
              subtitle1: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 14,
                // color: Colors.black,
                color: Color.fromRGBO(72, 72, 72, 1),
                fontWeight: FontWeight.w300,
              ),
              subtitle2: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 18,
                  color: Color.fromRGBO(72, 72, 72, 1),
                  fontWeight: FontWeight.w700),
              overline: TextStyle(
                fontFamily: "Montserrat",
                color: Color.fromRGBO(255, 139, 139, 1),
                fontWeight: FontWeight.w600,
                fontSize: 15,
                letterSpacing: 0.7,
              ),
            ),
          ),
          home: state.loading
              ? Loading()
              : state.user == null
                  ? Login()
                  : Home(),
        );
      }),
    );
  }
}
