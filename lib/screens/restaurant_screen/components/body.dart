// import 'package:flutter/material.dart';
// import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
// import 'package:menu_egypt/components/app_bar.dart';
// import 'package:menu_egypt/models/Restaurant.dart';
// import 'package:menu_egypt/providers/restaurants_provider.dart';
// import 'package:menu_egypt/providers/user_provider.dart';
// import 'package:menu_egypt/screens/restaurant_screen/components/icons_row.dart';
// import 'package:menu_egypt/screens/restaurant_screen/components/menu_widget.dart';
// import 'package:menu_egypt/screens/restaurant_screen/components/text_icon_widget.dart';
// import 'package:menu_egypt/utilities/constants.dart';
// import 'package:menu_egypt/utilities/size_config.dart';
// import 'package:provider/provider.dart';
//
// // ignore: must_be_immutable
// class Body extends StatefulWidget {
//   final int restaurantIndex;
//   final int listType;
//   final int lang;
//   Body(
//       {Key key,
//       @required this.restaurantIndex,
//       @required this.listType,
//       this.lang})
//       : super(key: key);
//
//   @override
//   _BodyState createState() => _BodyState();
// }
//
// class _BodyState extends State<Body> {
//   List<String> images = [];
//   bool isFav = false;
//   List<RestaurantModel> restaurants;
//   @override
//   void initState() {
//     if (widget.listType == 0) {
//       restaurants =
//           Provider.of<RestaurantsProvider>(context, listen: false).restaurants;
//     } else if (widget.listType == 1) {
//       restaurants = Provider.of<RestaurantsProvider>(context, listen: false)
//           .mostViewRestaurants;
//     } else if (widget.listType == 2) {
//       restaurants = Provider.of<RestaurantsProvider>(context, listen: false)
//           .categoryRestaurants;
//     } else if (widget.listType == 3) {
//       restaurants = Provider.of<RestaurantsProvider>(context, listen: false)
//           .filterRestaurants;
//     } else {
//       restaurants = Provider.of<RestaurantsProvider>(context, listen: false)
//           .favoritesRestaurants;
//     }
//
//     if (Provider.of<UserProvider>(context, listen: false).user != null) {
//       if (Provider.of<UserProvider>(context, listen: false)
//           .user
//           .favorites
//           .contains(restaurants[widget.restaurantIndex].id)) {
//         isFav = true;
//       }
//     }
//     if (restaurants[widget.restaurantIndex].images.length >= 1) {
//       images = restaurants[widget.restaurantIndex].images;
//     }
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final restaurantProvider =
//         Provider.of<RestaurantsProvider>(context, listen: false);
//     final userProvider = Provider.of<UserProvider>(context, listen: false);
//     return SafeArea(
//         child: Container(
//             alignment: Alignment.center,
//             padding: EdgeInsets.all(kDefaultPadding),
//             child: CustomScrollView(slivers: [
//               SliverList(
//                   delegate: SliverChildListDelegate([
//                 AppBarWidget(
//                   title: '',
//                   withBack: true,
//                 ),
//                 Container(
//                   height: SizeConfig.screenHeight * 0.2,
//                   child: ClipRRect(
//                       borderRadius: BorderRadius.circular(50.0),
//                       child: FadeInImage.assetNetwork(
//                           placeholder: "assets/icons/menu_egypt_logo.png",
//                           image:
//                               '${restaurants[widget.restaurantIndex].logoSmall}')),
//                 ),
//                 Text(
//                   widget.lang == 0
//                       ? restaurants[widget.restaurantIndex].nameAr
//                       : restaurants[widget.restaurantIndex].nameEn,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: SizeConfig.screenWidth * 0.1,
//                   ),
//                 ),
//                 TextIconWidget(
//                   fav: false,
//                   text: restaurants[widget.restaurantIndex].phoneNumber1,
//                   icon: Icons.phone,
//                   onTap: () async {
//                     bool result = await FlutterPhoneDirectCaller.callNumber(
//                         '${restaurants[widget.restaurantIndex].phoneNumber1}');
//                     if (result) {
//                       print('call');
//                     }
//                   },
//                 ),
//                 SizedBox(
//                   height: SizeConfig.screenHeight * 0.02,
//                 ),
//                 IconsRow(
//                   restaurantIndex: widget.restaurantIndex,
//                   restaurants: restaurants,
//                   restaurantProvider: restaurantProvider,
//                   userProvider: userProvider,
//                   isFav: isFav,
//                   onTap: () => favFunction(userProvider),
//                 ),
//                 SizedBox(
//                   height: SizeConfig.screenHeight * 0.01,
//                 ),
//                 Text(
//                     'المنيو بتاريخ ${restaurants[widget.restaurantIndex].date}',
//                     textAlign: TextAlign.center),
//                 Text('الطلب عبر الإنترنت قريبًا',
//                     style: TextStyle(fontSize: SizeConfig.screenWidth * 0.05)),
//               ])),
//               images.length == 0
//                   ? SliverList(
//                       delegate: SliverChildListDelegate([
//                       Center(
//                           child: Container(
//                               child: Text('لا يوجد قوائم طعام لهذا المطعم')))
//                     ]))
//                   : MenuWidget(images: images)
//             ])));
//   }
//
//   void favFunction(UserProvider userProvider) async {
//     setState(() {
//       isFav = !isFav;
//       if (isFav) {
//         if (!userProvider.user.favorites
//             .contains(restaurants[widget.restaurantIndex].id)) {
//           userProvider.user.favorites
//               .add(restaurants[widget.restaurantIndex].id);
//         }
//       } else {
//         if (userProvider.user.favorites
//             .contains(restaurants[widget.restaurantIndex].id)) {
//           userProvider.user.favorites
//               .remove(restaurants[widget.restaurantIndex].id);
//         }
//       }
//     });
//     if (isFav) {
//       await userProvider.addFavorite(restaurants[widget.restaurantIndex].id);
//     } else {
//       await userProvider.removeFavorite(restaurants[widget.restaurantIndex].id);
//     }
//   }
// }
