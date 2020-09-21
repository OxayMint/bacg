import 'package:bacg/components/custom_button.dart';
import 'package:bacg/model/app_state.dart';
import 'package:bacg/services/localization.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bacg/model/requests.dart' as req;

class SignIn extends StatelessWidget {
  final TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _passController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: true);
    return Column(
      children: [
        TextField(
          controller: _phoneController,
          decoration: InputDecoration(
            labelText: Localized("phone").value,
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
            labelText: Localized("password").value,
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
        appState.loginException == null
            ? Container()
            : Text(appState.loginException),
        // Expanded(
        //   child: Container(),
        // ),
        BacgButton(
          text: Localized("sign_in").value.toUpperCase(),
          type: ButtonType.Primary,
          onPressed: () {
            appState
                .login(req.Login(phone: '994515224452', password: 'qwerty'));
            // login(context);
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
                  text: Localized('dont_have_account').value,
                ),
                new TextSpan(
                  text: Localized('create').value.toUpperCase(),
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        // FlatButton(
        //   minWidth: double.infinity,
        //   onPressed: () {
        //     appState.anonimousLogin();
        //   },
        //   child: Text(
        //     "Skip for now",
        //     style: new TextStyle(
        //       fontFamily: 'Montserrat',
        //       fontSize: 14.0,
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
      ],
    );
  }

  // String _phone, _pass;
  // void login(BuildContext context) async {
  //   final appState = Provider.of<AppState>(context, listen: false);
  //   // appState.login();
  // }
}
