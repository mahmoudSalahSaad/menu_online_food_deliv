import 'package:flutter/material.dart';
import 'package:menu_egypt/screens/sign_in_screen/components/body.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/widgets/BaseConnectivity.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = '/sign_in';
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: kBackgroundColor),
      child: Scaffold(
        body: BaseConnectivity(child: Body()),
      ),
    );
  }
}
