import 'package:flutter/material.dart';
import 'package:menu_egypt/screens/forget_password_screen/components/body.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/widgets/BaseConnectivity.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static String routeName = '/forget_password';
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: kBackgroundColor),
      child: BaseConnectivity(
        child: Scaffold(
          body: Body(),
        ),
      ),
    );
  }
}
