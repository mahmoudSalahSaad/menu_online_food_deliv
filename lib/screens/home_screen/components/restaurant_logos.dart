import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/models/Restaurant.dart';
import 'package:menu_egypt/providers/restaurants_provider.dart';
import 'package:menu_egypt/screens/new_restaurant_screen/new_restaurant_screen.dart';
import 'package:menu_egypt/services/http_service_impl.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';

class RestaurantLogos extends StatelessWidget {
  const RestaurantLogos({
    Key? key,
     this.restaurants,
  }) : super(key: key);

  final List<RestaurantModel>? restaurants;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((BuildContext context, index) {
        return Row(
          children: [
            GestureDetector(
                onTap: () async {
                  // await Provider.of<RestaurantsProvider>(context, listen: false)
                  //     .restaurantImages(restaurants[index]);
                  // await Provider.of<RestaurantsProvider>(context, listen: false)
                  //     .addOneView(restaurants[index].id);
                  // Get.toNamed(RestaurantScreen.routeName + '/$index/1/0');
                  Provider.of<RestaurantsProvider>(context, listen: false)
                      .fetchRestaurant(restaurants![index].id!);
                  Get.toNamed(NewRestaurantScreen.routeName);
                },
                child: Container(
                  height: getProportionateScreenWidth(50),
                  width: getProportionateScreenWidth(50),

                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xfF5F5F5)),
                    color: Color(0xffF5F5F5) ,
                    borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)) ,
        image:restaurants![index].logoSmall != null ? DecorationImage(image:
        NetworkImage('${restaurants![index].logoSmall}' , ) 
         
                  ) : DecorationImage(image: AssetImage("assets/images/menu-egypt-logo.png")),


                ) , 

                /*
              SizedBox(
                height: SizeConfig.screenHeight * 0.15,
                width: SizeConfig.screenWidth * 0.15,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: FadeInImage.assetNetwork(
                        fit: BoxFit.contain,
                        placeholder: "assets/icons/menu_egypt_logo.png",
                        image: '${restaurants[index].logoSmall}')),
              ),
              */
                ),)
          ],
        );
      }, childCount: restaurants!.length),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: kDefaultPadding / 2,
          mainAxisSpacing: kDefaultPadding / 2),
    );
  }
}
