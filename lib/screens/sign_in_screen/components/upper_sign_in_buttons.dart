import 'package:flutter/material.dart';
import 'package:get/get.dart';

/*
import 'package:menu_egypt/providers/user_provider.dart';
import 'package:menu_egypt/screens/home_screen/home_screen.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';
*/
class UpperSignInButtons extends StatelessWidget {
  const UpperSignInButtons({
    Key key,
  }) : super(key: key);

  /*
  void _onSubmitSocailButton(String social, BuildContext context) async {
    Map<String, dynamic> result =
        await Provider.of<UserProvider>(context, listen: false)
            .signInWithSocialMedia(social);
    if (result['success']) {
      // var resturantResult =
      //     await Provider.of<RestaurantsProvider>(context, listen: false)
      //         .fetchMostViewsRestaurants('guest');
      // if (resturantResult['success']) {
      //   Get.offAllNamed(HomeScreen.routeName);
      // } else {
      //   dialog('حدث خطأ ما حاول مرة اخرى لاحقاً.');
      // }
      Get.offAllNamed(HomeScreen.routeName);
    } else {
      if (result['error'] != null) {
        if (result['error'].toString().contains(kNetworkFieldCond) ||
            result['error'].toString().contains(kNetworkPlatFormFieldCond)) {
          dialog(kNetworkFieldMessage);
        } else if (result['error'].toString().contains('email')) {
          dialog('هذا البريد الالكترونى موجود مسبقاً.');
        } else {
          dialog('حدث خطأ ما حاول مرة اخرى لاحقاً.');
        }
      }
    }
  }
  */

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /*GestureDetector(
            onTap: () => _onSubmitSocailButton('Fb', context),
            child: Image.asset(
              'assets/icons/facebook.png',
              width: getProportionateScreenWidth(60.0),
            )),
        SizedBox(
          width: SizeConfig.screenWidth * 0.02,
        ),
        GestureDetector(
            onTap: () => _onSubmitSocailButton('', context),
            child: Image.asset(
              'assets/icons/google_icon.png',
              width: getProportionateScreenWidth(60.0),
            )),*/
      ],
    );
  }

  void dialog(String message) {
    Get.defaultDialog(
        content: Text(message), textCancel: 'إغلاق', title: 'تنبيه');
  }
}
