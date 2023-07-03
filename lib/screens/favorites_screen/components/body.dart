import 'package:flutter/material.dart';
import 'package:menu_egypt/components/app_bar.dart';
import 'package:menu_egypt/providers/restaurants_provider.dart';
import 'package:menu_egypt/providers/user_provider.dart';
import 'package:menu_egypt/screens/favorites_screen/components/restaurant_tile_widget.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final restaurants = Provider.of<RestaurantsProvider>(context, listen: false)
    //     .favoritesRestaurants;
    final userProvider = Provider.of<UserProvider>(context , listen: false);
    return Container(
      padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
      width: double.infinity,
      child: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: kDefaultPadding),
            child: AppBarWidget(
              title: "المفضلة",
              withBack: false,
            ),
          ),
          Text('',
              style: TextStyle(fontSize: getProportionateScreenHeight(10))),
             RestaurantTileWidget()

        ],
      )),
    );
  }
}


