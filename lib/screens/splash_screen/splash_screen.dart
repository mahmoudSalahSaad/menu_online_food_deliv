import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  String firstUseApp = '';

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 1), () async {
      final UserProvider userProvider =
          Provider.of<UserProvider>(context, listen: false);

      //FetchDynamicLink
      await FetchDynamicLink(context).initDynamicLinks(context);

      //firstUseApp
      SharedPreferences prefs = await SharedPreferences.getInstance();
      firstUseApp = prefs.getString("firstuseapp") ?? '';
      await prefs.setString("firstuseapp", "1");

      //autoAuthenticated
      await Provider.of<UserProvider>(context, listen: false)
          .autoAuthenticated();
      _isAuthenticated = userProvider.isAuthenticated;

      /*
      //navigate HomeScreen
      if (_isAuthenticated) {
        Get.offNamed(HomeScreen.routeName);
      }
      */

      //navigate SliderScreen
      if (firstUseApp.isEmpty) {
        await Provider.of<UserProvider>(context, listen: false).sliderImages();
        Get.offNamed(SliderScreen.routeName);
      } else {
        Get.offNamed(HomeScreen.routeName);
      }

      //check for updates
      Map<String, dynamic> setting = await userProvider.getAppSetting();
      if (setting['setting'] != null) {
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        String buildNumber = packageInfo.buildNumber;
        print(buildNumber);
        if (Platform.isIOS &&
            int.parse(buildNumber) !=
                int.parse(setting['setting'].appleBuildNumber)) {
          print('ios');
          dialog();
        } else if (Platform.isAndroid &&
            int.parse(buildNumber) !=
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
          //LaunchReview.launch();
          LaunchReview.launch(
            androidAppId: 'com.menuegypt.menuegupt',
            iOSAppId: '1630657799',
            writeReview: false,
          );
        },
        onCancel: () async {},
        confirmTextColor: kTextColor,
        cancelTextColor: kTextColor);
  }
}
