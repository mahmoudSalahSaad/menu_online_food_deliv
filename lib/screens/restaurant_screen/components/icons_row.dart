// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:menu_egypt/models/Restaurant.dart';
// import 'package:menu_egypt/providers/city_provider.dart';
// import 'package:menu_egypt/providers/region_provider.dart';
// import 'package:menu_egypt/providers/restaurants_provider.dart';
// import 'package:menu_egypt/providers/user_provider.dart';
// import 'package:menu_egypt/screens/restaurant_screen/components/text_icon_widget.dart';
// import 'package:menu_egypt/utilities/constants.dart';
// import 'package:menu_egypt/utilities/size_config.dart';
// import 'package:provider/provider.dart';
//
// class IconsRow extends StatelessWidget {
//   const IconsRow({
//     Key key,
//     @required this.restaurants,
//     @required this.restaurantProvider,
//     @required this.userProvider,
//     @required this.isFav,
//     @required this.onTap,
//     @required this.restaurantIndex,
//   }) : super(key: key);
//
//   final List<RestaurantModel> restaurants;
//   final RestaurantsProvider restaurantProvider;
//   final UserProvider userProvider;
//   final bool isFav;
//   final int restaurantIndex;
//   final Function onTap;
//   @override
//   Widget build(BuildContext context) {
//     return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//       TextIconWidget(
//         fav: false,
//         text: '',
//         icon: FontAwesomeIcons.locationArrow,
//         onTap: () async {
//           if (restaurants[restaurantIndex].areas.length < 1) {
//             await restaurantProvider
//                 .restaurantRegions(restaurants[restaurantIndex]);
//
//             restaurants[restaurantIndex].areas = filterRestaurantAreas(
//                 context, restaurants[restaurantIndex].regions);
//             dialog(restaurants[restaurantIndex].areas, 'المناطق');
//           } else {
//             dialog(restaurants[restaurantIndex].areas, 'المناطق');
//           }
//         },
//       ),
//       SizedBox(
//         width: SizeConfig.screenWidth * 0.02,
//       ),
//       TextIconWidget(
//         fav: false,
//         text: '',
//         icon: FontAwesomeIcons.locationDot,
//         onTap: () async {
//           if (restaurants[restaurantIndex].branches.length < 1) {
//             await restaurantProvider
//                 .restaurantBranches(restaurants[restaurantIndex]);
//
//             //dialog(restaurants[restaurantIndex].branches, 'الفروع');
//           } else {
//             //dialog(restaurants[restaurantIndex].branches, 'الفروع');
//           }
//         },
//       ),
//       userProvider.user != null
//           ? TextIconWidget(
//               fav: true,
//               text: '',
//               icon:
//                   isFav ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
//               onTap: onTap)
//           : Container(),
//     ]);
//   }
//
//   List<String> filterRestaurantAreas(context, List<int> regionsIds) {
//     var cities = Provider.of<CityProvider>(context, listen: false).cities;
//     var regions = Provider.of<RegionProvider>(context, listen: false).regions;
//     List<String> restaurantAreas = [];
//     regions.forEach((region) {
//       if (regionsIds.contains(region.regionId)) {
//         var city = cities.firstWhere((city) {
//           return city.cityId == region.cityId;
//         });
//
//         String regionCity = city.nameAr + " - " + region.nameAr;
//         restaurantAreas.add(regionCity);
//       }
//     });
//     return restaurantAreas;
//   }
//
//   void dialog(List<String> list, String title) {
//     Get.defaultDialog(
//         title: title,
//         content: list.length > 1
//             ? Container(
//                 width: SizeConfig.screenWidth * 0.8,
//                 height: SizeConfig.screenHeight * 0.5,
//                 child: ListView.builder(
//                     itemCount: list.length,
//                     itemBuilder: (BuildContext context, index) {
//                       return Text(list[index],
//                           style: TextStyle(
//                               fontSize: SizeConfig.screenWidth * 0.04));
//                     }),
//               )
//             : Center(
//                 child: Text(
//                   'ربما لا يوجد فروع لهذا المطعم او ربما يوجد مشكلة فى الانترنت الخاص بك حاول مرة اخرى لاحقا',
//                   maxLines: 3,
//                 ),
//               ),
//         textCancel: 'اغلاق',
//         buttonColor: kPrimaryColor,
//         cancelTextColor: kTextColor);
//   }
// }
