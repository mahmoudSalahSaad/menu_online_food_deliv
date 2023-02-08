import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/components/dialog.dart';
import 'package:menu_egypt/screens/home_screen/home_screen.dart';
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

class ChangePasswordScreen extends StatefulWidget {
  static String routeName = '/change_password';

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String password;
  int userId = Get.arguments[0];
  String userToken = Get.arguments[1];
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
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
    print(userId);
    print(userToken);
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    final result = await Provider.of<UserProvider>(context, listen: false)
        .changePassword(userId, userToken, password);
    if (result['success']) {
      await AppDialog.infoDialog(message: 'تم تغيير كلمة المرور بنجاح' , btnTxt: "استمر" ,context: context , title: "نجاح");
      Get.offAllNamed(HomeScreen.routeName);
    } else {
      if (result['error'].toString().contains('برجاء أختيار مستخدم')) {
        AppDialog.infoDialog(context: context , title: "تنبية",message: 'برجاء أختيار مستخدم' , btnTxt: "أغلاق") ;
      } else if (result['error']
          .toString()
          .contains('برجاء أختيار  كلمة المرور')) {
        AppDialog.infoDialog(context: context , title: "تنبية",message: 'برجاء أختيار  كلمة المرور' , btnTxt: "أغلاق") ;

      } else if (result['error']
          .toString()
          .contains('هذا المستخدم غير موجود')) {
        AppDialog.infoDialog(context: context , title: "تنبية",message: 'هذا المستخدم غير موجود' , btnTxt: "أغلاق") ;

      } else {
        AppDialog.infoDialog(context: context , title: "تنبية",message: 'حدث خطا ما ' , btnTxt: "أغلاق") ;

      }
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
                    AppBarWidget(
                      title: 'تغيير الرقم السرى',
                      withBack: true,
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.04,
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.04,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          InputTextField(
                            controller: _pass,
                            textInputType: TextInputType.text,
                            labelText: "الرقم السرى",
                            border: false,
                            obscure: true,
                            onChanged: (String value) {
                              if (value.isNotEmpty) {
                                if (value.length > 5) {
                                  removeError(error: kShortPassError);
                                }
                              }
                              return null;
                            },
                            validator: (String value) {
                              if (value.isNotEmpty) {
                                if (value.length <= 5) {
                                  addError(error: kShortPassError);
                                  return "";
                                }
                              }
                              return null;
                            },
                            onSaved: (String value) {
                              password = value;
                            },
                          ),
                          InputTextField(
                            controller: _confirmPass,
                            textInputType: TextInputType.text,
                            labelText: "تأكيد الرقم السرى",
                            border: false,
                            obscure: true,
                            onChanged: (String value) {
                              if (value.isNotEmpty) {
                                if (value == _pass.text) {
                                  removeError(error: kNewConfimPassError);
                                }
                              }

                              return null;
                            },
                            validator: (String value) {
                              if (value.isEmpty) {
                                addError(error: kNewConfimPassError);
                                return "";
                              }
                              if (value != _pass.text) {
                                addError(error: kNewConfimPassError);
                                return "";
                              }
                              return null;
                            },
                            onSaved: (String value) {},
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

  // Future<void> dialog(bool checkError, String message) {
  //   return Get.defaultDialog(
  //       content: Text(message),
  //       textCancel: checkError ? 'إغلاق' : 'استمرار',
  //       title: checkError ? 'تنبيه' : '',
  //       buttonColor: checkError ? kPrimaryColor : Colors.green,
  //       cancelTextColor: kTextColor);
  // }
}
