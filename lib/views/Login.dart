// import 'package:bacg/components/pack_logo.dart';
// import 'dart:html';
import 'package:bacg/model/app_state.dart';
// import 'package:bacg/views/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bacg/model/requests.dart' as req;
import 'package:provider/provider.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'login_components/login_components.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return KeyboardSizeProvider(
      child: Scaffold(
        // appBar: ,
        // resizeToAvoidBottomPadding: false,
        body: Container(
          height: double.infinity, //MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/background.png'),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 152 //MediaQuery.of(context).size.height * 0.2,
                      ),
                  Hero(
                    tag: 'logo',
                    child: Material(
                      color: Colors.transparent,
                      child: Image.asset("assets/logo-white.png"),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Consumer<AppState>(
                    builder: (context, state, w) {
                      return getMainWidget(
                        state.loginStage,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getMainWidget(
    LoginStage stage,
  ) {
    switch (stage) {
      case LoginStage.Lang:
        return Language();
        break;
      case LoginStage.SignIn:
        return SignIn();
        break;
      case LoginStage.SignUp:
        return SignUp();
        break;
      case LoginStage.Otp:
        return Otp();
        break;
    }
  }
}
