import 'package:flutter/material.dart';
import 'package:menu_egypt/components/bottom_nav_bar_widget_new.dart';
import 'package:menu_egypt/screens/profile_screen/components/body.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/widgets/BaseConnectivity.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = '/profile';
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: BaseConnectivity(
        child: Scaffold(
          body: Body(),
          bottomNavigationBar: BottomNavBarWidgetNew(index: 4),
        ),
      ),
    );
  }
}
