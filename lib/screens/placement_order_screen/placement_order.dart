import 'package:flutter/material.dart';
import 'package:menu_egypt/components/bottom_nav_bar_widget_new.dart';
import 'package:menu_egypt/screens/placement_order_screen/components/body.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/widgets/BaseConnectivity.dart';

class PlacementOrder extends StatefulWidget {
  static String routeName = '/placement';

  @override
  State<PlacementOrder> createState() => _PlacementOrderState();
}

class _PlacementOrderState extends State<PlacementOrder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: kBackgroundColor),
      child: BaseConnectivity(
        child: Scaffold(
          body: Body(),
          bottomNavigationBar: BottomNavBarWidgetNew(index: 2),
        ),
      ),
    );
  }
}
