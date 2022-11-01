import 'package:flutter/material.dart';
import 'package:menu_egypt/components/bottom_nav_bar_widget_new.dart';
import 'package:menu_egypt/components/loading_circle.dart';
import 'package:menu_egypt/providers/resturant_items_provider.dart';
import 'package:menu_egypt/screens/new_restaurant_screen/components/body_new.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/widgets/BaseConnectivity.dart';
import 'package:provider/provider.dart';

class ResturantScreenNew extends StatelessWidget {
  static String routeName = '/restaurant_new';

  @override
  Widget build(BuildContext context) {
    final restaurantProvider =
        Provider.of<ResturantItemsProvider>(context, listen: true);
    return Container(
      decoration: BoxDecoration(gradient: kBackgroundColor),
      child: BaseConnectivity(
        child: Scaffold(
          body: restaurantProvider.isLoading ? LoadingCircle() : BodyNew(),
          bottomNavigationBar: BottomNavBarWidgetNew(index: 0),
        ),
      ),
    );
  }
}
