import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/providers/categories_provider.dart';
import 'package:menu_egypt/providers/city_provider.dart';
import 'package:menu_egypt/providers/home_provider.dart';
import 'package:menu_egypt/providers/region_provider.dart';
import 'package:menu_egypt/providers/restaurants_provider.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
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
    Future.delayed(Duration(seconds: 1), () async {
      final UserProvider userProvider =
          Provider.of<UserProvider>(context, listen: false);

      final homeProvider = Provider.of<HomeProvider>(context ,listen: false) ;
      final categoryProvider =
      Provider.of<CategoriesProvider>(context, listen: false);
      final cityProvider = Provider.of<CityProvider>(context, listen: false);
      final regionProvider = Provider.of<RegionProvider>(context, listen: false);
      final resturantProvider =
      Provider.of<RestaurantsProvider>(context, listen: false);
      if (categoryProvider.categories.length < 1) {
        await categoryProvider.fetchCategories('guest');
      }
      if (cityProvider.cities.length < 1) {
        await cityProvider.fetchCities();
      }
      if (regionProvider.regions.length < 1) {
        await regionProvider.fetchRegions();
      }
      await homeProvider.fetchData();

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
        
        // Get.offNamed(SliderScreen.routeName).then((value) async {
        //   Map<String, dynamic> setting = await userProvider.getAppSetting();
        //   print(setting) ;
        //
        //   if (setting['setting'] != null) {
        //     PackageInfo packageInfo = await PackageInfo.fromPlatform();
        //     String buildNumber = packageInfo.buildNumber;
        //     print(buildNumber);
        //     if (Platform.isIOS &&
        //         int.parse(buildNumber) !=
        //             int.parse(setting['setting'].appleBuildNumber)) {
        //       print('ios');
        //       await versionDialog(message: 'إصدار جديد من التطبيق' ,  context: context);
        //     } else if (Platform.isAndroid &&
        //         int.parse(buildNumber) !=
        //             int.parse(setting['setting'].androidBuildNumber)) {
        //       print('android');
        //       await versionDialog(message: 'إصدار جديد من التطبيق' ,  context: context ,);
        //
        //     } else {
        //       print('something else');
        //     }
        //   }
        // });
        Map<String, dynamic> setting = await userProvider.getAppSetting();
        print(setting) ;

        if (setting['setting'] != null) {
          PackageInfo packageInfo = await PackageInfo.fromPlatform();
          String buildNumber = packageInfo.buildNumber;
          print(buildNumber);
          if (Platform.isIOS ||
              int.parse(buildNumber) !=
                  int.parse(setting['setting'].appleBuildNumber)) {
            print('ios');
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> HomeScreen()));
             versionDialog(message: 'إصدار جديد من التطبيق' ,  context: context);
          } else if (Platform.isAndroid ||
              int.parse(buildNumber) !=
                  int.parse(setting['setting'].androidBuildNumber)) {
            print('android');
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> HomeScreen()));
             versionDialog(message: 'إصدار جديد من التطبيق' ,  context: context ,);

          } else {
            print('something else');
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> HomeScreen()));
          }
        }

      } else {
        // Get.offNamed(HomeScreen.routeName).then((value) async {
        //   Map<String, dynamic> setting = await userProvider.getAppSetting();
        //   print(setting) ;
        //   if (setting['setting'] != null) {
        //     PackageInfo packageInfo = await PackageInfo.fromPlatform();
        //     String buildNumber = packageInfo.buildNumber;
        //     print(buildNumber);
        //     if (Platform.isIOS &&
        //         int.parse(buildNumber) !=
        //             int.parse(setting['setting'].appleBuildNumber)) {
        //       print('ios');
        //       await versionDialog(message: 'إصدار جديد من التطبيق' ,  context: context);
        //     } else if (Platform.isAndroid &&
        //         int.parse(buildNumber) !=
        //             int.parse(setting['setting'].androidBuildNumber)) {
        //       print('android');
        //       await versionDialog(message: 'إصدار جديد من التطبيق' ,  context: context ,);
        //
        //     } else {
        //       print('something else');
        //     }
        //   }
        // });
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> HomeScreen())) ;
        Map<String, dynamic> setting = await userProvider.getAppSetting();
        print(setting) ;

        if (setting['setting'] != null) {
          PackageInfo packageInfo = await PackageInfo.fromPlatform();
          String buildNumber = packageInfo.buildNumber;
          print(buildNumber);
          if (Platform.isIOS &&
              int.parse(buildNumber) !=
                  int.parse(setting['setting'].appleBuildNumber)) {
            print('ios');
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> HomeScreen()));
             versionDialog(message: 'إصدار جديد من التطبيق' ,  context: context);
          } else if (Platform.isAndroid &&
              int.parse(buildNumber) !=
                  int.parse(setting['setting'].androidBuildNumber)) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> HomeScreen()));
            print('android');
             versionDialog(message: 'إصدار جديد من التطبيق' ,  context: context ,);

          } else {
            print('something else');
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> HomeScreen()));

          }
        }
      }

      //check for updates

    });
    super.initState();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

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
  Future<void> versionDialog({String? message , BuildContext? context }){
    return PanaraConfirmDialog.showAnimatedGrow(context!,
        message: message!,
        textColor: Colors.black,
        color: kAppBarColor,
        confirmButtonText:'تحديث',
        cancelButtonText: 'تخطى',
        onTapConfirm: (){
          LaunchReview.launch(
            androidAppId: 'com.menuegypt.menuegupt',
            iOSAppId: '1630657799',
            writeReview: false,
          );
        },
        onTapCancel: (){
        Get.back() ;
        },
        panaraDialogType: PanaraDialogType.custom) ;
  }
}
