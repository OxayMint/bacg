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
    ..add(AnimType.Position, Tween(begin: Offset(0, 100), end: Offset(0, 0)),
        Duration(milliseconds: 500), Curves.easeInOut)
    ..add(AnimType.Opacity, Tween(begin: .0, end: 1.0),
        Duration(milliseconds: 500), Curves.easeInOut);

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
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: getMainWidget(state.loginStage),
                        transitionBuilder: (child, animation) {
                          final inAnimation = Tween<Offset>(
                                  begin: Offset(0.0, .5), end: Offset(0.0, 0.0))
                              .animate(animation);
                          final outAnimation = Tween<Offset>(
                                  begin: Offset(0.0, .5), end: Offset(0.0, 0.0))
                              .animate(animation);
                          // final offsetAnimation = Tween<Offset>(
                          //         begin: Offset(1.0, 0.0), end: Offset.zero)
                          //     .animate(animation);
                          if (child.key ==
                              ValueKey<int>(state.loginStage.index)) {
                            return SlideTransition(
                              position: inAnimation,
                              child: child,
                            );
                          } else {
                            return SlideTransition(
                              position: outAnimation,
                              child: child,
                            );
                          }
                          // return SlideTransition(
                          //     position: child.key == ValueKey(state.loginStage)
                          //         ? inAnimation
                          //         : outAnimation,
                          //     child: child);
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
    // print(stage.index);
    switch (stage) {
      case LoginStage.Lang:
        return Language(key: ValueKey<int>(stage.index));
        break;
      case LoginStage.SignIn:
        return SignIn(key: ValueKey<int>(stage.index));
        break;
      case LoginStage.SignUp:
        return SignUp(key: ValueKey<int>(stage.index));
        break;
      case LoginStage.Otp:
        return Otp(key: ValueKey<int>(stage.index));
        break;
      default:
        return Container();
    }
  }
}

enum AnimType { Position, Opacity }
