import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/components/app_bar.dart';
import 'package:menu_egypt/components/loading_circle.dart';
import 'package:menu_egypt/providers/city_provider.dart';
import 'package:menu_egypt/providers/region_provider.dart';
import 'package:menu_egypt/providers/user_provider.dart';
import 'package:menu_egypt/screens/address_screen/address_screen.dart';
import 'package:menu_egypt/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:menu_egypt/screens/favorites_screen/favorites_screen.dart';
import 'package:menu_egypt/screens/orders_screen/my_orders.dart';
import 'package:menu_egypt/screens/profile_screen/components/text_icon_widget.dart';
import 'package:menu_egypt/screens/sign_in_screen/sign_in_screen.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String city;
  String region;
  void onSubmit() async {
    Get.defaultDialog(
      title: 'تسجيل الخروج',
      content: LoadingCircle(),
    );
    var result =
        await Provider.of<UserProvider>(context, listen: false).signOut();
    if (result['success']) {
      Get.offAllNamed(SignInScreen.routeName);
    } else {
      dialog('حدث خطأ ما حاول مرة اخرى لاحقاً.', 'تنبيه');
    }
  }

  @override
  void initState() {
    final cities = Provider.of<CityProvider>(context, listen: false).cities;
    final regions = Provider.of<RegionProvider>(context, listen: false).regions;
    if (city == null) {
      Provider.of<UserProvider>(context, listen: false).fetchUserCity(cities);
      city = Provider.of<UserProvider>(context, listen: false).userCity;
    }
    if (region == null) {
      Provider.of<UserProvider>(context, listen: false)
          .fetchUserRegion(regions);
      region = Provider.of<UserProvider>(context, listen: false).userRegion;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return SafeArea(
        child: Container(
            padding: EdgeInsets.all(kDefaultPadding),
            child: CustomScrollView(slivers: [
              SliverList(
                  delegate: SliverChildListDelegate([
                AppBarWidget(
                  title: 'حسابى',
                  withBack: false,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                CircleAvatar(
                  radius: 50,
                  child: ClipOval(
                    child: Image.asset("assets/images/profile.jpg"),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                Text(
                  userProvider.user.fullName,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(14),
                  ),
                ),
                Text(
                  userProvider.user.email,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(14),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                TextIconWidget(
                  text: 'معلومات الحساب',
                  icon: Icons.person,
                  onTap: () {
                    Get.toNamed(ProfileEditScreen.routeName);
                  },
                ),
                TextIconWidget(
                  text: 'طلباتى',
                  icon: Icons.list,
                  onTap: () {
                    Get.toNamed(MyOrders.routeName);
                  },
                ),
                TextIconWidget(
                  text: 'العناوين',
                  icon: Icons.location_pin,
                  onTap: () {
                    Get.toNamed(AddressScreen.routeName);
                  },
                ),
                TextIconWidget(
                  text: 'المفضلة',
                  icon: Icons.favorite,
                  onTap: () {
                    Get.toNamed(FavoritesScreen.routeName);
                  },
                ),
                TextIconWidget(
                  text: 'معلومات عنا',
                  icon: Icons.info,
                  onTap: () {
                    dialog('info@menuegypt.com - 01116618752',
                        'لديك اقتراح أو طلب مساعدة يمكنكم التواصل معنا عبر');
                  },
                ),
                TextIconWidget(
                    text: 'الخروج من التطبيق',
                    icon: FontAwesomeIcons.rightFromBracket,
                    onTap: () {
                      onSubmit();
                    }),
              ])),
            ])));
  }

  void dialog(String message, String title) {
    Get.defaultDialog(
        content: SelectableText(message),
        textCancel: 'إغلاق',
        title: title,
        buttonColor: kPrimaryColor,
        cancelTextColor: kTextColor);
  }
}
