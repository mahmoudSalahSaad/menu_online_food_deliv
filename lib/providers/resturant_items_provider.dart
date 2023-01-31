import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:menu_egypt/models/resturan_categories_and_products.dart';
import 'package:menu_egypt/models/resturant_categories.dart';
import 'package:menu_egypt/models/resturant_product.dart';
import 'package:menu_egypt/services/http_service_impl.dart';

class ResturantItemsProvider extends ChangeNotifier {
  bool _isLoading = false;
  ResturantCategoriesModel _resturantCategoriesModel;
  ResturantProductModel _resturantProductModel;
  ResturantCategoriesAndProducts _resturantCategoriesAndProducts;
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

  ResturantCategoriesAndProducts get resturantCategoriesAndProducts {
    return _resturantCategoriesAndProducts;
  }

  Future<Map<String, dynamic>> getResturantCategoriesAndProducts(
      int resturantId) async {
    Map<String, dynamic> result = {'success': false, 'error': null};
    _isLoading = true;
    notifyListeners();
    String url = '/view-full-resturant/$resturantId';
    httpService.init();
    try {
      Response response = await httpService.getRequest(url, null);
      print(response);
      if (response.statusCode == 200 && response.data['status'] == true) {
        print(response);

        var parsedCategoriesAndProducts = response.data;

        ResturantCategoriesAndProducts resturantCategoriesAndProducts =
            ResturantCategoriesAndProducts.fromJson(
                parsedCategoriesAndProducts);
        _resturantCategoriesAndProducts = resturantCategoriesAndProducts;

        print('Successss');
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

  Future<Map<String, dynamic>> getResturantCategoriesAndProductsByUrl(
      String restUrl) async {
    Map<String, dynamic> result = {'success': false, 'error': null};
    _isLoading = true;
    notifyListeners();
    String url = '/view-full-resturant-v2/$restUrl';
    httpService.init();
    try {
      Response response = await httpService.getRequest(url, null);
      print(response);
      if (response.statusCode == 200 && response.data['status'] == true) {
        print(response);

        var parsedCategoriesAndProducts = response.data;

        ResturantCategoriesAndProducts resturantCategoriesAndProducts =
            ResturantCategoriesAndProducts.fromJson(
                parsedCategoriesAndProducts);
        _resturantCategoriesAndProducts = resturantCategoriesAndProducts;

        print('Successss');
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
