import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:menu_egypt/models/resturant_categories.dart';
import 'package:menu_egypt/models/resturant_product.dart';
import 'package:menu_egypt/services/http_service_impl.dart';

class ResturantItemsProvider extends ChangeNotifier {
  bool _isLoading = false;
  ResturantCategoriesModel _resturantCategoriesModel;
  ResturantProductModel _resturantProductModel;
  final HttpServiceImpl httpService = HttpServiceImpl();

  bool get isLoading {
    return _isLoading;
  }

  ResturantCategoriesModel get resturantCategoriesModel {
    return _resturantCategoriesModel;
  }

  ResturantProductModel get resturantProductModel {
    return _resturantProductModel;
  }

  Future<Map<String, dynamic>> getResturantCategories(int resturantId) async {
    Map<String, dynamic> result = {'success': false, 'error': null};
    _isLoading = true;
    notifyListeners();
    String url = '/view-resturant/$resturantId';
    httpService.init();
    try {
      Response response = await httpService.getRequest(url, null);
      print(response);
      if (response.statusCode == 200 && response.data['status'] == true) {
        print(response);

        var parsedCategories = response.data['data'];

        ResturantCategoriesModel resturantCategories =
            ResturantCategoriesModel.fromJson(parsedCategories);
        _resturantCategoriesModel = resturantCategories;

        print('Success');
        result['success'] = true;
      } else {
        print('Failed');
        _resturantCategoriesModel = null;
        result['error'] = response.data['message'];
      }
    } catch (error) {
      print('Catch');
      print(error);
      throw result['error'] = error;
    }
    _isLoading = false;
    notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> getResturantProduct(int productId) async {
    Map<String, dynamic> result = {'success': false, 'error': null};
    _isLoading = true;
    //notifyListeners();
    String url = '/view-resturant-product/$productId';
    httpService.init();
    try {
      Response response = await httpService.getRequest(url, null);
      print(response);
      if (response.statusCode == 200 && response.data['status'] == true) {
        print(response);

        var parsedProduct = response.data['data'];

        ResturantProductModel resturantProduct =
            ResturantProductModel.fromJson(parsedProduct);
        _resturantProductModel = resturantProduct;

        print('Success');
        result['success'] = true;
      } else {
        print('Failed');
        _resturantCategoriesModel = null;
        result['error'] = response.data['message'];
      }
    } catch (error) {
      print('Catch');
      print(error);
      throw result['error'] = error;
    }
    _isLoading = false;
    notifyListeners();
    return result;
  }
}
