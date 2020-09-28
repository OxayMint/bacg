import 'package:url_launcher/url_launcher.dart';

class Utils {
  static final String phoneRegex =
      "^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\\s\\./0-9]{6,}\$";
  static void launchURL(String url) async {
    const url = 'https://flutter.dev';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static bool isProperPhone(String phone) {
    return phone.length > 4;
    // return RegExp(phoneRegex).hasMatch(phone);
  }
}
