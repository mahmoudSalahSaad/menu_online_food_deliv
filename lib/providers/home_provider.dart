import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:menu_egypt/services/http_service_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Category.dart';
import '../models/City.dart';
import '../models/Region.dart';
import '../models/Restaurant.dart';

class HomeProvider extends ChangeNotifier {
  bool _isLoading = false;
  final HttpServiceImpl httpService = HttpServiceImpl();
  List<RestaurantModel> _mostViewRestaurants = [];
  List<CategoryModel> _categories = [];
  List<RegionModel> _regions = [];
  List<CityModel> _cities = [];

  // HomeProvider() {
  //    fetchData();
  // }

  bool get isLoading {
    return _isLoading;
  }

  List<RestaurantModel> get mostViewRestaurants {
    return _mostViewRestaurants;
  }

  List<CategoryModel> get categories {
    return _categories;
  }

  List<RegionModel> get regions {
    return _regions;
  }

  List<CityModel> get cities {
    return (_cities);
  }

  fetchData() async {
    print("unDone");
    print("unDone");
    print("unDone");
    print("unDone");
    print("unDone");
    print("unDone");
    print("unDone");
    print("unDone");
    print("unDone");
    print("unDone");
    final Map<String, dynamic> result = {'success': false, 'error': null};
    _isLoading = true;

    String url = '/';
    httpService.init();
    // _categories.clear();
    // _mostViewRestaurants.clear();
    // _cities.clear();
    // _regions.clear();
    final List<RestaurantModel> restaurants = [];
    final List<RegionModel> regions = [];
    final List<CityModel> cities = [];
    final List<CategoryModel> categories = [];

    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      // String accessToken = preferences.getString('accessToken')!;
      Response response = await httpService.getRequest(url, '');

      print(response);
      print("unDone");
      print("unDone");
      print("unDone");
      var parsedRestaurants = response.data['data']['restaurants'] as List;
      var parsedCategories = response.data['data']['categories'] as List;
      var parsedRegions = response.data['data']['regions'] as List;
      var parsedCities = response.data['data']['cities'] as List;
      if (response.statusCode == 200 && response.data['status_code'] == 201) {
        if (parsedRestaurants.isNotEmpty) {
          parsedRestaurants.forEach((restaurantObject) {
            final RestaurantModel restaurant = RestaurantModel(
                id: restaurantObject['id'],
                nameAr: restaurantObject['name_ar'],
                nameEn: restaurantObject['name_en'],
                logoSmall: restaurantObject['logo_small'] == null
                    ? ""
                    : "https://menuegypt.com//${restaurantObject['logo_small']}",
                phoneNumber1: restaurantObject['phone'] == null
                    ? ""
                    : restaurantObject['phone'],
                categoryId: restaurantObject['category_id'] == null
                    ? null
                    : restaurantObject['category_id'],
                branches: [],
                areas: [],
                images: []);

            restaurants.add(restaurant);
          });
          _mostViewRestaurants = restaurants;
        }

        if (parsedCategories.isNotEmpty) {
          parsedCategories.forEach((categoryObject) {
            final String name = categoryObject['name_ar'];
            final int id = categoryObject['id'];
            final String image =
                'https://menuegypt.com/${categoryObject['image']}';
            final CategoryModel category = CategoryModel(
                id: id, image: image == null ? null : image, nameAr: name);
            categories.add(category);
          });
          _categories = categories;
        }
        if (parsedCities.isNotEmpty) {
          parsedCities.forEach((cityObject) {
            final String name = cityObject['name_ar'];
            final int cityId = cityObject['id'];
            final CityModel city = CityModel(cityId: cityId, nameAr: name);
            cities.add(city);
          });
          _cities = cities;
        }

        if (parsedRegions.isNotEmpty) {
          parsedRegions.forEach((regionObject) {
            final RegionModel region = RegionModel(
                regionId: regionObject['id'],
                cityId: regionObject['city_id'],
                nameAr: regionObject['name_ar']);
            regions.add(region);
          });
          _regions = regions;
        }
        result['success'] = true;
      }
    } catch (error) {
      result['error'] = error;
    }
    _isLoading = false;
    notifyListeners();
  }
}
