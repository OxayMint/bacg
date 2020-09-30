import 'dart:math';

import 'package:bacg/components/custom_button.dart';
import 'package:bacg/enums.dart';
import 'package:bacg/model/app_state.dart';
import 'package:bacg/model/otp_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Otp extends StatefulWidget {
  Otp({Key key}) : super(key: key);
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final TextEditingController _otpController = new TextEditingController();
  NumberFormat formatter = new NumberFormat("00");
  double _keyboardHeight;
  double _getStaticGapSize() {
    print('recalculating size');
    final _deviceHeight = MediaQuery.of(context).size.height;
    final _expandedGapSize = _deviceHeight - 418 - 5 - 150;
    return max(_expandedGapSize - _keyboardHeight, 10);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OtpStateModel>(
      create: (context) => OtpStateModel(type: OtpType.Registration),
      child: Consumer<OtpStateModel>(builder: (context, state, widget) {
        final timeRemaining = state.secondsRemaining;
        final mins = (timeRemaining / 60).floor();
        final secs = timeRemaining % 60;
        final phone =
            Provider.of<AppState>(context).registrationPhone.fullNumber;
        // print(mins);
        return Consumer<ScreenHeight>(builder: (context, heightState, widget) {
          _keyboardHeight = heightState.keyboardHeight;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "$phone number verification",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Montserrat",
                ),
              ),
              SizedBox(
                height: 10,
              ),

              // Text(phone),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _otpController,
                decoration: InputDecoration(
                  labelText: "Enter OTP code",
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
              FlatButton(
                onPressed: timeRemaining > 0
                    ? null
                    : () {
                        Provider.of<AppState>(context, listen: false)
                            .setLoginStage(LoginStage.SignUp);
                        // state.restartOtpTimer();
                      },
                child: Text(
                  timeRemaining > 0
                      ? "You can resend code or fix the phone number in $mins:${formatter.format(secs)}" //Localized("you_can_resend_code").value
                      : "Resend code",
                  style:
                      TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
                  textAlign: TextAlign.left,
                ),
              ),
              // BacgButton(
              //     onPressed: () {
              //       state.restart();
              //     },
              //     type: ButtonType.Primary,
              //     text: "Resend"),
              // Expanded(
              //   child: Container(),
              // ),

              SizedBox(
                height: _getStaticGapSize(),
              ),
              BacgButton(
                text: "SEND",
                type: ButtonType.Primary,
                onPressed: () async {
                  if (await Provider.of<AppState>(context, listen: false)
                      .verifyOtp(_otpController.text, OtpType.Registration)) {
                    state.stop();
                  }
                },
              )
            ],
          );
        });
      }),
    );
    // final mins = (remainingTime / 60).floor();
    // final secs = remainingTime % 60;
    // print("mins:$mins, secs: $secs");
    // print(mins);
  }
}
