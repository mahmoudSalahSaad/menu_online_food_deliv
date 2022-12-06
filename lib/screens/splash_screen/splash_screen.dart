import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:menu_egypt/providers/user_provider.dart';
import 'package:menu_egypt/screens/home_screen/home_screen.dart';
import 'package:menu_egypt/screens/slider_screen/slider_screen.dart';
import 'package:menu_egypt/services/fetch_dynamic_Link.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:menu_egypt/widgets/BaseConnectivity.dart';
import 'package:provider/provider.dart';
import 'package:launch_review/launch_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'components/body.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isAuthenticated = false;

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 1), () async {
      final UserProvider userProvider =
          Provider.of<UserProvider>(context, listen: false);

      await FetchDynamicLink(context).initDynamicLinks(context);

      // final categoryProvider =
      //     Provider.of<CategoriesProvider>(context, listen: false);
      // final cityProvider = Provider.of<CityProvider>(context, listen: false);
      // final regionProvider =
      //     Provider.of<RegionProvider>(context, listen: false);
      // final resturantProvider =
      //     Provider.of<RestaurantsProvider>(context, listen: false);
      // if (categoryProvider.categories.length < 1) {
      //   await categoryProvider.fetchCategories('guest');
      // }
      // if (cityProvider.cities.length < 1) {
      //   await cityProvider.fetchCities();
      // }
      // if (regionProvider.regions.length < 1) {
      //   await regionProvider.fetchRegions();
      // }

      await Provider.of<UserProvider>(context, listen: false)
          .autoAuthenticated();
      _isAuthenticated = userProvider.isAuthenticated;

      if (_isAuthenticated) {
        // if (resturantProvider.mostViewRestaurants.length < 1) {
        //   await resturantProvider.fetchMostViewsRestaurants('guest');
        // }
        if (userProvider.user != null) {
          //userProvider.getUser();
        }
        Get.offNamed(HomeScreen.routeName);
      } else {
        await Provider.of<UserProvider>(context, listen: false).sliderImages();
        Get.offNamed(SliderScreen.routeName);
      }

      //check for updates
      Map<String, dynamic> setting = await userProvider.getAppSetting();
      if (setting['setting'] != null) {
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        String buildNumber = packageInfo.buildNumber;
        print(buildNumber);
        if (Platform.isIOS &&
            int.parse(buildNumber) <
                int.parse(setting['setting'].appleBuildNumber)) {
          print('ios');
          dialog();
        } else if (Platform.isAndroid &&
            int.parse(buildNumber) <
                int.parse(setting['setting'].androidBuildNumber)) {
          print('android');
          dialog();
        } else {
          print('something else');
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return BaseConnectivity(child: Scaffold(body: Body()));
  }

  void dialog() {
    Get.defaultDialog(
        content: Text('إصدار جديد من التطبيق'),
        textConfirm: 'تحديث',
        textCancel: 'تخطى',
        title: 'تنبيه',
        buttonColor: Colors.red,
        onConfirm: () async {
          LaunchReview.launch();
        },
        onCancel: () async {},
        confirmTextColor: kTextColor,
        cancelTextColor: kTextColor);
  }
}
