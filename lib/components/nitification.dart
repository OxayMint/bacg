import 'package:auto_animated/auto_animated.dart';
import 'package:bacg/model/app_state.dart';
import 'package:bacg/model/notification.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';

class NotifyBar extends StatelessWidget {
  final CustomNotification message;
  NotifyBar({this.message});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 48,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.black87,
        ),
        child: Center(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              message.type == NotificationType.Error
                  ? SizedBox(
                      height: 24,
                      width: 24,
                      child: Image(
                        image: AssetImage('assets/icons/exclamation.png'),
                      ),
                    )
                  : SizedBox(
                      height: 24,
                      width: 24,
                      child: Image(
                        image: AssetImage('assets/icons/check.png'),
                      ),
                    ),
              SizedBox(width: 10),
              Material(
                color: Colors.transparent,
                child: Text(
                  message.text,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: message.type == NotificationType.Succes
                        ? Color.fromRGBO(92, 209, 88, 1)
                        : Color.fromRGBO(225, 114, 114, 1),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
