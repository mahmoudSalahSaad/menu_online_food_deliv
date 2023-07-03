import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/components/loading_circle.dart';
import 'package:menu_egypt/models/Restaurant.dart';
import 'package:menu_egypt/providers/restaurants_provider.dart';
import 'package:menu_egypt/providers/user_provider.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';

import '../../new_restaurant_screen/new_restaurant_screen.dart';

class RestaurantTileWidget extends StatelessWidget {
  const RestaurantTileWidget({
    Key? key,

  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context , listen: false) ;
    return Expanded(
        child: FutureProvider<Map<String , dynamic>>
          (
            create: (_)=> userProvider.userFav(),
            initialData: const {},
            child: Consumer<Map<String , dynamic>>(
              builder: (_,value,__){
                if(value.isEmpty){
                  return LoadingCircle() ;
                }else{
                  return userProvider.faves.isNotEmpty?
                  ListView.builder(
                    itemCount: userProvider.faves.length,
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
                                  .fetchRestaurant(userProvider.faves[index].id!);
                              Get.toNamed(NewRestaurantScreen.routeName);
                            },
                            child: ListTile(
                              title: Text(userProvider.faves[index].name! , style: TextStyle(
                                  color: Color(0xff222222) ,
                                  fontSize: 18 ,
                                  height: 2.0
                              ),),
                              leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: FadeInImage.assetNetwork(
                                      placeholder: "assets/icons/menu_egypt_logo.png",
                                      image: 'https://menuegypt.com/${userProvider.faves[index].image}')),
                              trailing: Icon(
                                FontAwesomeIcons.chevronLeft,
                                size: kDefaultPadding,
                                color: Colors.black,
                              ),
                            ),
                          ),

                          index < userProvider.faves.length - 1
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
                  ) : SizedBox(
                    height: getProportionateScreenHeight(600),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(kDefaultPadding),
                        child: Text(
                          'ربما لايوجد مطاعم مفضلة أو يوجد مشكلة فى الانترنت الخاص بك حاول مرة أخرى ' , style:  TextStyle(
                            color: Colors.black
                        ),),
                      ),
                    ),
                  ) ;
                }
              },
            ),
          ));
  }
}




