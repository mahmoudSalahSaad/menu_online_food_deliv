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
    @required this.restaurants,
  }) : super(key: key);

  final List<RestaurantModel>? restaurants;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      itemCount: restaurants!.length,
      itemBuilder: (BuildContext context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                // await Provider.of<RestaurantsProvider>(context, listen: false)
                //     .restaurantImages(restaurants[index]);
                // Get.toNamed(RestaurantScreen.routeName + "/$index/4/0");
                Provider.of<RestaurantsProvider>(context, listen: false)
                    .fetchRestaurant(restaurants![index].id!);
                Get.toNamed(NewRestaurantScreen.routeName);
              },
              child: ListTile(
                title: Text(restaurants![index].nameAr! , style: TextStyle(
                  color: Color(0xff222222) ,
                  fontSize: 18 ,
                  height: 2.0
                ),),
                leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: FadeInImage.assetNetwork(
                        placeholder: "assets/icons/menu_egypt_logo.png",
                        image: '${restaurants![index].logoSmall}')),
                trailing: Icon(
                  FontAwesomeIcons.chevronLeft,
                  size: kDefaultPadding,
                  color: Colors.black,
                ),
              ),
            ),

            index < restaurants!.length - 1
                ? Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth !* 0.05),
                    child: Divider(
                      color: Colors.black.withOpacity(0.1),
                    ),
                  )
                : Container()
          ],
        );
      },
    ));
  }
}
