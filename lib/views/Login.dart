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
import 'package:simple_animations/simple_animations.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with AnimationMixin {
  final multiTween = MultiTween<AnimType>()
    ..add(AnimType.Position,
        Tween(begin: 1.0, end: .0).chain(CurveTween(curve: curve)))
    ..add(AnimType.Opacity, Tween(begin: .0, end: 1.0));

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
                      return PlayAnimation<MultiTweenValues<AnimType>>(
                        tween: multiTween,
                        duration: Duration(seconds: 1),
                        builder: (context, child, val) {
                          return Opacity(
                            opacity: val.get(AnimType.Opacity),
                            child: getMainWidget(
                              state.loginStage,
                            ),
                          );
                        },
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

  Widget getMainWidget(LoginStage stage) {
    switch (stage) {
      case LoginStage.Lang:
        return Language(key: ValueKey<String>("lang"));
        break;
      case LoginStage.SignIn:
        return SignIn(key: ValueKey<String>("signin"));
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

enum AnimType { Position, Opacity }
