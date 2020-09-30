import 'package:bacg/model/responses.dart';

class CustomNotification {
  String text;
  NotificationType type;
  CustomNotification({this.text, this.type}) {
    this.text = text ?? '';
  }

  CustomNotification.fromResponse(Response response) {
    type = response.success ? NotificationType.Succes : NotificationType.Error;
    text = response.msg ?? '';
  }
}

enum NotificationType { Error, Succes }
