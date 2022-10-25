import 'package:flutter/material.dart';
import 'package:menu_egypt/components/bottom_nav_bar_widget_new.dart';
import 'package:menu_egypt/screens/favorites_screen/components/body.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/widgets/BaseConnectivity.dart';

class FavoritesScreen extends StatelessWidget {
  static String routeName = '/favorites_screen';
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: kBackgroundColor),
      child: BaseConnectivity(
        child: Scaffold(
          body: Body(),
          bottomNavigationBar: BottomNavBarWidgetNew(index: 3),
        ),
      ),
    );
  }
}
