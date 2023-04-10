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
  RestaurantsProvider? restProvider;
  ResturantItemsProvider? restItemsProvider;
  FirebaseDynamicLinks? dynamicLinks = FirebaseDynamicLinks.instance;

  FetchDynamicLink(BuildContext context) {
    restProvider = Provider.of<RestaurantsProvider>(context, listen: false);
    restItemsProvider =
        Provider.of<ResturantItemsProvider>(context, listen: false);
  }

  Future<void> initDynamicLinks(BuildContext context) async {
    //if the app is closed
    final PendingDynamicLinkData? data = await dynamicLinks!.getInitialLink();
    if (data != null) {
      print("APP IS CLOSED");
      if (data.link.pathSegments.contains('ar')) {
        print("RESTURANT");
        await restProvider
            !.fetchRestaurantByUrl(
              Uri.decodeComponent(
                data.link.toString().split('ar/')[1],
              ),
            )
            .then(
              (value) => Get.toNamed(NewRestaurantScreen.routeName),
            );
      } else if (data.link.pathSegments.contains('order')) {
        print("ORDER");
        await restProvider!.fetchRestaurantByUrl(
          Uri.decodeComponent(
            data.link.toString().split('order/')[1],
          ),
        );
        await restItemsProvider
            !.getResturantCategoriesAndProductsByUrl(
              Uri.decodeComponent(
                data.link.toString().split('order/')[1],
              ),
            )
            .then(
              (value) => Get.toNamed(ResturantScreenNew.routeName),
            );
      } else {
        Get.toNamed(SplashScreen.routeName);
      }
    }

    //if the app is opened
    dynamicLinks!.onLink.listen((dynamicLinkData) async {
      print("APP IS OPENED");
      if (dynamicLinkData.link.pathSegments.contains('ar')) {
        print("RESTURANT ${Uri.decodeComponent(
          dynamicLinkData.link.toString().split('ar/')[1],
        )}");
        await restProvider
            !.fetchRestaurantByUrl(
              Uri.decodeComponent(
                dynamicLinkData.link.toString().split('ar/')[1],
              ),
            )
            .then(
              (value) => Get.toNamed(NewRestaurantScreen.routeName),
            );
      } else if (dynamicLinkData.link.pathSegments.contains('order')) {
        print("ORDER");
        await restProvider!.fetchRestaurantByUrl(
          Uri.decodeComponent(
            dynamicLinkData.link.toString().split('order/')[1],
          ),
        );
        await restItemsProvider
            !.getResturantCategoriesAndProductsByUrl(
              Uri.decodeComponent(
                dynamicLinkData.link.toString().split('order/')[1],
              ),
            )
            .then(
              (value) => Get.toNamed(ResturantScreenNew.routeName),
            );
      } else {
        Get.toNamed(SplashScreen.routeName);
      }
    }).onError((error) {
      print(error);
    });
  }
}
