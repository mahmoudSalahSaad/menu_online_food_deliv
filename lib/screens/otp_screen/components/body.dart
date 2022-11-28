import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/components/app_bar.dart';
import 'package:menu_egypt/components/loading_circle.dart';
import 'package:menu_egypt/providers/user_provider.dart';
import 'package:menu_egypt/screens/home_screen/home_screen.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

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
                  contentPadding: const EdgeInsets.all(16.0),
                  hintText: 'رمز التحقق',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
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
                          dialog('done');
                          Get.offAllNamed(HomeScreen.routeName);
                        } else {
                          dialog(result['error'].toString());
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
                dialog('تم ارسال رمز التحقق');
              } else {
                dialog(result['error'].toString());
              }
            },
          ),
        ],
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
