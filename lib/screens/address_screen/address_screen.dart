import 'package:flutter/material.dart';
import 'package:menu_egypt/screens/address_screen/components/body.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/widgets/BaseConnectivity.dart';

class AddressScreen extends StatelessWidget {
  static String routeName = '/address';
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
