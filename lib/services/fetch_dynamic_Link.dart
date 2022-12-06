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
  RestaurantsProvider restProvider;
  ResturantItemsProvider restItemsProvider;
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  FetchDynamicLink(BuildContext context) {
    restProvider = Provider.of<RestaurantsProvider>(context, listen: false);
    restItemsProvider =
        Provider.of<ResturantItemsProvider>(context, listen: false);
  }

  Future<void> initDynamicLinks(BuildContext context) async {
    //if the app is closed
    await Future.delayed(Duration(seconds: 3));
    final PendingDynamicLinkData data = await dynamicLinks.getInitialLink();
    if (data != null) {
      print('DYNAMIC DATA');
      restId = int.parse(data.link.queryParameters['restId']);

      if (data.link.pathSegments.contains('resturant')) {
        print("HERE1");
        await restProvider
            .fetchRestaurant(restId)
            .then((value) => Get.toNamed(NewRestaurantScreen.routeName));
      } else if (data.link.pathSegments.contains('products')) {
        print("HERE2");
        await restProvider.fetchRestaurant(restId);
        await restItemsProvider
            .getResturantCategories(restId)
            .then((value) => Get.toNamed(ResturantScreenNew.routeName));
      } else {
        print("HERE3");
        Get.toNamed(SplashScreen.routeName);
      }
    }

    //if the app is opened
    dynamicLinks.onLink.listen((dynamicLinkData) async {
      print('DYNAMIC DATA');
      restId = int.parse(dynamicLinkData.link.queryParameters['restId']);

      if (dynamicLinkData.link.pathSegments.contains('resturant')) {
        print("HERE1");

        await restProvider
            .fetchRestaurant(restId)
            .then((value) => Get.toNamed(NewRestaurantScreen.routeName));
      } else if (dynamicLinkData.link.pathSegments.contains('products')) {
        print("HERE2");
        await restProvider.fetchRestaurant(restId);
        await restItemsProvider
            .getResturantCategories(restId)
            .then((value) => Get.toNamed(ResturantScreenNew.routeName));
      } else {
        print("HERE3");
        Get.toNamed(SplashScreen.routeName);
      }
    }).onError((error) {
      print(error);
    });
  }
}
