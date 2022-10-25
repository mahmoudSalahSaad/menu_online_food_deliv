import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/components/app_bar.dart';
import 'package:menu_egypt/components/default_button.dart';
import 'package:menu_egypt/components/loading_circle.dart';
import 'package:menu_egypt/providers/user_provider.dart';
import 'package:menu_egypt/screens/forget_password_screen/components/forget_password_form.dart';
import 'package:menu_egypt/screens/forget_password_screen/components/forget_password_text.dart';
import 'package:menu_egypt/screens/forget_password_screen/components/verification.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'email': null,
  };

  void _onSubmit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    final result = await Provider.of<UserProvider>(context, listen: false)
        .forgetPassword(_formData['email']);
    if (result['success']) {
      await dialog(false, "قم بفحص البريد الخاص بك.");
      Get.toNamed(VerificationPasswordScreen.routeName);
    } else {
      if (result['error']
          .toString()
          .contains('برجاء أختيار البريد الإلكتروني')) {
        dialog(true, 'برجاء ادخال بريد الكترونى او رقم هاتف صحيح');
      } else if (result['error']
          .toString()
          .contains('هذا المستخدم غير موجود')) {
        dialog(true, 'هذا المستخدم غير موجود');
      } else {
        dialog(true, 'حدث خطا ما ');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: true);
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(10.0),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBarWidget(title: 'نسيت كلمة السر'),
              SizedBox(
                height: SizeConfig.screenHeight * 0.04,
              ),
              ForgetPasswordText(),
              SizedBox(
                height: SizeConfig.screenHeight * 0.04,
              ),
              ForgetPasswordForm(
                formData: _formData,
                formKey: _formKey,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.04,
              ),
              userProvider.isLoading
                  ? LoadingCircle()
                  : DefaultButton(
                      textColor: Colors.white,
                      onPressed: _onSubmit,
                      child: Text('أرسل'),
                      color: kPrimaryColor,
                      minWidth: 0.0,
                      height: 45.0),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> dialog(bool checkError, String message) {
    return Get.defaultDialog(
        content: Text(message),
        textCancel: checkError ? 'إغلاق' : 'استمرار',
        title: checkError ? 'تحذير' : '',
        buttonColor: checkError ? kPrimaryColor : Colors.green,
        cancelTextColor: kTextColor);
  }
}
