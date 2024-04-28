import 'package:url_launcher/url_launcher_string.dart';

class AboutRepository {
  static const String urlYoutube =
      "https://www.youtube.com/channel/UCKdmyTVMJQgcNSBbhVp271A";
  static const String urlTwitter = "https://twitter.com/Iraqpalm2";
  static const String urlTelegram = "https://t.me/iraqpalm";
  static const String urlFacebook = "https://www.facebook.com/iraqpalm/";
  static const String urlInstagram = "https://www.instagram.com/iraqpalm/";
  static const String urlSiteNews = "https://palms-news.com/";
  static const String urlSiteAraghi = "https://www.iraqpalm.com/";

  static Future<void> launchUrl(String url) async {
    await launchUrlString(url);
  }
}
