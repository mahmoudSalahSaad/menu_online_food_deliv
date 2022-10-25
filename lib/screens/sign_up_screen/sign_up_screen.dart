import 'package:flutter/material.dart';
import 'package:menu_egypt/screens/sign_up_screen/components/body.dart';
import 'package:menu_egypt/utilities/constants.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = '/sign_up';
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
