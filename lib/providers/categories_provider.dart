import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:menu_egypt/models/Category.dart';
import 'package:menu_egypt/services/http_service_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoriesProvider extends ChangeNotifier {
  bool _isLoading = false;
  List<CategoryModel> _categories = [];
  final HttpServiceImpl httpService = HttpServiceImpl();
  bool get isLoading {
    return _isLoading;
  }

  UnmodifiableListView<CategoryModel> get categories {
    return UnmodifiableListView(_categories);
  }

  void setCategories(List<CategoryModel> newCategories) {
    _categories = newCategories;
  }

  Future<Map<String, dynamic>> fetchCategories(String userType) async {
    final Map<String, dynamic> result = {'success': false, 'error': null};
    _isLoading = true;
    notifyListeners();
    String url = '/categories';
    httpService.init();
    final List<CategoryModel> categories = [];
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String accessToken = preferences.getString('accessToken');
      Response response = await httpService.getRequest(url, accessToken);
      var parsedCategories = response.data['data']['categories'] as List;
      if (response.statusCode == 200 && response.data['status_code'] == 201) {
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
        result['success'] = true;
      }
    } catch (error) {
      result['error'] = error;
    }
    _isLoading = false;
    notifyListeners();
    return result;
  }

  List<CategoryModel> filterCategories() {
    final List<CategoryModel> categories = [];
    final CategoryModel allCategory = CategoryModel(
      id: 0,
      nameAr: 'الكل',
    );
    categories.add(allCategory);
    _categories.forEach((category) {
      if (category.image != null) {
        categories.add(category);
      }
    });
    return categories;
  }
}
