class CustomNotification {
  String text;
  NotificationType type;
  CustomNotification({this.text, this.type});
}

enum NotificationType { Error, Succes }
