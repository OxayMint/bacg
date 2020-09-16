import 'package:bacg/model/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Otp extends StatefulWidget {
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final TextEditingController _otpController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context);
    final remaining = state.otpRefreshTime.difference(DateTime.now());
    final mins = remaining.inMinutes;
    final secs = remaining.inSeconds - mins * 60;
    return Column(
      children: [
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
        Consumer<AppState>(builder: (context, state, w) {
          return Text(
            "We can resend code in $mins:$secs",
            style: TextStyle(color: Colors.white),
          );
        }),
      ],
    );
  }
}
