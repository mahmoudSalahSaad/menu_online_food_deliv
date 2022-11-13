import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/components/city_drop_down.dart';
import 'package:menu_egypt/components/default_button.dart';
import 'package:menu_egypt/components/loading_circle.dart';
import 'package:menu_egypt/components/region_drop_down.dart';
import 'package:menu_egypt/models/Category.dart';
import 'package:menu_egypt/models/City.dart';
import 'package:menu_egypt/models/Region.dart';
import 'package:menu_egypt/providers/categories_provider.dart';
import 'package:menu_egypt/providers/city_provider.dart';
import 'package:menu_egypt/providers/home_provider.dart';
import 'package:menu_egypt/providers/region_provider.dart';
import 'package:menu_egypt/providers/restaurants_provider.dart';
import 'package:menu_egypt/providers/user_provider.dart';
import 'package:menu_egypt/screens/filter_result_screen/filter_result_screen.dart';
import 'package:menu_egypt/components/categories_drop_down.dart';
import 'package:menu_egypt/screens/home_screen/components/restaurant_logos.dart';
import 'package:menu_egypt/screens/home_screen/components/search_widget_bar.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final Map<String, dynamic> _formData = {
    'cityId': null,
    'regionId': null,
    'categryId': null,
  };

  List<CityModel> cities;
  List<RegionModel> regions;
  List<CategoryModel> categories;
  CityModel city;
  RegionModel region;
  CategoryModel category;

  void _onSubmit(BuildContext context) async {
    Map<String, dynamic> result =
        await Provider.of<RestaurantsProvider>(context, listen: false)
            .fetchFilterResult(_formData['regionId'], _formData['categoryId']);
    if (result['success']) {
      Get.toNamed(FilterResultScreen.routeName);
    } else {
      dialog('حدث خطأ ما حاول مرة اخرى لاحقاً.');
    }
  }

  @override
  void initState() {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final user = Provider.of<UserProvider>(context, listen: false);
    final regionProvider = Provider.of<RegionProvider>(context, listen: false);
    final cityProvider = Provider.of<CityProvider>(context, listen: false);
    final restaurantProvider =
        Provider.of<RestaurantsProvider>(context, listen: false);
    regionProvider.setRegions(homeProvider.regions);
    cityProvider.setCities(homeProvider.cities);
    restaurantProvider.setMostViewRestaurants(homeProvider.mostViewRestaurants);
    cities = cityProvider.cities;
    if (user.user != null) {
      if (user.user.cityId != null) {
        city = cityProvider.getCityById(user.user.cityId);

        regions = regionProvider.regionsOfCity(city.cityId);
        region = regionProvider.getRegionById(user.user.regionId);
      } else {
        city = cities[0];
        regions = regionProvider.regionsOfCity(city.cityId);
        region = regions[15];
      }
    } else {
      city = cities[0];
      regions = regionProvider.regionsOfCity(city.cityId);
      region = regions[15];
    }
    Provider.of<CategoriesProvider>(context, listen: false)
        .setCategories(homeProvider.categories);
    categories = Provider.of<CategoriesProvider>(context, listen: false)
        .filterCategories();
    category = categories[0];

    restaurantProvider.fetchRestaurants('guest');
    _formData['regionId'] = region.regionId;
    _formData['categoryId'] = category.id;
    super.initState();
  }

  @override
  void dispose() {
    categories = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final restaurantProvider =
        Provider.of<RestaurantsProvider>(context, listen: true);

    return SafeArea(
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: kDefaultPadding, horizontal: kDefaultPadding),
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Align(
                        alignment: Alignment.center,
                        child: Image.asset('assets/images/menu-egypt-logo.png'),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.02,
                    ),
                    SearchWidgetBar(restaurantProvider: restaurantProvider),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.04,
                    ),
                  ],
                ),
              ),
              RestaurantLogos(
                  restaurants: restaurantProvider.mostViewRestaurants),
              SliverList(
                  delegate: SliverChildListDelegate([
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                CityDropDownField(
                    items: cities,
                    value: city,
                    onChanged: (CityModel cityModel) {
                      setState(() {
                        city = cityModel;
                        regions =
                            Provider.of<RegionProvider>(context, listen: false)
                                .regionsOfCity(city.cityId);
                        if (cityModel.cityId == cities[18].cityId) {
                          region = regions[24];
                        } else {
                          region = regions[0];
                        }
                        _formData['cityId'] = city.cityId;
                      });
                    }),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                RegionDropDownField(
                  items: regions,
                  value: region,
                  onChanged: (RegionModel regionModel) {
                    setState(() {
                      region = regionModel;
                      _formData['regionId'] = region.regionId;
                    });
                  },
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                CategoriesDropDownField(
                    value: category,
                    items: categories,
                    onChanged: (CategoryModel categoryModel) {
                      setState(() {
                        category = categoryModel;
                        _formData['categoryId'] = category.id;
                      });
                    }),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                restaurantProvider.isLoading
                    ? LoadingCircle()
                    : DefaultButton(
                        onPressed: () {
                          _onSubmit(context);
                        },
                        child: Text(
                          'ابحث',
                          style: TextStyle(
                              fontSize: SizeConfig.screenWidth * 0.06),
                        ),
                        color: kPrimaryColor,
                        textColor: kTextColor,
                        minWidth: 0.0,
                        height: getProportionateScreenHeight(33)),
                Divider(color: Colors.white),
              ])),
              // Categories(categories: categories)
            ],
          ),
        ),
      ),
    );
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
