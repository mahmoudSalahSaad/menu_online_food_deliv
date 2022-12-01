import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:menu_egypt/models/Region.dart';
import 'package:menu_egypt/services/http_service_impl.dart';

class RegionProvider extends ChangeNotifier {
  bool _isLoading = false;
  List<RegionModel> _regions = [];
  final HttpServiceImpl httpService = HttpServiceImpl();

  UnmodifiableListView<RegionModel> get regions {
    return UnmodifiableListView(_regions);
  }

  void setRegions(List<RegionModel> newRegions) {
    _regions = newRegions;
  }

  bool get isLoading {
    return _isLoading;
  }

  Future<Map<String, dynamic>> fetchRegions() async {
    final Map<String, dynamic> result = {'success': false, 'error': null};
    _isLoading = true;
    notifyListeners();
    String url = '/regions';
    httpService.init();
    final List<RegionModel> regions = [];
    try {
      Response response = await httpService.getRequest(url, null);
      print(response);

      var parsedRegions = response.data['data']['regions'] as List;
      if (response.statusCode == 200 && response.data['status_code'] == 201) {
        parsedRegions.forEach((regionObject) {
          final RegionModel region = RegionModel(
              regionId: regionObject['id'],
              cityId: regionObject['city_id'],
              nameAr: regionObject['name_ar']);
          regions.add(region);
        });
        _regions = regions;
        result['success'] = true;
      }
    } catch (error) {
      result['error'] = error;
    }
    _isLoading = false;
    notifyListeners();
    return result;
  }

  List<RegionModel> regionsOfCity(int cityId) {
    List<RegionModel> regions = [];

    _regions.forEach((region) {
      if (region.cityId == cityId) {
        regions.add(region);
      }
    });

    return regions;
  }

  RegionModel getRegionById(int regionId) {
    RegionModel region =
        _regions.firstWhere((region) => region.regionId == regionId);
    return region;
  }
}
