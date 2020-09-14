import 'package:url_launcher/url_launcher.dart';

class UrlOpener {
  static void launchURL(String url) async {
    const url = 'https://flutter.dev';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
