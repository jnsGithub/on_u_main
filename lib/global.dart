import 'package:url_launcher/url_launcher.dart' as url;

Future<void> launchUrl(uri) async {
  Uri _url = Uri.parse(uri);
  if (!await url.launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}