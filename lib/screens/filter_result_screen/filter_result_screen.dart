import 'package:flutter/material.dart';
import 'package:menu_egypt/screens/filter_result_screen/components/body.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/widgets/BaseConnectivity.dart';

class FilterResultScreen extends StatelessWidget {
  static String routeName = '/filter_result_screen';
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
