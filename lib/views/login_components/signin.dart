import 'dart:math';

import 'package:bacg/components/country_code_dark.dart';
import 'package:bacg/components/custom_button.dart';
import 'package:bacg/model/app_state.dart';
import 'package:bacg/model/phone_number.dart';
import 'package:bacg/services/localization.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:provider/provider.dart';
import 'package:bacg/model/requests.dart' as req;

class SignIn extends StatefulWidget {
  // SignIn(key)
  SignIn({key}); //: super(key: key);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _passController = new TextEditingController();

  var loading = false;
  var currentCountryCode = 'AZ';
  var currentCountryPrefix = '994';
  // bool _deviceHeight;
  double _keyboardHeight;

  double _getStaticGapSize() {
    print('recalculating size');
    final _deviceHeight = MediaQuery.of(context).size.height;
    final _expandedGapSize = _deviceHeight - 577 - 5; //418 - 94 - 20 - 45;
    return max(_expandedGapSize - _keyboardHeight, 10);
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: true);
    // currentCountryCode = appState.cu
    return Consumer<ScreenHeight>(
      builder: (context, heightState, widget) {
        _keyboardHeight = heightState.keyboardHeight;
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                CountryCodeDark(currentCountryCode, (code, prefix) {
                  setState(() {
                    currentCountryCode = code;
                    currentCountryPrefix = prefix;
                  });
                }),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: Localized("phone").value,
                      labelStyle: TextStyle(color: Colors.white),
                      hintText: "505556677",
                      hintStyle: TextStyle(color: Colors.white70),
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
                ),
              ],
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
            FlatButton(
              // minWidth: double.infinity,
              onPressed: () {
                appState.anonimousLogin();
              },
              child: Text(
                "Skip for now",
                style: new TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14.0,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: _getStaticGapSize(),
            ),
            BacgButton(
              text: Localized("sign_in").value.toUpperCase(),
              type: ButtonType.Primary,
              onPressed: () {
                appState.login(
                    // req.Login(phone: '0515224452', password: 'zxcvbnm'),
                    req.Login(
                        phone: PhoneNumber(
                            countryCode: currentCountryCode,
                            dialCode: currentCountryPrefix,
                            number: _phoneController.text),
                        password: _passController.text));
              },
              disabled: loading,
            ),
            FlatButton(
              // minWidth: double.infinity,
              onPressed: () {
                appState.loginException = null;
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
          ],
        );
      },
    );
  }
}
