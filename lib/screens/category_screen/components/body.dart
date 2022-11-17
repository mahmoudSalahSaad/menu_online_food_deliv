import 'package:flutter/material.dart';
import 'package:menu_egypt/components/app_bar.dart';
import 'package:menu_egypt/providers/restaurants_provider.dart';
import 'package:menu_egypt/screens/category_screen/components/restaurant_tile_widget.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final restaurants = Provider.of<RestaurantsProvider>(context, listen: false)
        .categoryRestaurants;
    return restaurants.length > 1
        ? Container(
            padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
            width: double.infinity,
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: kDefaultPadding),
                    child: AppBarWidget(
                      title: "",
                      withBack: true,
                    ),
                  ),
                  Text('',
                      style: TextStyle(
                        fontSize: SizeConfig.screenWidth * 0.09,
                      )),
                  RestaurantTileWidget(restaurants: restaurants)
                ],
              ),
            ),
          )
        : Container(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Center(
              child: Text(
                  'ربما لا يوجد مطاعم فى هذا القسم أو يوجد مشكلة فى الانترنت الخاص بك حاول مرة أخرى '),
            ),
          );
  }
}
