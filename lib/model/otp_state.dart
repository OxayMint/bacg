import 'package:bacg/services/local_data.service.dart';
import 'package:flutter/material.dart';

class OtpStateModel extends ChangeNotifier {
  int timeRemaining;
  OtpStateModel() {
    _startTimer();
    final Stream timeTicking = new Stream.periodic(Duration(seconds: 1));

    timeTicking.listen((event) {
      timeRemaining--;
      notifyListeners();
    });
  }

  _startTimer() {
    var otpTime = LocalData.getInstance.getOtpTime();
    if (otpTime.isBefore(DateTime.now())) {
      LocalData.getInstance.removeOtp();
      otpTime = LocalData.getInstance.getOtpTime();
    }
    timeRemaining = otpTime.difference(DateTime.now()).inSeconds;
  }

  restart() {
    LocalData.getInstance.removeOtp();
    _startTimer();
  }
}
