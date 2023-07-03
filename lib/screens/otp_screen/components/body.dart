import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/components/app_bar.dart';
import 'package:menu_egypt/components/dialog.dart';
import 'package:menu_egypt/components/loading_circle.dart';
import 'package:menu_egypt/providers/user_provider.dart';
import 'package:menu_egypt/screens/forget_password_screen/components/forget_password_text.dart';
import 'package:menu_egypt/screens/home_screen/home_screen.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController otpController = TextEditingController();
  final CountdownController timerController =
      CountdownController(autoStart: true);
  String message = '';
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: true);

    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: getProportionateScreenHeight(2),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: AppBarWidget(
              title: 'إرسال رمز التحقق الى الاميل',
              withBack: true,
            ),
          ),

          SizedBox(
            height: SizeConfig.screenHeight! * 0.04,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(40.0)),
            child: Image.asset('assets/images/menu-egypt-logo.png'),
          ),
          SizedBox(
            height: SizeConfig.screenHeight! * 0.04,
          ),

          ForgetPasswordText(),

          //otp
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: Image.asset("assets/icons/mail.png" , scale: 3.6,),
                  contentPadding: const EdgeInsets.all(0.0),
                  hintText: 'رمز التحقق',
                  hintStyle: TextStyle(color: Colors.black),
                    enabledBorder:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                        borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)) ,
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                        borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),

                    focusedBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                        borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                        borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1))
                ),
              ),
            ),
          ),
          //timer
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Countdown(
              controller: timerController,
              seconds: 60,
              build: (BuildContext context, double time) {
                return Text(time.toString());
              },
              onFinished: () {
                setState(() {
                  message = 'إضغط هنا لإعادة إرسال الرمز';
                });
              },
            ),
          ),
          //submit btn
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: userProvider.isLoading
                ? LoadingCircle()
                : MaterialButton(
                    height: getProportionateScreenHeight(50),
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () async {
                      print(otpController.text);
                      if (otpController.text.isNotEmpty) {
                        var result = await Provider.of<UserProvider>(context,
                                listen: false)
                            .verifyWithOtp(otpController.text);
                        if (result['success']) {
                          AppDialog.infoDialog(message: result['msg'] , btnTxt: "اغلاق",title: "نبية"  ,context: context);
                          Get.offAllNamed(HomeScreen.routeName);
                        } else {
                          AppDialog.infoDialog(message: result['error'] , btnTxt: "اغلاق",title: "نبية"  ,context: context);
                        }
                      }
                    },
                    color: kAppBarColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'تأكيد رمز التحقق',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
          ),
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
              var result =
                  await Provider.of<UserProvider>(context, listen: false)
                      .resendOtp();
              if (result['success']) {
                AppDialog.infoDialog(message: result['msg'] , btnTxt: "اغلاق",title: "نبية"  ,context: context);

              } else {
                AppDialog.infoDialog(message: result['error'] , btnTxt: "اغلاق",title: "نبية"  ,context: context);

              }
            },
          ),
        ],
      ),
    );
  }

  // Future<void> dialog(String message) {
  //   return AppDialog.infoDialog(
  //     context: context,
  //     title: 'تنبيه',
  //     message: message,
  //     btnTxt: 'إغلاق',
  //   );
  // }
}
