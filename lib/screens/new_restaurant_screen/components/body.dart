import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:get/get.dart';
import 'package:menu_egypt/components/dialog.dart';
import 'package:menu_egypt/screens/new_restaurant_screen/components/branches_tab_widget.dart';
import 'package:menu_egypt/screens/new_restaurant_screen/components/comments_tab_widget.dart';
import 'package:menu_egypt/screens/new_restaurant_screen/components/menu_tab_widget.dart';
import 'package:menu_egypt/widgets/home_header.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  TabController? _tabController;
  List<String> images = [];
  bool isFav = false;
  int _currentIndex = 0;
  List<String> tabs = ['القائمة', 'التقييم', 'الفروع'];
  List<Widget>? tabsWidget;
  RestaurantModel? restaurant;
  List<String> areas = [];

  @override
  void initState() {
    final restaurantProvider =
        Provider.of<RestaurantsProvider>(context, listen: false);
    _tabController = TabController(
        length: tabs.length,
        animationDuration: Duration(milliseconds: 10),
        vsync: this);
    _tabController!.addListener(() {
      setState(() {
        _currentIndex = _tabController!.index;
      });
    });
    restaurant = restaurantProvider.restaurant;

    if (Provider.of<UserProvider>(context, listen: false).user != null) {
      if (Provider.of<UserProvider>(context, listen: false)
          .user
          !.favorites
          !.contains(restaurant!.id)) {
        isFav = true;
      }
    }

    if (restaurant!.images!.length >= 1) {
      images = restaurant!.images!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    tabsWidget = [
      MenuTabWidget(
        date: restaurant!.date!,
        isOnline: restaurant!.isOnline!,
        isOutOfTime: restaurant!.isOutOfTime!,
        restId: restaurant!.id!,
        images: images,
        sliderImages: Provider.of<RestaurantsProvider>(context, listen: false)
            .sliderimages,
        sliderImagesLink:
            Provider.of<RestaurantsProvider>(context, listen: false)
                .sliderImagesLink,
      ),
      CommentsTabWidget(
        id: restaurant!.id!,
      ),
      BranchesTabWidget(resturant: restaurant!, areas: areas)
    ];
    return SafeArea(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: getProportionateScreenHeight(2),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0 , vertical: 10.0) ,
          child:   HomeHeader(back: true ,
            ontap: () => favFunction(userProvider),
            isFav: isFav,
            restId: restaurant!.id!,
            image: restaurant!.logoSmall,
            pathFrom: "resturant",
            name: restaurant!.nameAr!,

          ) ,
        ),
        TopHeaderWidget(
          restId: restaurant!.id!,
          isFav: isFav,
          onTap: () => favFunction(userProvider),
          image: restaurant!.logoSmall!,
          name: restaurant!.nameAr!,
          viewTime: restaurant!.viewTimes!,
          review: restaurant!.review.toString(),
          phone1: restaurant!.phoneNumber1!,
          phone2: restaurant!.phoneNumber2!,
          phone3: restaurant!.phoneNumber3!,
           lastUpdate: restaurant!.date.toString(),
          userProvider: userProvider,
          pathFrom: 'resturant',
        ),
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            color: Color(0xffF7F7F9),
            borderRadius: BorderRadius.circular(12) ,
            border: Border.all(color: Color(0xffE4E4E5))
          ),
          child: TabBar(
            controller: _tabController,

            onTap: (int index) async {
              if (index == 2) {
                // areas = filterRestaurantAreas(context, restaurant.regions);
                areas = restaurant!.areas!;
                setState(() {});
              }
            },
            padding: EdgeInsets.zero,
            labelPadding: EdgeInsets.zero,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 0.000001,
            indicatorColor: Color(0xffF7F7F9),
            tabs: tabs.map(
                  (tab) {
                int currentActiveIndex = tabs.indexOf(tab);
                return Container(
                  width: double.maxFinite,
                  height: getProportionateScreenHeight(34),
                  decoration: BoxDecoration(
                    color: currentActiveIndex == _currentIndex
                        ? kPrimaryColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12) ,
                  ),

                  child: Tab(
                    child: Text(
                      tab,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(14),
                        color: _currentIndex == currentActiveIndex
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
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
                          child: tabsWidget![_currentIndex],
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
    if(userProvider.user != null){
      if (!userProvider.isLoading) {
        if (isFav) {
          if (userProvider.user!.favorites!.contains(restaurant!.id)) {
            print(restaurant!.id);
            var result = await userProvider.removeFavorite(restaurant!.id!);
            print(result);
            if (result['success']) {
              userProvider.user!.favorites!.remove(restaurant!.id!);
              List<String> favList =
              userProvider.user!.favorites!.map((i) => i.toString()).toList();
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setStringList("favList", favList);
              setState(() {
                isFav = !isFav;
              });
            } else {
              dialog('حدث خطأ ما حاول مرة اخرى');
            }
          }
        } else {
          if (!userProvider.user!.favorites!.contains(restaurant!.id)) {
            var result = await userProvider.addFavorite(restaurant!.id!);
            print(result);

            if (result['success']) {
              userProvider.user!.favorites!.add(restaurant!.id!);
              print(restaurant!.id);
              List<String> favList =
              userProvider.user!.favorites!.map((i) => i.toString()).toList();
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setStringList("favList", favList);
              setState(() {
                isFav = !isFav;
              });
            }
          } else {
            dialog('حدث خطأ ما حاول مرة اخرى');
          }
        }
      }
    }else{
      AppDialog.confirmDialog(
        context: context , 
        message: "رجاء تسجيل الدخول" , 
        title: "" , 
        onConfirm: (){
          Get.back();

          Get.toNamed('/sign_in');
        },
        confirmBtnTxt: "تسجيل الدخول",
        cancelBtnTxt: "ألغاء"
      );
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

        String regionCity = city.nameAr! + " - " + region.nameAr;
        restaurantAreas.add(regionCity);
      }
    });
    return restaurantAreas;
  }

  void dialog(String message) {
    AppDialog.infoDialog(
      context: context,
      title: 'تنبيه',
      message: message,
      btnTxt: 'إغلاق',
    );
  }
}


