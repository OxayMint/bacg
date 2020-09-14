// import 'package:bacg/components/pack_logo.dart';
// import 'dart:html';
import 'package:bacg/components/custom_button.dart';
import 'package:bacg/components/verify.dart';
import 'package:bacg/model/app_state.dart';
// import 'package:bacg/views/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bacg/services/main_service.dart';
import 'package:bacg/model/requests.dart' as req;
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  // String _phone, _pass;
  void login(BuildContext context) async {
    final appState = Provider.of<AppState>(context, listen: false);
    appState.login(req.Login(phone: '994515224452', password: 'qwerty'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            fit: BoxFit.cover,
            colorBlendMode: BlendMode.darken,
          )),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/logo-white.svg',
                  width: 200,
                  height: 70,
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    filled: true,
                    // border: InputBorder.none,
                    labelText: "Phone number",
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: "+994 50 123 45 67 ",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    fillColor: Colors.black45,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  obscureText: true,
                  controller: _passController,
                  decoration: InputDecoration(
                    filled: true,
                    // border: InputBorder.none,
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.white),
                    // hintText: "",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    fillColor: Colors.black45,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                BacgButton(
                  text: "Log in",
                  type: ButtonType.Login,
                  onPressed: () {
                    login(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
