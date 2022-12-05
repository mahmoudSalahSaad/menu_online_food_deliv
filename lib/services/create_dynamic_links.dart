import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';

class CreateDynamicLinks {
  String _linkMessage;

  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  Future<void> createRestruantDynamicLink(
      BuildContext context, int restId, bool short) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://menuegypt.page.link',
      link: Uri.parse('https://menuegypt.page.link/resturant?restId=$restId'),
      androidParameters: const AndroidParameters(
        packageName: 'com.menuegypt.app.menuegyptapp',
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.example.menuEgypt',
      ),
    );

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink =
          await dynamicLinks.buildShortLink(parameters);
      url = shortLink.shortUrl;
    } else {
      url = await dynamicLinks.buildLink(parameters);
    }

    _linkMessage = url.toString();

    Clipboard.setData(ClipboardData(text: _linkMessage));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: kAppBarColor,
        content: Text(
          'تم نسخ الرابط قم بمشاركته الان',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'DroidArabic',
            fontSize: getProportionateScreenHeight(15),
          ),
        ),
      ),
    );
  }

  Future<void> createProductsDynamicLink(
      BuildContext context, int restId, bool short) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://menuegypt.page.link',
      link: Uri.parse('https://menuegypt.page.link/products?restId=$restId'),
      androidParameters: const AndroidParameters(
        packageName: 'com.menuegypt.app.menuegyptapp',
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.example.menuEgypt',
      ),
    );

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink =
          await dynamicLinks.buildShortLink(parameters);
      url = shortLink.shortUrl;
    } else {
      url = await dynamicLinks.buildLink(parameters);
    }

    _linkMessage = url.toString();

    Clipboard.setData(ClipboardData(text: _linkMessage));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: kAppBarColor,
        content: Text(
          'تم نسخ الرابط قم بمشاركته الان',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'DroidArabic',
            fontSize: getProportionateScreenHeight(15),
          ),
        ),
      ),
    );
  }
}
