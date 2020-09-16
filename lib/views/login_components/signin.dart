import 'package:bacg/components/custom_button.dart';
import 'package:bacg/model/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bacg/model/requests.dart' as req;

class SignIn extends StatelessWidget {
  final TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _passController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    return Column(
      children: [
        TextField(
          controller: _phoneController,
          decoration: InputDecoration(
            labelText: "Phone",
            labelStyle: TextStyle(color: Colors.white),
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
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          obscureText: true,
          controller: _passController,
          style: TextStyle(color: Colors.white, fontSize: 16),
          decoration: InputDecoration(
            labelText: "Password",
            labelStyle: TextStyle(color: Colors.white),
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
        Expanded(
          child: Container(),
        ),
        BacgButton(
          text: "SIGN IN",
          type: ButtonType.Primary,
          onPressed: () {
            login(context);
          },
        ),
        FlatButton(
          minWidth: double.infinity,
          onPressed: () {
            appState.setLoginStage(LoginStage.SignUp);
          },
          child: new RichText(
            text: new TextSpan(
              style: new TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14.0,
                color: Colors.white,
              ),
              children: <TextSpan>[
                new TextSpan(
                  text: 'Don\'t have an account? ',
                ),
                new TextSpan(
                  text: 'CREATE',
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // String _phone, _pass;
  void login(BuildContext context) async {
    final appState = Provider.of<AppState>(context, listen: false);
    appState.login(req.Login(phone: '994515224452', password: 'qwerty'));
  }
}
