import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

Future<void> launchLink(String url) async {
  bool canLaunch = await canLaunchUrlString(url);
  if (canLaunch) {
    await launchUrlString(
      url,
      mode: LaunchMode.inAppWebView,
    );
  }
}

Size getScreenSize(BuildContext context) {
  return MediaQuery.sizeOf(context);
}
