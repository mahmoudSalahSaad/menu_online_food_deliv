import 'package:flutter/material.dart';
import 'package:menu_egypt/components/app_bar.dart';
import 'package:menu_egypt/providers/restaurants_provider.dart';
import 'package:menu_egypt/screens/filter_result_screen/components/restaurant_tile_widget.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final restaurants = Provider.of<RestaurantsProvider>(context, listen: true)
        .filterRestaurants;
    return Container(
      padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
      width: double.infinity,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: kDefaultPadding),
              child: AppBarWidget(title: "نتيجه البحث"),
            ),
            Text('',
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(10),
                )),
            restaurants.length > 0
                ? RestaurantTileWidget(restaurants: restaurants)
                : Expanded(
                    child: Center(
                      child: Text(
                          'ربمالايوجد مطاعم فى هذا القسم أو يوجد مشكلة فى الانترنت الخاص بك حاول مرة أخرى '),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
