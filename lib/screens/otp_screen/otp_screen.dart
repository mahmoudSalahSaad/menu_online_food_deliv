import 'package:flutter/material.dart';
import 'package:menu_egypt/screens/otp_screen/components/body.dart';
import 'package:menu_egypt/utilities/constants.dart';

class OtpScreen extends StatelessWidget {
  static String routeName = '/otp';
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: kBackgroundColor),
      child: Scaffold(
        body: Body(),
      ),
    );
  }
}
