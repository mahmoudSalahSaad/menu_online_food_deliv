import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/screens/new_restaurant_screen/components/branches_tab_widget.dart';
import 'package:menu_egypt/screens/new_restaurant_screen/components/comments_tab_widget.dart';
import 'package:menu_egypt/screens/new_restaurant_screen/components/menu_tab_widget.dart';
import 'package:provider/provider.dart';

import '../../../models/Restaurant.dart';
import '../../../providers/city_provider.dart';
import '../../../providers/region_provider.dart';
import '../../../providers/restaurants_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../utilities/constants.dart';
import '../../../utilities/size_config.dart';
import 'top_header_widget.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> images = [];
  bool isFav = false;
  int _currentIndex = 0;
  List<String> tabs = ['القائمة', 'التقييم', 'الفروع'];
  List<Widget> tabsWidget;
  RestaurantModel restaurant;
  List<String> areas = [];
  @override
  void initState() {
    final restaurantProvider =
        Provider.of<RestaurantsProvider>(context, listen: false);
    _tabController = TabController(
        length: tabs.length,
        animationDuration: Duration(milliseconds: 10),
        vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
    restaurant = restaurantProvider.restaurant;
    /*
    if (Provider.of<UserProvider>(context, listen: false).user != null) {
      if (Provider.of<UserProvider>(context, listen: false)
          .user
          .favorites
          .contains(restaurant.id)) {
        isFav = true;
      }
    }
    */
    if (restaurant.images.length >= 1) {
      images = restaurant.images;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    tabsWidget = [
      MenuTabWidget(
        date: restaurant.date,
        isOnline: restaurant.isOnline,
        isOutOfTime: restaurant.isOutOfTime,
        restId: restaurant.id,
        images: images,
      ),
      CommentsTabWidget(
        id: restaurant.id,
      ),
      BranchesTabWidget(resturant: restaurant, areas: areas)
    ];
    return SafeArea(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: getProportionateScreenHeight(2),
        ),
        TopHeaderWidget(
          isFav: isFav,
          onTap: () => favFunction(userProvider),
          image: restaurant.logoSmall,
          name: restaurant.nameAr,
          viewTime: restaurant.viewTimes,
          review: restaurant.review.toString(),
          phone1: restaurant.phoneNumber1,
          phone2: restaurant.phoneNumber2,
          phone3: restaurant.phoneNumber3,
          userProvider: userProvider,
        ),
        TabBar(
          controller: _tabController,
          onTap: (int index) async {
            if (index == 2) {
              areas = filterRestaurantAreas(context, restaurant.regions);

              setState(() {});
            }
          },
          padding: EdgeInsets.zero,
          labelPadding: EdgeInsets.zero,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 3.0,
          indicatorColor: kPrimaryColor,
          tabs: tabs.map(
            (tab) {
              int currentActiveIndex = tabs.indexOf(tab);
              return Container(
                width: double.maxFinite,
                height: 30,
                color: currentActiveIndex == _currentIndex
                    ? kPrimaryColor
                    : Colors.black,
                child: Tab(
                  child: Text(
                    tab,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(12),
                      color: _currentIndex == currentActiveIndex
                          ? Colors.white
                          : Colors.white,
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        ),
        Expanded(
          child: Container(
            child: TabBarView(
                controller: _tabController,
                physics: NeverScrollableScrollPhysics(),
                children: tabs
                    .map(
                      (e) => Container(
                        child: AnimationLimiter(
                          child: tabsWidget[_currentIndex],
                        ),
                      ),
                    )
                    .toList()),
          ),
        ),
      ],
    ));
  }

  void favFunction(UserProvider userProvider) async {
    if (!userProvider.isLoading) {
      if (isFav) {
        if (userProvider.user.favorites.contains(restaurant.id)) {
          var result = await userProvider.removeFavorite(restaurant.id);
          if (result['success']) {
            userProvider.user.favorites.remove(restaurant.id);
            setState(() {
              isFav = !isFav;
            });
          } else {
            dialog('حدث خطأ ما حاول مرة اخرى');
          }
        }
      } else {
        if (!userProvider.user.favorites.contains(restaurant.id)) {
          var result = await userProvider.addFavorite(restaurant.id);
          if (result['success']) {
            userProvider.user.favorites.add(restaurant.id);
            setState(() {
              isFav = !isFav;
            });
          }
        } else {
          dialog('حدث خطأ ما حاول مرة اخرى');
        }
      }
    }
  }

  List<String> filterRestaurantAreas(context, List<int> regionsIds) {
    var cities = Provider.of<CityProvider>(context, listen: false).cities;
    var regions = Provider.of<RegionProvider>(context, listen: false).regions;
    List<String> restaurantAreas = [];
    regions.forEach((region) {
      if (regionsIds.contains(region.regionId)) {
        var city = cities.firstWhere((city) {
          return city.cityId == region.cityId;
        });

        String regionCity = city.nameAr + " - " + region.nameAr;
        restaurantAreas.add(regionCity);
      }
    });
    return restaurantAreas;
  }

  void dialog(String message) {
    Get.defaultDialog(
        content: Text(message),
        textCancel: 'إغلاق',
        title: 'تحذير',
        buttonColor: kPrimaryColor,
        cancelTextColor: kTextColor);
  }
}
