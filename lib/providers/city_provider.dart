import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:menu_egypt/models/City.dart';
import 'package:menu_egypt/services/http_service_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CityProvider extends ChangeNotifier {
  bool _isLoading = false;
  List<CityModel> _cities = [];
  final HttpServiceImpl httpService = HttpServiceImpl();
  UnmodifiableListView<CityModel> get cities {
    return UnmodifiableListView(_cities);
  }

  void setCities(List<CityModel> newCities) {
    _cities = newCities;
  }

  bool get isLoading {
    return _isLoading;
  }

  Future<Map<String, dynamic>> fetchCities() async {
    final Map<String, dynamic> result = {'success': false, 'error': null};
    _isLoading = true;
    notifyListeners();
    String url = '/cities';
    httpService.init();
    final List<CityModel> cities = [];
    try {
      Response response = await httpService.getRequest(url, null);
      var parsedCities = response.data['data']['cities'] as List;
      if (response.statusCode == 200 && response.data['status_code'] == 201) {
        parsedCities.forEach((cityObject) {
          final String name = cityObject['name_ar'];
          final int cityId = cityObject['id'];
          final CityModel city = CityModel(cityId: cityId, nameAr: name);
          cities.add(city);
        });
        _cities = cities;
        final SharedPreferences preferences =
            await SharedPreferences.getInstance();
        preferences.setString(
            'accessToken', response.data['data']['access_token']);
        result['success'] = true;
      }
    } catch (error) {
      result['error'] = error;
    }
    _isLoading = false;
    notifyListeners();
    return result;
  }

  CityModel getCityById(int cityId) {
    CityModel city = _cities.firstWhere((city) => city.cityId == cityId);
    return city;
  }
}
