import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/screens/forget_password_screen/components/change_password.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/widgets/BaseConnectivity.dart';
import 'package:provider/provider.dart';

import '../../../components/app_bar.dart';
import '../../../components/default_button.dart';
import '../../../components/form_errors.dart';
import '../../../components/input_text_field.dart';
import '../../../components/loading_circle.dart';
import '../../../providers/user_provider.dart';
import '../../../utilities/size_config.dart';

class VerificationPasswordScreen extends StatefulWidget {
  static String routeName = '/verification_password';

  @override
  State<VerificationPasswordScreen> createState() =>
      _VerificationPasswordScreenState();
}

class _VerificationPasswordScreenState
    extends State<VerificationPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String code;
  String email = Get.arguments as String;
  final List<String> errors = [];

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

  void _onSubmit() async {
    print(email);
    print(code);
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    final result = await Provider.of<UserProvider>(context, listen: false)
        .verifyPassword(email, code);
    if (result['success']) {
      Get.offNamed(ChangePasswordScreen.routeName,
          arguments: [result['userId'], result['userToken']]);
    } else {
      dialog(true, result['error']);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: true);

    return Container(
      decoration: BoxDecoration(gradient: kBackgroundColor),
      child: BaseConnectivity(
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(10.0),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AppBarWidget(title: 'كود التحقيق'),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.04,
                    ),
                    Text('من فضلك قم بإدخال كود التحقيق.',
                        style: Theme.of(context).textTheme.headline5.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: getProportionateScreenHeight(14.0))),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.04,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          InputTextField(
                            textInputType: TextInputType.emailAddress,
                            labelText: "كود التحقيق",
                            border: false,
                            onChanged: (String value) {
                              if (value.isNotEmpty) {
                                removeError(error: kCodeNullError);
                              }
                              return null;
                            },
                            validator: (String value) {
                              if (value.isEmpty) {
                                addError(error: kCodeNullError);
                                return "";
                              }
                              return null;
                            },
                            onSaved: (String value) {
                              code = value;
                            },
                          ),
                          FormErrors(errors: errors),
                        ],
                      ),
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
                            height: getProportionateScreenHeight(45)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void dialog(bool checkError, String message) {
    Get.defaultDialog(
        content: Text(message),
        textCancel: checkError ? 'إغلاق' : 'استمرار',
        title: checkError ? 'تحذير' : '',
        buttonColor: checkError ? kPrimaryColor : Colors.green,
        cancelTextColor: kTextColor);
  }
}
