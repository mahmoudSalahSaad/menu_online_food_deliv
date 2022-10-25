import 'package:flutter/material.dart';
import 'package:menu_egypt/screens/category_screen/components/body.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/widgets/BaseConnectivity.dart';

class CategoryScreen extends StatelessWidget {
  static String routeName = '/category_screen';
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
