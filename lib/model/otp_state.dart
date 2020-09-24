import 'package:bacg/services/local_data.service.dart';
import 'package:flutter/material.dart';

class OtpStateModel extends ChangeNotifier {
  int timeRemaining;
  bool isRegistration;
  OtpStateModel({this.isRegistration = false}) {
    final Stream timeTicking = new Stream.periodic(Duration(seconds: 1));

    timeTicking.listen((event) {
      timeRemaining--;
      notifyListeners();
    });
  }

  startTimer() {
    var otpTime = LocalData.getInstance.getOtpTime(isRegistration);
    if (otpTime.isBefore(DateTime.now())) {
      LocalData.getInstance.removeOtp(isRegistration);
      otpTime = LocalData.getInstance.getOtpTime(isRegistration);
    }
    timeRemaining = otpTime.difference(DateTime.now()).inSeconds;
  }

  restart() {
    LocalData.getInstance.removeOtp(isRegistration);
    startTimer();
  }
}
