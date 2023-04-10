// import 'package:flutter/material.dart';
// import 'package:menu_egypt/components/bottom_nav_bar_widget_new.dart';
// import 'package:menu_egypt/screens/restaurant_screen/components/body.dart';
// import 'package:menu_egypt/utilities/constants.dart';
// import 'package:menu_egypt/widgets/BaseConnectivity.dart';
//
// class RestaurantScreen extends StatelessWidget {
//   static String routeName = '/restaurant';
//   final int restaurantIndex;
//   final int listType;
//   final int lang;
//   const RestaurantScreen(
//       {Key key,
//       this.lang,
//       @required this.restaurantIndex,
//       @required this.listType})
//       : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(gradient: kBackgroundColor),
//       child: BaseConnectivity(
//         child: Scaffold(
//           body: Body(
//               restaurantIndex: restaurantIndex, listType: listType, lang: lang),
//           bottomNavigationBar: BottomNavBarWidgetNew(index: 0),
//         ),
//       ),
//     );
//   }
// }
