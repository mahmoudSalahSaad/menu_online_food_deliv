import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:menu_egypt/models/order.dart';
import 'package:menu_egypt/services/http_service_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderProvider extends ChangeNotifier {
  List<OrderModel> _orders = [];
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
            id: parsedOrders[i]['id'],
            restId: parsedOrders[i]['rest_id'],
            operationDate: parsedOrders[i]['operation_date'],
            serialNumber: parsedOrders[i]['serial_number'],
            countItems: parsedOrders[i]['count_items'],
            orderStatus: parsedOrders[i]['order_status'],
            total: parsedOrders[i]['total'],
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
}
