import 'package:bacg/enums.dart';
import 'package:bacg/services/local_data.service.dart';
import 'package:flutter/material.dart';

class OtpStateModel extends ChangeNotifier {
  int secondsRemaining;
  final OtpType type;
  OtpStateModel({@required this.type}) {
    final Stream timeTicking = new Stream.periodic(Duration(seconds: 1));
    secondsRemaining = LocalData.getInstance
        .getOtpTime(type)
        .difference(DateTime.now())
        .inSeconds;
    timeTicking.listen((event) {
      secondsRemaining--;
      notifyListeners();
    });
  }

  startOtpTimer() {
    var otpTime = LocalData.getInstance.getOtpTime(type);
    if (otpTime.isBefore(DateTime.now())) {
      LocalData.getInstance.removeOtp(type);
      otpTime = LocalData.getInstance.getOtpTime(type);
    }
    secondsRemaining = otpTime.difference(DateTime.now()).inSeconds;
    notifyListeners();
  }

  restartOtpTimer() {
    // LocalData.getInstance.removeOtp(type);
    LocalData.getInstance.resetOtpTime(type);
    startOtpTimer();
  }
}
