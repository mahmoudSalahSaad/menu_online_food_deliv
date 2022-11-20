import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:menu_egypt/models/Comment.dart';
import 'package:menu_egypt/models/Restaurant.dart';
import 'package:menu_egypt/services/http_service_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestaurantsProvider extends ChangeNotifier {
  bool _isLoading = false;
  RestaurantModel _restaurant;
  List<RestaurantModel> _restaurants = [];
  List<RestaurantModel> _mostViewRestaurants = [];
  List<RestaurantModel> _filterRestaurants = [];
  List<RestaurantModel> _categoryRestaurants = [];
  List<RestaurantModel> _favoritesRestaurants = [];
  List<int> _filterResult = [];
  List<String> _restaurantBranches = [];
  List<int> _restaurantRegions = [];
  List<Comment> _comments = [];
  final HttpServiceImpl httpService = HttpServiceImpl();
  bool get isLoading {
    return _isLoading;
  }

  RestaurantModel get restaurant {
    return _restaurant;
  }

  List<RestaurantModel> get restaurants {
    return _restaurants;
  }

  UnmodifiableListView<RestaurantModel> get mostViewRestaurants {
    return UnmodifiableListView(_mostViewRestaurants);
  }

  UnmodifiableListView<RestaurantModel> get filterRestaurants {
    return UnmodifiableListView(_filterRestaurants);
  }

  UnmodifiableListView<RestaurantModel> get categoryRestaurants {
    return UnmodifiableListView(_categoryRestaurants);
  }

  UnmodifiableListView<RestaurantModel> get favoritesRestaurants {
    return UnmodifiableListView(_favoritesRestaurants);
  }

  UnmodifiableListView<int> get filterResult {
    return UnmodifiableListView(_filterResult);
  }

  UnmodifiableListView<String> get restaurantsBranches {
    return UnmodifiableListView(_restaurantBranches);
  }

  UnmodifiableListView<int> get restaurantsRegions {
    return UnmodifiableListView(_restaurantRegions);
  }

  UnmodifiableListView<Comment> get comments {
    return UnmodifiableListView(_comments);
  }

  void setMostViewRestaurants(List<RestaurantModel> newRestaurant) {
    _mostViewRestaurants = newRestaurant;
  }

  Future<Map<String, dynamic>> fetchRestaurant(int id) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> result = {'success': false, 'error': null};
    String url = '/restaurant';
    httpService.init();
    //final List<RestaurantModel> restaurants = [];
    _comments.clear();
    final List<Map<String, dynamic>> restaurantBranches = [];
    final List<String> restaurantImages = [];
    final List<int> regionsResult = [];
    String latestDate = '';
    try {
      //SharedPreferences preferences = await SharedPreferences.getInstance();
      //String accessToken = preferences.getString('accessToken');
      Response response = await httpService.postRequest(url, {'id': id}, '');
      if (response.statusCode == 200 && response.data['status_code'] == 201) {
        print(response);
        var parsedRestaurants = response.data['data']['restaurant'];
        var parsedRegoins = response.data['data']['regoins'] as List;
        var parsedrbanches = response.data['data']['branches'] as List;
        var parsedRestaurantImages = response.data['data']['images'] as List;
        var parsedRestaurantComment = response.data['data']['comments'] as List;

        if (parsedrbanches.isNotEmpty) {
          parsedrbanches.forEach((restaurantObject) {
            restaurantBranches.add({
              'name': restaurantObject['name_ar'],
              'numone': restaurantObject['numone'],
              'numtwo': restaurantObject['numtow'],
              'address': restaurantObject['address_ar']
            });
          });
        }

        if (parsedRestaurantImages.isNotEmpty) {
          parsedRestaurantImages.forEach((restaurantObject) {
            restaurantImages
                .add('https://menuegypt.com/' + restaurantObject['pic']);
            latestDate = restaurantObject['updated_at'];
          });
        }

        if (parsedRegoins.isNotEmpty) {
          parsedRegoins.forEach((restaurantObject) {
            regionsResult.add(restaurantObject['region_id']);
          });
        }
        if (parsedRestaurantComment.isNotEmpty) {
          parsedRestaurantComment.forEach((commentObject) {
            Comment comment = Comment(
                email: commentObject['email'],
                name: commentObject['name'],
                date: commentObject['date'],
                comment: commentObject['comment'],
                review: commentObject['review']);
            _comments.add(comment);
          });
        }

        double views = parsedRestaurants['view_times'] / 1.5;
        String viewsdata;
        if (views < 1000) {
          views = num.parse(views.toStringAsFixed(1));

          viewsdata = ((views / 10).ceil() * 10).toString();
        } else if (views >= 1000 && views < 1000000) {
          var viewsCount = views * (1 / 1000);
          var viewsK = (viewsCount).round();

          viewsdata = viewsK.toString() + 'K';
        } else if (views >= 1000000) {
          var viewsCount = views * (1 / 1000000);

          viewsCount = num.parse(viewsCount.toStringAsFixed(1));

          viewsdata = viewsCount.toString() + 'M';
        }
        final RestaurantModel restaurant = RestaurantModel(
          id: parsedRestaurants['id'],
          nameAr: parsedRestaurants['name_ar'],
          nameEn: parsedRestaurants['name_en'],
          logoSmall: parsedRestaurants['logo_small'] == null
              ? ""
              : "https://menuegypt.com/${parsedRestaurants['logo_small']}",
          phoneNumber1: parsedRestaurants['phone'] == null
              ? ""
              : parsedRestaurants['phone'],
          phoneNumber2: parsedRestaurants['phones_html1'] == null
              ? ""
              : parsedRestaurants['phones_html1'],
          phoneNumber3: parsedRestaurants['phones_html2'] == null
              ? ""
              : parsedRestaurants['phones_html2'],
          categoryId: parsedRestaurants['category_id'] == null
              ? null
              : parsedRestaurants['category_id'],
          branches: restaurantBranches,
          areas: [],
          regions: regionsResult,
          images: restaurantImages,
          viewTimes: viewsdata,
          review: response.data['data']['review'] > 0
              ? response.data['data']['review']
              : 5,
          date: latestDate.isNotEmpty
              ? DateFormat('dd/MM/yyyy').format(
                  DateTime.parse(latestDate),
                )
              : '',
          isOnline: response.data['data']['is_online'],
          isOutOfTime: response.data['data']['is_out_of_time'],
        );
        _restaurant = restaurant;

        result['success'] = true;
      }
    } catch (error) {
      throw result['error'] = error;
    }
    _isLoading = false;
    notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> fetchRestaurants(String userType) async {
    final Map<String, dynamic> result = {'success': false, 'error': null};
    String url = '/restaurants';
    httpService.init();
    final List<RestaurantModel> restaurants = [];

    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String accessToken = preferences.getString('accessToken');
      Response response = await httpService.getRequest(url, accessToken);
      var parsedRestaurants = response.data['data']['restaurants'] as List;
      if (response.statusCode == 200 && response.data['status_code'] == 201) {
        print(response);
        parsedRestaurants.forEach((restaurantObject) {
          final RestaurantModel restaurant = RestaurantModel(
              id: restaurantObject['id'],
              nameAr: restaurantObject['name_ar'],
              nameEn: restaurantObject['name_en'],
              logoSmall: restaurantObject['logo_small'] == null
                  ? ""
                  : "https://menuegypt.com/${restaurantObject['logo_small']}",
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
        _restaurants = restaurants;
        result['success'] = true;
      }
    } catch (error) {
      result['error'] = error;
    }
    return result;
  }

  Future<Map<String, dynamic>> fetchMostViewsRestaurants(
      String userType) async {
    final Map<String, dynamic> result = {'success': false, 'error': null};
    _isLoading = true;
    notifyListeners();
    String url = '/mostviewsrestaurants';
    httpService.init();
    final List<RestaurantModel> restaurants = [];

    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String accessToken = preferences.getString('accessToken');
      Response response = await httpService.getRequest(url, accessToken);
      var parsedRestaurants = response.data['data']['restaurants'] as List;
      if (response.statusCode == 200 && response.data['status_code'] == 201) {
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
        result['success'] = true;
      }
    } catch (error) {
      result['error'] = error;
    }
    _isLoading = false;
    notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> fetchFilterResult(
      int regionId, int categoryId) async {
    final Map<String, dynamic> result = {'success': false, 'error': null};
    _isLoading = true;
    notifyListeners();
    String url = '/filterresult';
    httpService.init();
    _filterResult.clear();
    _filterRestaurants.clear();

    var postData;
    if (categoryId > 0) {
      postData = {
        'category_id': categoryId == 0 ? null : categoryId,
        'region_id': regionId
      };
    } else {
      postData = {'region_id': regionId};
    }
    try {
      Response response = await httpService.postRequest(url, postData, '');
      if (response.statusCode == 200 && response.data['status_code'] == 201) {
        var parsedRestaurants = response.data['data']['restaurants'] as List;

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
          _filterRestaurants.add(restaurant);
        });
        result['success'] = true;
      }
    } catch (error) {
      result['error'] = error;
    }
    _isLoading = false;
    notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> restaurantBranches(
      RestaurantModel restaurantModel) async {
    final Map<String, dynamic> result = {'success': false, 'error': null};
    _isLoading = true;
    notifyListeners();
    String url = '/restaurantsbranches';
    httpService.init();
    final List<String> restaurantBranches = [];

    try {
      Response response = await httpService.postRequest(
          url, {'restaurant_id': restaurantModel.id}, '');
      var parsedRestaurantBranches =
          response.data['data']['restaurantBranches'] as List;
      if (response.statusCode == 200 && response.data['status_code'] == 201) {
        parsedRestaurantBranches.forEach((restaurantObject) {
          restaurantBranches.add(restaurantObject['name_ar']);
        });
        //restaurantModel.branches = restaurantBranches;
        result['success'] = true;
      }
    } catch (error) {
      result['error'] = error;
    }
    _isLoading = false;
    notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> restaurantImages(
    RestaurantModel restaurantModel,
  ) async {
    final Map<String, dynamic> result = {'success': false, 'error': null};
    _isLoading = true;
    notifyListeners();
    String url = '/restaurantsimages';
    httpService.init();
    final List<String> restaurantImages = [];
    String latestDate;
    try {
      Response response = await httpService.postRequest(
          url, {'restaurant_id': restaurantModel.id}, '');
      var parsedRestaurantImages =
          response.data['data']['restaurantImages'] as List;
      if (response.statusCode == 200 && response.data['status_code'] == 201) {
        parsedRestaurantImages.forEach((restaurantObject) {
          restaurantImages
              .add('https://menuegypt.com/' + restaurantObject['pic']);
          latestDate = restaurantObject['updated_at'];
        });
        restaurantModel.date =
            DateFormat('dd/MM/yyyy').format(DateTime.parse(latestDate));
        restaurantModel.images = restaurantImages;
        result['success'] = true;
      }
    } catch (error) {
      result['error'] = error;
    }
    _isLoading = false;
    notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> restaurantRegions(
    RestaurantModel restaurantModel,
  ) async {
    final Map<String, dynamic> result = {'success': false, 'error': null};
    _isLoading = true;
    notifyListeners();
    String url = '/restaurantsregions';
    httpService.init();
    final List<int> regionsResult = [];
    try {
      Response response = await httpService.postRequest(
          url, {'restaurant_id': restaurantModel.id}, '');
      var parsedRestaurantRegions =
          response.data['data']['restaurantRegions'] as List;
      if (response.statusCode == 200 && response.data['status_code'] == 201) {
        parsedRestaurantRegions.forEach((restaurantObject) {
          regionsResult.add(restaurantObject['region_id']);
        });

        restaurantModel.regions = regionsResult;
        result['success'] = true;
      }
    } catch (error) {
      result['error'] = error;
    }
    _isLoading = false;
    notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> addOneView(int id) async {
    final Map<String, dynamic> result = {'success': false, 'error': null};
    _isLoading = true;
    notifyListeners();
    String url = '/addview';
    httpService.init();

    try {
      Response response = await httpService.postRequest(url, {'id': id}, '');
      if (response.statusCode == 200 && response.data['status_code'] == 201) {
        result['success'] = true;
      }
    } catch (error) {
      result['error'] = error;
    }
    _isLoading = false;
    notifyListeners();
    return result;
  }

  void filterResurants(List<int> resturantsIds) {
    List<RestaurantModel> restaurants = [];
    _restaurants.forEach((restaurant) {
      if (resturantsIds.contains(restaurant.id)) {
        restaurants.add(restaurant);
      }
    });
    _filterRestaurants = restaurants;
  }

  void categoryRestaurantsFilter(int categoryId) {
    List<RestaurantModel> restaurants = [];
    _restaurants.forEach((restaurant) {
      if (restaurant.categoryId == categoryId) {
        restaurants.add(restaurant);
      }
    });
    _categoryRestaurants = restaurants;
  }

  void favoritesRestaurantsFilter(List<int> favorites) {
    List<RestaurantModel> restaurants = [];
    _restaurants.forEach((restaurant) {
      if (favorites.contains(restaurant.id)) {
        restaurants.add(restaurant);
      }
    });
    _favoritesRestaurants = restaurants;
  }

  Future<Map<String, dynamic>> addComment(int id, formData) async {
    final Map<String, dynamic> result = {'success': false, 'error': null};
    _isLoading = true;
    notifyListeners();
    String url = '/add_comment';
    httpService.init();
    var postData = {
      'id': id,
      'name': formData['name'],
      'email': formData['email'],
      'rate': formData['review'],
      'comment': formData['comment'],
    };

    try {
      Response response = await httpService.postRequest(url, postData, '');
      if (response.statusCode == 200 && response.data['status_code'] == 201) {
        result['success'] = true;
      }
    } catch (error) {
      result['error'] = error;
    }
    _isLoading = false;
    notifyListeners();
    return result;
  }
}
