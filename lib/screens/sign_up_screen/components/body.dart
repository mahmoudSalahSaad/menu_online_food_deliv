import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/components/app_bar.dart';
import 'package:menu_egypt/components/default_button.dart';
import 'package:menu_egypt/components/loading_circle.dart';
import 'package:menu_egypt/providers/city_provider.dart';
import 'package:menu_egypt/providers/region_provider.dart';
import 'package:menu_egypt/providers/user_provider.dart';
import 'package:menu_egypt/screens/home_screen/home_screen.dart';
import 'package:menu_egypt/screens/sign_up_screen/components/sign_up_form.dart';
import 'package:menu_egypt/screens/sign_in_screen/sign_in_screen.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'fullName': null,
    'password': null,
    'email': null,
    'phoneNumber': null,
    'cityId': null,
    'regionId': null
  };
  void onSubmit() async {
    if (!_formKey.currentState.validate() ||
        _formData['cityId'] == null ||
        _formData['regionId'] == null) {
      return;
    }
    _formKey.currentState.save();
    var result = await Provider.of<UserProvider>(context, listen: false)
        .signUp(_formData);
    if (result['success']) {
      Get.offAllNamed(HomeScreen.routeName);
    } else {
      dialog(result['error'].toString());
    }
  }

  @override
  void initState() {
    CityProvider cityProvider =
        Provider.of<CityProvider>(context, listen: false);
    _formData['cityId'] = cityProvider.cities[0].cityId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: true);
    final regionProvider = Provider.of<RegionProvider>(context, listen: false);
    CityProvider cityProvider =
        Provider.of<CityProvider>(context, listen: false);
    return SafeArea(
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(10.0),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppBarWidget(title: 'التسجيل'),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20.0)),
                  child: Image.asset('assets/images/menu-egypt-logo.png'),
                ),
                SizedBox(height: getProportionateScreenHeight(5.0)),
                SignUpForm(
                  formKey: _formKey,
                  formData: _formData,
                  cities: cityProvider.cities,
                  regions: regionProvider
                      .regionsOfCity(cityProvider.cities[0].cityId),
                  city: cityProvider.cities[0],
                  region: regionProvider
                      .regionsOfCity(cityProvider.cities[0].cityId)[0],
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                userProvider.isLoading
                    ? LoadingCircle()
                    : DefaultButton(
                        textColor: Colors.white,
                        onPressed: onSubmit,
                        child: Text('دخول'),
                        color: kPrimaryColor,
                        minWidth: 0.0,
                        height: 45.0),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('  لديك حساب؟ '),
                    GestureDetector(
                      onTap: () {
                        Get.offNamed(SignInScreen.routeName);
                      },
                      child: Text(
                        ' تسجيل الدخول ',
                        style: TextStyle(color: kPrimaryColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> dialog(String message) {
    return Get.defaultDialog(
        content: Text(message),
        textCancel: 'إغلاق',
        title: 'تحذير',
        buttonColor: kPrimaryColor,
        cancelTextColor: kTextColor);
  }
}
