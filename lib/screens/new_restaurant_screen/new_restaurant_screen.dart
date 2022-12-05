import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/components/bottom_nav_bar_widget_new.dart';
import 'package:menu_egypt/components/loading_circle.dart';
import 'package:menu_egypt/providers/restaurants_provider.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/widgets/BaseConnectivity.dart';
import 'package:provider/provider.dart';

import 'components/body.dart';

class NewRestaurantScreen extends StatelessWidget {
  static String routeName = '/new_restaurant';
  int restId = Get.arguments[0];

  @override
  Widget build(BuildContext context) {
    final restaurantProvider =
        Provider.of<RestaurantsProvider>(context, listen: true);
    Provider.of<RestaurantsProvider>(context, listen: false)
        .fetchRestaurant(restId);
    return Container(
      decoration: BoxDecoration(gradient: kBackgroundColor),
      child: BaseConnectivity(
        child: Scaffold(
          body: restaurantProvider.isLoading ? LoadingCircle() : Body(),
          bottomNavigationBar: BottomNavBarWidgetNew(index: 0),
        ),
      ),
    );
  }
}
