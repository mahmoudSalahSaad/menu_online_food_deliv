import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:provider/provider.dart';
import 'package:menu_egypt/providers/categories_provider.dart';
import 'package:menu_egypt/providers/city_provider.dart';
import 'package:menu_egypt/providers/region_provider.dart';

import 'package:menu_egypt/providers/restaurants_provider.dart';
import 'package:menu_egypt/providers/user_provider.dart';

import 'package:menu_egypt/widgets/BaseMessageScreen.dart';

// Widget Name: Base Connectivity
// @version: 1.0.0
// @since: 1.0.0
// Description: A base widget to checked internet connectivity

class BaseConnectivity extends StatelessWidget {
  final Widget? child;
  const BaseConnectivity({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget builderChild,
      ) {
        if (connectivity == ConnectivityResult.none) {
          return BaseMessageScreen();
        } else {
          //checkDataExistance(context);
          return child!;
        }
      },
      builder: (BuildContext context) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'There are no bottons to push :)',
              ),
              Text(
                'Just turn off your internet.',
              ),
            ],
          ),
        );
      },
    );
  }

  void checkDataExistance(context) async {
    final categoryProvider =
        Provider.of<CategoriesProvider>(context, listen: false);
    final cityProvider = Provider.of<CityProvider>(context, listen: false);
    final regionProvider = Provider.of<RegionProvider>(context, listen: false);
    final resturantProvider =
        Provider.of<RestaurantsProvider>(context, listen: false);
    if (categoryProvider.categories.length < 1) {
      await categoryProvider.fetchCategories('guest');
    }
    if (cityProvider.cities.length < 1) {
      await cityProvider.fetchCities();
    }
    if (regionProvider.regions.length < 1) {
      await regionProvider.fetchRegions();
    }

    await Provider.of<UserProvider>(context, listen: false).autoAuthenticated();
    bool _isAuthenticated =
        Provider.of<UserProvider>(context, listen: false).isAuthenticated;
    if (_isAuthenticated) {
      if (resturantProvider.mostViewRestaurants.length < 1) {
        await resturantProvider.fetchMostViewsRestaurants('guest');
      }
    } else {
      await Provider.of<UserProvider>(context, listen: false).sliderImages();
    }
  }
}
