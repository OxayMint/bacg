// import 'package:bacg/components/pack_logo.dart';
// import 'dart:html';
import 'package:bacg/components/nitification.dart';
import 'package:bacg/model/app_state.dart';
// import 'package:bacg/views/Home.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:bacg/model/requests.dart' as req;
import 'package:provider/provider.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'login_components/login_components.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final offsetTween =
      Tween<Offset>(begin: Offset(0.0, 0.3), end: Offset(0.0, 0.0));
  final opacityTween = Tween(begin: 0.0, end: 1.0);

  // @override
  // void initState() {
  //   super.initState();
  //   // final otpRegPhone =
  // }

  @override
  Widget build(BuildContext context) {
    return KeyboardSizeProvider(
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   shadowColor: Colors.transparent,
        // ),
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
                  Image.asset("assets/logo-white.png"),
                  SizedBox(
                    height: 20,
                  ),
                  Consumer<AppState>(
                    builder: (context, state, w) {
                      return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: getMainWidget(state.loginStage),
                          switchInCurve: Curves.easeInOut,
                          switchOutCurve: Curves.easeInOut,
                          transitionBuilder: (child, animation) {
                            final offsetAnim = offsetTween.animate(animation);
                            final opacityAnim = opacityTween.animate(animation);
                            return SlideTransition(
                              position: offsetAnim,
                              child: FadeTransition(
                                opacity: opacityAnim,
                                child: child,
                              ),
                            );
                          });
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
