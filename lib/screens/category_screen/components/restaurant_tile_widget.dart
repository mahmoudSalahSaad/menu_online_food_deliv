import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/models/Restaurant.dart';
import 'package:menu_egypt/providers/restaurants_provider.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';

import '../../new_restaurant_screen/new_restaurant_screen.dart';

class RestaurantTileWidget extends StatelessWidget {
  const RestaurantTileWidget({
    Key? key,
     this.restaurants,
  }) : super(key: key);

  final List<RestaurantModel> ?restaurants;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      itemCount: restaurants!.length,
      itemBuilder: (BuildContext context, index) {
        return Column(
          children: [
            GestureDetector(
              onTap: () async {
                // await Provider.of<RestaurantsProvider>(context, listen: false)
                //     .restaurantImages(restaurants[index]);
                // await Provider.of<RestaurantsProvider>(context, listen: false)
                //     .addOneView(restaurants[index].id);
                // Get.toNamed(RestaurantScreen.routeName + "/$index/2/0");
                Provider.of<RestaurantsProvider>(context, listen: false)
                    .fetchRestaurant(restaurants![index].id!);
                Get.toNamed(NewRestaurantScreen.routeName);
              },
              child: ListTile(
                title: Text(restaurants![index].nameAr!),
                leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: FadeInImage.assetNetwork(
                        placeholder: "assets/icons/menu_egypt_logo.png",
                        image: '${restaurants![index].logoSmall}')),
                trailing: Icon(
                  FontAwesomeIcons.chevronLeft,
                  size: kDefaultPadding,
                ),
              ),
            ),
            index < restaurants!.length - 1
                ? Padding(
                    padding:
                        EdgeInsets.only(right: SizeConfig.screenWidth !* 0.24),
                    child: Divider(
                      color: kTextColor,
                    ),
                  )
                : Container()
          ],
        );
      },
    ));
  }
}
