import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/components/app_bar.dart';
import 'package:menu_egypt/components/dialog.dart';
import 'package:menu_egypt/components/loading_circle.dart';
import 'package:menu_egypt/main.dart';
import 'package:menu_egypt/providers/city_provider.dart';
import 'package:menu_egypt/providers/region_provider.dart';
import 'package:menu_egypt/providers/user_provider.dart';
import 'package:menu_egypt/screens/address_screen/address_screen.dart';
import 'package:menu_egypt/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:menu_egypt/screens/favorites_screen/favorites_screen.dart';
import 'package:menu_egypt/screens/orders_screen/my_orders.dart';
import 'package:menu_egypt/screens/profile_screen/chat_with_us.dart';
import 'package:menu_egypt/screens/profile_screen/components/text_icon_widget.dart';
import 'package:menu_egypt/screens/profile_screen/info_screen.dart';
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
  String? city;
  String? region;
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppBarWidget(
                    title: 'حسابى',
                    withBack: false,
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight !* 0.04,
                  ),
                  CircleAvatar(
                    radius: 50,
                    child: ClipOval(
                      child: userProvider.user!.gender == "male" ?  Image.asset("assets/icons/Ellipse 16.png") : Image.asset("assets/icons/worker-woman-svgrepo-com.png"),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight! * 0.02,
                  ),
                  Text(
                    userProvider.user!.fullName!,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(18),
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),
                  ),
                  Text(
                    userProvider.user!.email!,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(14),
                        color: Colors.black
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight! * 0.04,
                  ),
                  TextIconWidget(
                    text: 'معلومات الحساب',
                    icon: "assets/icons/Group 1000000781.png",
                    onTap: () {
                      Get.toNamed(ProfileEditScreen.routeName);
                    },
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(330),
                    child: Divider(
                      color: Color(0xff222222).withOpacity(0.1),


                    ),
                  ),

                  TextIconWidget(
                    text: 'طلباتى',
                    icon: "assets/icons/Group 1000000724.png",
                    onTap: () {
                      Get.toNamed(MyOrders.routeName);
                    },
                  ),

                  SizedBox(
                    width: getProportionateScreenWidth(330),
                    child: Divider(
                      color: Color(0xff222222).withOpacity(0.1),
                      thickness: 1,


                    ),
                  ),
                  TextIconWidget(
                    text: 'العناوين',
                    icon: "assets/icons/location.png",
                    onTap: () {
                      Get.toNamed(AddressScreen.routeName);
                    },
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(330),
                    child: Divider(
                      color: Color(0xff222222).withOpacity(0.1),
                      thickness: 1,


                    ),
                  ),
                  TextIconWidget(
                    text: 'المفضلة',
                    icon: "assets/icons/Group 1000000723 (2).png",
                    onTap: () {
                      Get.toNamed(FavoritesScreen.routeName);
                    },
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(330),
                    child: Divider(
                      color: Color(0xff222222).withOpacity(0.1),
                      thickness: 1,


                    ),
                  ),
                  TextIconWidget(
                    text: 'الدعم',
                    icon: "assets/icons/Group 1000000899.png",
                    onTap: () {
                      Get.off(()=> ChatWithUs() ) ;
                    },
                  ),

                  SizedBox(
                    width: getProportionateScreenWidth(330),
                    child: Divider(
                      color: Color(0xff222222).withOpacity(0.1),
                      thickness: 1,

                    ),
                  ),
                  TextIconWidget(
                    text: 'معلومات عنا',
                    icon: "assets/icons/info-circle.png",
                    onTap: () {
                            Get.off(()=> InfoScreen()) ;
                    },
                  ),

                  SizedBox(
                    width: getProportionateScreenWidth(330),
                    child: Divider(
                      thickness: 1,
                      color: Color(0xff222222).withOpacity(0.1),


                    ),
                  ),
                  TextIconWidget(
                      signOut: true,
                      text: 'الخروج من التطبيق',
                      icon: "assets/icons/Group 1000000820.png",
                      onTap: () {
                        onSubmit();
                      }),
                  SizedBox(
                    width: getProportionateScreenWidth(330),
                    child: Divider(
                      color: Color(0xff222222).withOpacity(0.1),
                      thickness: 1,

                    ),
                  ),
                  
                  Text("$version")
                ],
              ),
            )));
  }

  void dialog(String message, String title) {
    AppDialog.infoDialog(
      context: context,
      title: title,
      message: message,
      btnTxt: 'إغلاق',
    );
  }
}
