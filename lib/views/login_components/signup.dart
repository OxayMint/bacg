import 'dart:math';

import 'package:bacg/components/custom_button.dart';
import 'package:bacg/model/app_state.dart';
import 'package:bacg/services/localization.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:provider/provider.dart';
import 'package:bacg/model/requests.dart' as req;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _surnameController = new TextEditingController();
  final TextEditingController _passController = new TextEditingController();
  final TextEditingController _passConfirmController =
      new TextEditingController();
  double _keyboardHeight = 0;
  double _gapSize = 0;
  final GlobalKey _columnKey = new GlobalKey();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _setGapSize());
  }

  _setGapSize() {
    print('recalculating size');
    final _deviceHeight = MediaQuery.of(context).size.height;
    double _columnHeight;
    if (_columnKey.currentContext != null) {
      _columnHeight =
          (_columnKey.currentContext.findRenderObject() as RenderBox)
              .size
              .height;
    } else {
      _columnHeight = 0;
    }

    print('column height : $_columnHeight');
    final _expandedGapSize = _deviceHeight - 418 - 5 - _columnHeight;
    setState(() {
      _gapSize = max(_expandedGapSize - _keyboardHeight, 10);
    });
  }

  double _getStaticGapSize() {
    print('recalculating size');
    final _deviceHeight = MediaQuery.of(context).size.height;
    final _expandedGapSize = _deviceHeight - 418 - 5 - 277;
    return max(_expandedGapSize - _keyboardHeight, 10);
  }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.
    // _setSizes();
    final appState = Provider.of<AppState>(context, listen: false);
    return Consumer<ScreenHeight>(builder: (context, heightState, widget) {
      _keyboardHeight = heightState.keyboardHeight;
      // _setGapSize();
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              key: _columnKey,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    errorText: appState.registerExceptions['name'],
                    labelText: Localized("name").value,
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
                  controller: _surnameController,
                  decoration: InputDecoration(
                    errorText: appState.registerExceptions['surname'],
                    labelText: Localized("surname").value,
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
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    // errorBorder: InputBorder.none,
                    // errorText: appState.registerExceptions['phone'],
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
                    errorText: appState.registerExceptions['password'],
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
                SizedBox(
                  height: 10,
                ),
                TextField(
                  obscureText: true,
                  controller: _passConfirmController,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                    errorText: appState.registerExceptions['confirm_pass'],
                    labelText: Localized("confirm_pass").value,
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
                SizedBox(
                  height: 10,
                ),
                // ListView.builder(
                //   itemCount: appState.registerExceptions.length,
                //   itemBuilder: (BuildContext context, int index) {
                //     return ListTile();
                //   },
                // ),
                Text(
                  appState.loginException ?? '',
                  style: Theme.of(context).textTheme.overline,
                ),
              ],
            ),
            SizedBox(
              height: _getStaticGapSize(),
            ),
            // Expanded(
            //   child: Container(),
            // ),
            Column(
              children: [
                BacgButton(
                  text: Localized("sign_up").value,
                  type: ButtonType.Primary,
                  onPressed: () {
                    appState.loginException = null;
                    if (_nameController.text == '' ||
                        _surnameController.text == '' ||
                        _phoneController.text == '' ||
                        _passController.text == '' ||
                        _passConfirmController.text == '') {
                      setState(() {
                        appState.loginException = "All fields should be filled";
                      });
                    } else {
                      final request = req.Register(
                          name: _nameController.text,
                          surname: _surnameController.text,
                          phone: _phoneController.text,
                          password: _passController.text);
                      print(request.toMap());
                      appState.register(request);
                    }
                  },
                ),
                FlatButton(
                  // minWidth: double.infinity,
                  onPressed: () {
                    appState.loginException = null;
                    appState.setLoginStage(LoginStage.SignIn);
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
                          text: Localized('already_have_account').value,
                        ),
                        new TextSpan(
                          text: Localized('sign_in').value.toUpperCase(),
                          style: new TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
