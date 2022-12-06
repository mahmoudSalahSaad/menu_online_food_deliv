import 'package:flutter/material.dart';
import 'package:menu_egypt/screens/address_screen/address_screen.dart';
import 'package:menu_egypt/screens/basket_screen/basket_screen.dart';
import 'package:menu_egypt/screens/category_screen/category_screen.dart';
import 'package:menu_egypt/screens/choose_location_screen/choose_location_screen.dart';
import 'package:menu_egypt/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:menu_egypt/screens/favorites_screen/favorites_screen.dart';
import 'package:menu_egypt/screens/filter_result_screen/filter_result_screen.dart';
import 'package:menu_egypt/screens/filter_screen/filter_screen.dart';
import 'package:menu_egypt/screens/forget_password_screen/components/change_password.dart';
import 'package:menu_egypt/screens/forget_password_screen/components/verification.dart';
import 'package:menu_egypt/screens/forget_password_screen/forget_password_screen.dart';
import 'package:menu_egypt/screens/home_screen/home_screen.dart';
import 'package:menu_egypt/screens/new_restaurant_screen/new_restaurant_screen.dart';
import 'package:menu_egypt/screens/new_restaurant_screen/resturant_screen_new.dart';
import 'package:menu_egypt/screens/orders_screen/my_orders.dart';
import 'package:menu_egypt/screens/orders_screen/order_details_screen.dart';
import 'package:menu_egypt/screens/otp_screen/otp_screen.dart';
import 'package:menu_egypt/screens/placement_order_screen/placement_order.dart';
import 'package:menu_egypt/screens/profile_screen/profile_screen.dart';
import 'package:menu_egypt/screens/sign_in_screen/sign_in_screen.dart';
import 'package:menu_egypt/screens/sign_up_screen/sign_up_screen.dart';
import 'package:menu_egypt/screens/slider_screen/slider_screen.dart';
import 'package:menu_egypt/screens/splash_screen/splash_screen.dart';
import 'package:menu_egypt/widgets/BaseMessageScreen.dart';

final Map<String, WidgetBuilder> routes = {
  SliderScreen.routeName: (BuildContext context) => SliderScreen(),
  SignInScreen.routeName: (BuildContext context) => SignInScreen(),
  SignUpScreen.routeName: (BuildContext context) => SignUpScreen(),
  ForgetPasswordScreen.routeName: (BuildContext context) =>
      ForgetPasswordScreen(),
  HomeScreen.routeName: (BuildContext context) => HomeScreen(),
  ChooseLocationScreen.routeName: (BuildContext context) =>
      ChooseLocationScreen(),
  FilterScreen.routeName: (BuildContext context) => FilterScreen(),
  FilterResultScreen.routeName: (BuildContext context) => FilterResultScreen(),
  CategoryScreen.routeName: (BuildContext context) => CategoryScreen(),
  FavoritesScreen.routeName: (BuildContext context) => FavoritesScreen(),
  ProfileScreen.routeName: (BuildContext context) => ProfileScreen(),
  ProfileEditScreen.routeName: (BuildContext context) => ProfileEditScreen(),
  SplashScreen.routeName: (BuildContext context) => SplashScreen(),
  BaseMessageScreen.routeName: (BuildContext context) => BaseMessageScreen(),
  VerificationPasswordScreen.routeName: (BuildContext context) =>
      VerificationPasswordScreen(),
  ChangePasswordScreen.routeName: (BuildContext context) =>
      ChangePasswordScreen(),
  NewRestaurantScreen.routeName: (BuildContext context) =>
      NewRestaurantScreen(),
  ResturantScreenNew.routeName: (BuildContext context) => ResturantScreenNew(),
  MyOrders.routeName: (BuildContext context) => MyOrders(),
  MyBasket.routeName: (BuildContext context) => MyBasket(),
  PlacementOrder.routeName: (BuildContext context) => PlacementOrder(),
  AddressScreen.routeName: (BuildContext context) => AddressScreen(),
  OtpScreen.routeName: (BuildContext context) => OtpScreen(),
  OrderDetails.routeName: (BuildContext context) => OrderDetails(),
  '/': (BuildContext context) => SplashScreen()
};
