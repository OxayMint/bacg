// import 'package:bacg/components/pack_logo.dart';
// import 'dart:html';
import 'package:bacg/components/custom_button.dart';
import 'package:bacg/components/verify.dart';
import 'package:bacg/model/app_state.dart';
// import 'package:bacg/views/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bacg/services/main.service.dart';
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
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(-1, -1),
                radius: 2.0,
                colors: [
                  Color.fromRGBO(37, 152, 33, 1),
                  Color.fromRGBO(17, 74, 76, 1)
                ],
              ),
            ),
          ),
          SizedBox.expand(
            child: SvgPicture.asset(
              'assets/broken_gradient.svg',
              colorBlendMode: BlendMode.darken,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
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
                    child: SvgPicture.asset(
                      'assets/logo-white.svg',
                      width: 200,
                      height: 80,
                    ),
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
        ],
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
