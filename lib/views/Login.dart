// import 'package:bacg/components/pack_logo.dart';
// import 'dart:html';
import 'package:bacg/model/app_state.dart';
// import 'package:bacg/views/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bacg/model/requests.dart' as req;
import 'package:provider/provider.dart';

import 'login_components/login_components.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: ,
      // resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/background.png'),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 180,
              ),
              Hero(
                tag: 'logo',
                child: Material(
                  color: Colors.transparent,
                  child: Image.asset("assets/logo-white.png"),
                  // SvgPicture.asset(
                  //   'assets/logo-white.svg',
                  //   width: 200,
                  //   height: 80,
                  // ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Consumer<AppState>(
                builder: (context, state, w) {
                  return Expanded(
                    child: getMainWidget(
                      state.loginStage,
                    ),
                  );
                },
              ),
            ],
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
