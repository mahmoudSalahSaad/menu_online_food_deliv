import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/providers/restaurants_provider.dart';
import 'package:menu_egypt/providers/resturant_items_provider.dart';
import 'package:menu_egypt/screens/new_restaurant_screen/new_restaurant_screen.dart';
import 'package:menu_egypt/screens/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

import '../screens/new_restaurant_screen/resturant_screen_new.dart';

class FetchDynamicLink {
  int restId = 0;
  String initRoute = '';
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  Future<void> initDynamicLinks(BuildContext context) async {
    dynamicLinks.onLink.listen((dynamicLinkData) async {
      print('DYNAMIC DATA');
      if (dynamicLinkData.link.pathSegments.contains('resturant')) {
        restId = int.parse(dynamicLinkData.link.queryParameters['restId']);
        initRoute = NewRestaurantScreen.routeName;
        print("HERE1");

        Get.toNamed(NewRestaurantScreen.routeName, arguments: [restId]);
      } else if (dynamicLinkData.link.pathSegments.contains('products')) {
        restId = int.parse(dynamicLinkData.link.queryParameters['restId']);
        initRoute = ResturantScreenNew.routeName;
        print("HERE2");

        Get.toNamed(ResturantScreenNew.routeName, arguments: [restId]);
      } else {
        restId = 0;
        initRoute = SplashScreen.routeName;
        print("HERE3");
        Get.toNamed(SplashScreen.routeName);
      }
    }).onError((error) {
      print(error);
    });
  }
}
