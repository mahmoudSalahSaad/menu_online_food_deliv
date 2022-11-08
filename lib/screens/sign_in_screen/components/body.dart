import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/components/default_button.dart';
import 'package:menu_egypt/components/loading_circle.dart';
import 'package:menu_egypt/providers/categories_provider.dart';
import 'package:menu_egypt/providers/restaurants_provider.dart';
import 'package:menu_egypt/providers/user_provider.dart';
import 'package:menu_egypt/screens/forget_password_screen/forget_password_screen.dart';
import 'package:menu_egypt/screens/home_screen/home_screen.dart';
import 'package:menu_egypt/screens/otp_screen/otp_screen.dart';
import 'package:menu_egypt/screens/sign_in_screen/components/sign_in_form.dart';
import 'package:menu_egypt/screens/sign_up_screen/sign_up_screen.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  final Map<String, dynamic> _formData = {
    'email': null,
  };
  void onSubmit(bool guest) async {
    if (guest) {
      Get.toNamed(HomeScreen.routeName);
    } else {
      if (!_formKey.currentState.validate()) {
        return;
      }
      _formKey.currentState.save();
      var result = await Provider.of<UserProvider>(context, listen: false)
          .signIn(_formData);
      if (result['success'] && result['verified'] == 1) {
        Get.offAllNamed(HomeScreen.routeName);
      } else if (result['verified'] == 0) {
        Get.offAllNamed(OtpScreen.routeName);
      } else {
        dialog(result['error'].toString());
      }
    }
  }

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: true);
    final categoryProvider =
        Provider.of<CategoriesProvider>(context, listen: true);
    final restaurantProvider =
        Provider.of<RestaurantsProvider>(context, listen: true);
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
                Padding(
                  padding: EdgeInsets.all(getProportionateScreenWidth(20.0)),
                  child: Image.asset('assets/images/menu-egypt-logo.png'),
                ),
                SizedBox(height: getProportionateScreenHeight(20.0)),
                SignInForm(
                  formKey: _formKey,
                  formData: _formData,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                userProvider.isLoading ||
                        categoryProvider.isLoading ||
                        restaurantProvider.isLoading
                    ? LoadingCircle()
                    : DefaultButton(
                        textColor: Colors.white,
                        onPressed: () => onSubmit(false),
                        child: Text('تسجيل الدخول'),
                        color: kPrimaryColor,
                        minWidth: 0.0,
                        height: 45.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(ForgetPasswordScreen.routeName);
                    },
                    child: Text('هل نسيت كلمة السر؟'),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                Text('يمكنك الدخول عن طريق حسابات'),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                //UpperSignInButtons(),
                SizedBox(height: SizeConfig.screenHeight * 0.12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(' ليس لديك حساب؟ '),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(SignUpScreen.routeName);
                      },
                      child: Text(
                        ' اشتراك ',
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

  void dialog(String message) {
    Get.defaultDialog(
        content: Text(message),
        textCancel: 'إغلاق',
        title: 'تحذير',
        buttonColor: kPrimaryColor,
        cancelTextColor: kTextColor);
  }
}
