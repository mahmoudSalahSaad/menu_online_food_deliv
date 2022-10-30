import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:menu_egypt/models/address.dart';
import 'package:menu_egypt/services/http_service_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressProvider extends ChangeNotifier {
  List<AddressModel> _addresses = [];
  bool _isLoading = false;
  final HttpServiceImpl httpService = HttpServiceImpl();

  AddressProvider() {
    getAddresses();
  }

  bool get isLoading {
    return _isLoading;
  }

  List<AddressModel> get addresses {
    return _addresses;
  }

  Future<Map<String, dynamic>> getAddresses() async {
    Map<String, dynamic> result = {'success': false, 'error': null};
    _isLoading = true;
    notifyListeners();
    String url = '/my-addresses';
    httpService.init();
    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      String token = preferences.getString('apiToken');
      print(token);
      Response response = await httpService.getRequest(url, token ?? '');
      print(response);
      if (response.statusCode == 200 && response.data['status'] == true) {
        print(response);
        var parsedAddresses = response.data['data'] as List;
        for (int i = 0; i < parsedAddresses.length; i++) {
          AddressModel addressModel = AddressModel(
            id: parsedAddresses[i]['id'],
            regionId: parsedAddresses[i]['region_id'],
            cityId: parsedAddresses[i]['city_id'],
            street: parsedAddresses[i]['street'],
            description: parsedAddresses[i]['description'],
            building: parsedAddresses[i]['building'],
            round: parsedAddresses[i]['round'],
            apartment: parsedAddresses[i]['apartment_number'],
            type: parsedAddresses[i]['type'],
            regionName: parsedAddresses[i]['region']['name'],
            cityName: parsedAddresses[i]['city']['name'],
          );
          _addresses.add(addressModel);
        }
        print('Success');
        print(_addresses.length);
        result['success'] = true;
      } else {
        print('Failed');
        result['error'] = response.data['message'];
      }
    } catch (error) {
      print('Catch');
      throw result['error'] = error;
    }
    _isLoading = false;
    notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> updateAdress(AddressModel addressModel) async {
    Map<String, dynamic> result = {'success': false, 'error': null};
    _isLoading = true;
    notifyListeners();
    String url = '/update-address';
    httpService.init();
    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      String token = preferences.getString('apiToken');
      print(token);
      Response response = await httpService.postRequest(
          url, addressModel.toJson(), token ?? '');
      print(response);
      if (response.statusCode == 200 && response.data['status'] == true) {
        print('Success');
        result['success'] = true;
      } else {
        print('Failed');
        result['error'] = response.data['message'];
      }
    } catch (error) {
      print('Catch');
      result['error'] = error;
    }
    _isLoading = false;
    notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> addAdress(AddressModel addressModel) async {
    Map<String, dynamic> result = {'success': false, 'error': null};
    _isLoading = true;
    notifyListeners();
    String url = '/add-new-address';
    httpService.init();
    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      String token = preferences.getString('apiToken');
      print(token);
      Response response = await httpService.postRequest(
          url, addressModel.toJson(), token ?? '');
      print(response);
      if (response.statusCode == 200 && response.data['status'] == true) {
        print('Success');
        result['success'] = true;
        _addresses.add(addressModel);
      } else {
        print('Failed');
        result['error'] = response.data['message'];
      }
    } catch (error) {
      print('Catch');
      result['error'] = error;
    }
    _isLoading = false;
    notifyListeners();
    return result;
  }
}
