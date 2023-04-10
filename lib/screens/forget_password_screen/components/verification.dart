import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/components/dialog.dart';
import 'package:menu_egypt/screens/forget_password_screen/components/change_password.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/widgets/BaseConnectivity.dart';
import 'package:provider/provider.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../components/app_bar.dart';
import '../../../components/default_button.dart';
import '../../../components/form_errors.dart';
import '../../../components/input_text_field.dart';
import '../../../components/loading_circle.dart';
import '../../../providers/user_provider.dart';
import '../../../utilities/size_config.dart';

class VerificationPasswordScreen extends StatefulWidget {
  static String routeName = '/verification_password';
  final String? email;

  const VerificationPasswordScreen({Key? key, this.email}) : super(key: key);

  @override
  State<VerificationPasswordScreen> createState() =>
      _VerificationPasswordScreenState();
}

class _VerificationPasswordScreenState
    extends State<VerificationPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? code;
  String email = Get.arguments as String;
  final List<String> errors = [];
  String message = '';
  final CountdownController timerController =
      CountdownController(autoStart: true);
  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error!);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  void _onSubmit() async {

    print(email);
    print(code);
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    final result = await Provider.of<UserProvider>(context, listen: false)
        .verifyPassword(widget.email!, code!);
    print(result);
    if (result['success']) {
      Get.offNamed(ChangePasswordScreen.routeName,
          arguments: [result['userId'], result['userToken']]);
    } else {
      AppDialog.infoDialog(context: context ,  title: "تنبية",message: result['error'] , btnTxt: "أغلاق");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    print(email) ;
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.all(getProportionateScreenHeight(16.0)) ,
                    child: AppBarWidget(
                      title: 'إرسال رمز التحقق الى الاميل',
                      withBack: true,
                    ),
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight !* 0.04,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(40.0)),
                      child: Image.asset('assets/images/menu-egypt-logo.png'),
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight !* 0.04,
                    ),
                    Padding(padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10.0)) ,
                    child: Text('من فضلك قم بإدخال رمز التحقق.',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: getProportionateScreenHeight(18.0))),
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight !* 0.04,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          InputTextField(
                            textInputType: TextInputType.number,
                            labelText: "رمز التحقق",
                            border: false,
                            iconPath: "assets/icons/mail.png",
                            onChanged: (String value) {
                              if (value.isNotEmpty) {
                                removeError(error: kCodeNullError);
                              }
                              print(value);
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
                      height: getProportionateScreenHeight(8)
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Countdown(
                            controller: timerController,
                            seconds: 60,
                            build: (BuildContext context, double time) {
                              return Text(time.toStringAsFixed(0));
                            },
                            onFinished: () {
                              setState(() {
                                message = 'إضغط هنا لإعادة إرسال الرمز';
                              });
                            },
                          ),
                        ),
                      ],
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
                    //resend
                    TextButton(
                      child: Text(
                        message,
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        setState(() {
                          message = '';
                          timerController.restart();
                        });
                        final result = await userProvider.forgetPassword(email);
                        if (result['success']) {
                          dialog(false, "قم بفحص البريد الخاص بك.");
                        } else {
                          dialog(true, result['error']);
                        }
                      },
                    ),
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
        title: checkError ? 'تنبيه' : '',
        buttonColor: checkError ? kPrimaryColor : Colors.green,
        cancelTextColor: kTextColor);
  }
}
