import 'package:bacg/components/verify.dart';
import 'package:bacg/model/app_state.dart';
import 'package:bacg/services/local_data.service.dart';
import 'package:bacg/views/Loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/Home.dart';
import 'views/Login.dart';
import 'package:bacg/services/main_service.dart' as service;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalData.getInstance.init();
  runApp(MyApp(loggedIn: false));
}

class MyApp extends StatelessWidget {
  MyApp({Key key, this.loggedIn}) : super(key: key);
  bool loggedIn;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>(
      create: (context) => AppState(),
      child: Consumer<AppState>(builder: (context, state, widget) {
        return MaterialApp(
          routes: {
            '/login': (context) => Login(),
            '/home': (context) => Home(),
          },
          // initialRoute: state.user == null ? '/login' : '/home',
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
                  fontSize: 20,
                  color: Colors.black54,
                  fontWeight: FontWeight.w700),
              headline2: TextStyle(
                  fontFamily: "Montserrat", fontSize: 18, color: Colors.white),
              headline3: TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                  color: Colors.white,
                  letterSpacing: 2),
              bodyText1: TextStyle(
                  fontFamily: "ProximaNova",
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
              bodyText2: TextStyle(
                  fontFamily: "ProximaNova",
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w300),
              caption: TextStyle(
                  fontFamily: "Montserrat", fontSize: 12, color: Colors.grey),
              subtitle1: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w300),
              subtitle2: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
              // bodyText2: TextStyle(fontFamily: "Montserrat", fontSize: 16, color: Colors.black ,fontWeight: FontWeight.w300),
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
