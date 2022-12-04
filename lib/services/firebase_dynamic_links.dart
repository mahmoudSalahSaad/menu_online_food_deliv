import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/providers/restaurants_provider.dart';
import 'package:menu_egypt/providers/resturant_items_provider.dart';
import 'package:menu_egypt/screens/new_restaurant_screen/new_restaurant_screen.dart';
import 'package:menu_egypt/screens/new_restaurant_screen/resturant_screen_new.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';

class DynamicLink {
  String _linkMessage;

  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  DynamicLink();

  DynamicLink.initializer(BuildContext context) {
    initDynamicLinks(context);
  }

  Future<void> initDynamicLinks(BuildContext context) async {
    dynamicLinks.onLink.listen((dynamicLinkData) {
      if (dynamicLinkData.link.pathSegments.contains('resturant')) {
        Provider.of<RestaurantsProvider>(context, listen: false)
            .fetchRestaurant(
                int.parse(dynamicLinkData.link.queryParameters['restId']));
        Get.toNamed(NewRestaurantScreen.routeName);
      } else if (dynamicLinkData.link.pathSegments.contains('products')) {
        Provider.of<ResturantItemsProvider>(context, listen: false)
            .getResturantCategories(
                int.parse(dynamicLinkData.link.queryParameters['restId']));
        Get.offNamed(ResturantScreenNew.routeName);
      }
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }

  Future<void> createRestruantDynamicLink(
      BuildContext context, int restId, bool short) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://menuegypt.page.link',
      longDynamicLink: Uri.parse(
        'https://menuegypt.page.link/resturant?restId=$restId',
      ),
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
      longDynamicLink: Uri.parse(
        'https://menuegypt.page.link/products?restId=$restId',
      ),
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
