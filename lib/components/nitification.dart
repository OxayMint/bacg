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
        height: 70,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.black,
        ),
        child: Center(
            child: Expanded(
          child: Row(
            children: [
              message.type == NotificationType.Error
                  ? Icon(
                      Icons.error,
                      color: Colors.red,
                    )
                  : Icon(Icons.done, color: Colors.green),
              Text(message.text, style: Theme.of(context).textTheme.headline3),
            ],
          ),
        )),
      ),
    );
  }
}
