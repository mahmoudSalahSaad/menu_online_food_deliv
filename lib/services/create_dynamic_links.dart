import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:menu_egypt/utilities/constants.dart';
//import 'package:menu_egypt/utilities/size_config.dart';
import 'package:share_plus/share_plus.dart';

class CreateDynamicLinks {
  String? _linkMessage;

  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  Future<void> createRestruantDynamicLink(BuildContext context, int restId,
      String restName, String restImg, bool short) async {
    String dashSeparateRestName = restName.replaceAll(' ', '-');
    print(dashSeparateRestName);
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://menuegupt.page.link',
      link: Uri.parse('https://menuegypt.com/ar/$dashSeparateRestName'),
      androidParameters: const AndroidParameters(
        packageName: 'com.menuegypt.menuegupt',
      ),
      iosParameters: IOSParameters(
        bundleId: 'com.menuegypt.menuegupt',
        appStoreId: "1630657799",
        minimumVersion: "0",
        /*
        fallbackUrl:
            Uri.parse('https://apps.apple.com/eg/app/menu-egypt/id1630657799'),
        */
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: "Menu Egypt - " + restName,
        description: "منيو و رقم دليفرى مطعم $restName فى مصر",
        imageUrl: Uri.parse(restImg),
      ),
      navigationInfoParameters: NavigationInfoParameters(
        forcedRedirectEnabled: true,
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

    Share.share(_linkMessage!);

    //Clipboard.setData(ClipboardData(text: _linkMessage));

    /*
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
    */
  }

  Future<void> createProductsDynamicLink(BuildContext context, int restId,
      String restName, String restImg, bool short) async {
    String dashSeparateRestName = restName.replaceAll(' ', '-');
    print(dashSeparateRestName);
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://menuegupt.page.link',
      link: Uri.parse('https://menuegypt.com/order/$dashSeparateRestName'),
      androidParameters: const AndroidParameters(
        packageName: 'com.menuegypt.menuegupt',
      ),
      iosParameters: IOSParameters(
        bundleId: 'com.menuegypt.menuegupt',
        appStoreId: "1630657799",
        minimumVersion: "0",
        /*
        fallbackUrl:
            Uri.parse('https://apps.apple.com/eg/app/menu-egypt/id1630657799'),
        */
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: "Menu Egypt - " + restName,
        description: "منيو و رقم دليفرى مطعم $restName فى مصر",
        imageUrl: Uri.parse(restImg),
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

    Share.share(_linkMessage!);

    //Clipboard.setData(ClipboardData(text: _linkMessage));

    /*
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
    */
  }
}
