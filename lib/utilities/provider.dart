import 'package:flutter/material.dart';
import 'package:menu_egypt/providers/address_provider.dart';
import 'package:menu_egypt/providers/cart_provider.dart';
import 'package:menu_egypt/providers/home_provider.dart';
import 'package:menu_egypt/providers/orders_provider.dart';
import 'package:menu_egypt/providers/resturant_items_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../providers/categories_provider.dart';
import '../providers/city_provider.dart';
import '../providers/region_provider.dart';
import '../providers/restaurants_provider.dart';
import '../providers/user_provider.dart';

List<SingleChildWidget> providers() {
  return [
    ChangeNotifierProvider<UserProvider>(
      create: (BuildContext context) => UserProvider(),
    ),
    ChangeNotifierProvider<CityProvider>(
      create: (BuildContext context) => CityProvider(),
    ),
    ChangeNotifierProvider<RegionProvider>(
      create: (BuildContext context) => RegionProvider(),
    ),
    ChangeNotifierProvider<RestaurantsProvider>(
      create: (BuildContext context) => RestaurantsProvider(),
    ),
    ChangeNotifierProvider<CategoriesProvider>(
      create: (BuildContext context) => CategoriesProvider(),
    ),
    ChangeNotifierProvider<HomeProvider>(
      create: (BuildContext context) => HomeProvider(),
    ),
    ChangeNotifierProvider<CartProvider>(
      create: (BuildContext context) => CartProvider(),
    ),
    ChangeNotifierProvider<ResturantItemsProvider>(
      create: (BuildContext context) => ResturantItemsProvider(),
    ),
    ChangeNotifierProvider<AddressProvider>(
      create: (BuildContext context) => AddressProvider(),
    ),
    ChangeNotifierProvider<OrderProvider>(
      create: (BuildContext context) => OrderProvider(),
    ),
  ];
}
