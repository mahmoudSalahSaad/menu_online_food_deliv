import 'package:flutter/material.dart';
import 'package:menu_egypt/utilities/constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        color: kPrimaryColor,
        child: Center(
          child: Image.asset('assets/images/menu-egypt-logo.png'),
        ),
      ),
    );
  }
}
