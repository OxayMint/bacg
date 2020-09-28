import 'package:bacg/components/custom_button.dart';
import 'package:bacg/enums.dart';
import 'package:bacg/model/app_state.dart';
import 'package:bacg/model/otp_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _nameController = new TextEditingController();
  final _oldPhoneController = new TextEditingController();
  final _newPhoneController = new TextEditingController();
  final _oldPassController = new TextEditingController();
  final _newPassController = new TextEditingController();
  final _newPassConfirmController = new TextEditingController();
  final _otpCodeController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    _newPhoneController.text = appState.newPhoneNumber ?? '';
  }

  NumberFormat formatter = new NumberFormat("00");
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        _nameController.text = '${appState.user.name} ${appState.user.surname}';
        _oldPhoneController.text = appState.user.phone;
        return ChangeNotifierProvider<OtpStateModel>(
          create: (context) => OtpStateModel(type: OtpType.Update),
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Text("Change phone number"),

                  TextField(
                    controller: _nameController,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: "Name",
                    ),
                    style: TextStyle(color: Color.fromRGBO(72, 72, 72, 1)),
                    keyboardType: TextInputType.name,
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Text(
                    "Phone",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _oldPhoneController,
                    enabled: false,
                    // strutStyle: StrutStyle(height: 0.8),
                    decoration: InputDecoration(
                      filled: true,
                      labelText: "Phone",
                    ),
                    style: TextStyle(color: Color.fromRGBO(72, 72, 72, 1)),
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: TextField(
                          // strutStyle: StrutStyle(height: 0.8),
                          controller: _newPhoneController,
                          onChanged: (val) {
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            filled: true,
                            labelText: "New phone",
                            hintText: "994501234567",
                          ),
                          style:
                              TextStyle(color: Color.fromRGBO(72, 72, 72, 1)),
                          keyboardType: TextInputType.phone,
                          enabled: appState.newPhoneNumber == null,
                        ),
                      ),
                      AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        child: appState.newPhoneNumber == null
                            ? Container()
                            : Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  BacgButton(
                                    text: 'Wrong phone',
                                    onPressed: () {
                                      appState.removeOtp(OtpType.Update);
                                    },
                                    type: ButtonType.Warning,
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Consumer<OtpStateModel>(builder: (context, state, widget) {
                    final timeRemaining = state.secondsRemaining;
                    final mins = (timeRemaining / 60).floor();
                    final secs = timeRemaining % 60;
                    final String timeRemain = '$mins:${formatter.format(secs)}';
                    return appState.newPhoneNumber == null
                        ? Container()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                // width: 230,
                                child: TextField(
                                  controller: _otpCodeController,
                                  // strutStyle: StrutStyle(height: 0.8),
                                  decoration: InputDecoration(
                                    filled: true,
                                    labelText: "SMS code",
                                  ),
                                  style: TextStyle(
                                      color: Color.fromRGBO(72, 72, 72, 1)),
                                  keyboardType: TextInputType.phone,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              BacgButton(
                                text: state.secondsRemaining > 0
                                    ? timeRemain //'$mins:${secs}'
                                    : 'Resend',
                                onPressed: () {
                                  if (state.secondsRemaining <= 0) {
                                    appState.resendCode(OtpType.Update);
                                    state.restartOtpTimer();
                                  }
                                },
                                type: state.secondsRemaining > 0
                                    ? ButtonType.Primary
                                    : ButtonType.Action,
                                disabled: state.secondsRemaining > 0,
                              ),
                            ],
                          );
                  }),
                  // ),
                  BacgButton(
                    onPressed:
                        // Utils.isProperPhone(_newPhoneController.text) ?
                        () {
                      if (appState.newPhoneNumber == null) {
                        appState.updatePhone(_newPhoneController.text);
                        Provider.of<OtpStateModel>(context, listen: false)
                            .restartOtpTimer();
                      } else {
                        appState.verifyOtp(
                            _otpCodeController.text, OtpType.Update);
                      }
                      setState(() {});
                    }
                    // : null
                    ,
                    type: ButtonType.Primary,
                    text: 'SAVE',
                    iconName: 'save',
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Text(
                    "Password",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _oldPassController,
                    obscureText: true,
                    // strutStyle: StrutStyle(height: 0.8),
                    decoration: InputDecoration(
                      filled: true,
                      labelText: "Old password",
                    ),
                    style: TextStyle(color: Color.fromRGBO(72, 72, 72, 1)),
                    // keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _newPassController,
                    obscureText: true,
                    // strutStyle: StrutStyle(height: 0.8),
                    decoration: InputDecoration(
                      filled: true,
                      labelText: "New password",
                    ),
                    style: TextStyle(color: Color.fromRGBO(72, 72, 72, 1)),
                    // keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _newPassConfirmController,
                    obscureText: true,
                    // strutStyle: StrutStyle(height: 0.8),
                    decoration: InputDecoration(
                      filled: true,
                      labelText: "Confirm new password",
                    ),
                    style: TextStyle(color: Color.fromRGBO(72, 72, 72, 1)),
                    // keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BacgButton(
                    onPressed:
                        // Utils.isProperPhone(_newPhoneController.text) ?
                        () {
                      if (_newPassConfirmController.text ==
                          _newPassController.text) {
                        appState.updatePassword(
                            _oldPassController.text, _newPassController.text);
                      } else {
                        print('passwords don\'t match');
                      }
                    }
                    // : null
                    ,
                    type: ButtonType.Primary,
                    text: 'SAVE',
                    iconName: 'save',
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     BacgButton(
                  //       onPressed: () {},
                  //       type: ButtonType.Warning,
                  //       text: 'Discard',
                  //     ),
                  //     SizedBox(
                  //       width: 20,
                  //     ),
                  //     BacgButton(
                  //         onPressed: () {},
                  //         type: ButtonType.Action,
                  //         text: 'Save'),
                  //   ],
                  // )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
