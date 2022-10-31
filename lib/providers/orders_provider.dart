import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:menu_egypt/models/order.dart';
import 'package:menu_egypt/models/order_details.dart';
import 'package:menu_egypt/services/http_service_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderProvider extends ChangeNotifier {
  List<OrderModel> _orders = [];
  OrderDetailsModel orderDetailsModel;
  bool _isLoading = false;
  final HttpServiceImpl httpService = HttpServiceImpl();

  OrderProvider() {
    getOrders();
  }

  bool get isLoading {
    return _isLoading;
  }

  List<OrderModel> get orders {
    return _orders;
  }

  Future<Map<String, dynamic>> getOrders() async {
    Map<String, dynamic> result = {'success': false, 'error': null};
    _isLoading = true;
    notifyListeners();
    String url = '/orders';
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
        var parsedOrders = response.data['orders'] as List;
        for (int i = 0; i < parsedOrders.length; i++) {
          OrderModel orderModel = OrderModel(
            restId: parsedOrders[i]['rest_details']['id'],
            restName: parsedOrders[i]['rest_details']['name'],
            restLogo: parsedOrders[i]['rest_details']['logo'],
            id: parsedOrders[i]['order_details']['id'],
            operationDate: parsedOrders[i]['order_details']['date'],
            serialNumber: parsedOrders[i]['order_details']['serial_number'],
            countItems: parsedOrders[i]['order_details']['count_items'],
            total: parsedOrders[i]['order_details']['total'],
            orderStatus: parsedOrders[i]['order_details']['order_status'],
          );
          _orders.add(orderModel);
        }
        print('Success');
        print(_orders.length);
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

  Future<Map<String, dynamic>> getOrderDetails(String orderSerialNumber) async {
    Map<String, dynamic> result = {'success': false, 'error': null};
    _isLoading = true;
    notifyListeners();
    String url = '/view-order/$orderSerialNumber';
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

        var parsedDetials = response.data['details'];

        OrderDetailsModel detailsModel =
            OrderDetailsModel.fromJson(parsedDetials);
        orderDetailsModel = detailsModel;

        print('Success');
        result['success'] = true;
      } else {
        print('Failed');
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
