import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:menu_egypt/models/cart.dart';
import 'package:menu_egypt/models/cart_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:menu_egypt/services/http_service_impl.dart';

class CartProvider extends ChangeNotifier {
  bool _isLoading = false;
  CartModel _cart;
  final HttpServiceImpl httpService = HttpServiceImpl();

  CartProvider() {
    initCart();
  }

  bool get isLoading {
    return _isLoading;
  }

  CartModel get cart {
    return _cart;
  }

  initCart() async {
    _isLoading = true;
    notifyListeners();
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final json = preferences.getString('cart') ?? '';
    print('cart::: ' + json);
    if (json.isNotEmpty) {
      Map<String, dynamic> map = jsonDecode(json);
      _cart = CartModel.fromJson(map);
      _cart.resturantId = map['resturantId'];
      _cart.deliveryPrice = map['deliveryPrice'];
      _cart.deliveryTime = map['deliveryTime'];
      _cart.resturantName = map['resturantName'];
      _cart.resturantLogo = map['resturantLogo'];
      _cart.subTotalPrice = calculateCartSubtotal();
      _cart.totalPrice = calculateCartTotal();
    } else {
      _cart = CartModel(
          cartItems: [],
          resturantId: 0,
          deliveryTime: 0,
          deliveryPrice: 0.0,
          subTotalPrice: 0.0,
          totalPrice: 0.0,
          resturantName: '',
          resturantLogo: '');
    }
    _isLoading = false;
    notifyListeners();
  }

  num calculateCartSubtotal() {
    num subTotal = 0.0;
    for (CartItemModel cartItem in _cart.cartItems) {
      subTotal += cartItem.quantity * cartItem.price;
    }
    return subTotal;
  }

  num calculateCartTotal() {
    num total = 0.0;
    total = _cart.subTotalPrice + _cart.deliveryPrice;
    return total;
  }

  addItemToCart(CartItemModel cartItem, int resturantId, num deliveryPrice,
      int deliveryTime, String resturantName, String resturantLogo) async {
    bool theSameItemExistsInCart = false;
    //if the same item is found in cart .. update it's quantity
    for (CartItemModel item in _cart.cartItems) {
      if (cartItem.id == item.id &&
          cartItem.weightId == item.weightId &&
          cartItem.firstAddId == item.firstAddId &&
          cartItem.secondAddId == item.secondAddId) {
        item.quantity += cartItem.quantity;
        theSameItemExistsInCart = true;
        break;
      }
    }
    //if first item to add to cart OR the item is new item
    if (_cart.cartItems.isEmpty || !theSameItemExistsInCart) {
      _cart.cartItems.add(cartItem);
    }
    _cart.resturantId = resturantId;
    _cart.deliveryTime = deliveryTime;
    _cart.deliveryPrice = deliveryPrice.toDouble();
    _cart.resturantName = resturantName;
    _cart.resturantLogo = resturantLogo;
    _cart.subTotalPrice = calculateCartSubtotal();
    _cart.totalPrice = calculateCartTotal();
    await updateCartToSharedPref();
    notifyListeners();
  }

  removeItemFromCart(int itemIndex) async {
    _cart.cartItems.removeAt(itemIndex);
    _cart.subTotalPrice = calculateCartSubtotal();
    _cart.totalPrice = calculateCartTotal();
    if (_cart.cartItems.isEmpty) {
      _cart.resturantId = 0;
    }
    await updateCartToSharedPref();
    notifyListeners();
  }

  clearCart() async {
    _cart.cartItems.clear();
    _cart.resturantId = 0;
    _cart.resturantName = '';
    _cart.resturantLogo = '';
    _cart.deliveryTime = 0;
    _cart.deliveryPrice = 0.0;
    _cart.subTotalPrice = 0.0;
    _cart.totalPrice = 0.0;
    await removeCartFromShredPref();
    notifyListeners();
  }

  editCartItem(CartItemModel item, int itemIndex) async {
    //if the same item is found in cart .. update it's quantity
    bool theSameItemExistsInCart = false;

    for (CartItemModel i in _cart.cartItems) {
      if (item.id == i.id &&
          item.weightId == i.weightId &&
          item.firstAddId == i.firstAddId &&
          item.secondAddId == i.secondAddId) {
        theSameItemExistsInCart = true;
        if (itemIndex != _cart.cartItems.indexOf(i)) {
          i.quantity += item.quantity;
          _cart.cartItems.removeAt(itemIndex);
        } else {
          i.quantity = item.quantity;
        }
        break;
      }
    }
    //The item is a new item to edit
    if (!theSameItemExistsInCart) {
      _cart.cartItems[itemIndex] = item;
      print(_cart.cartItems[itemIndex].product.product.title);
    }
    _cart.subTotalPrice = calculateCartSubtotal();
    _cart.totalPrice = calculateCartTotal();
    await updateCartToSharedPref();
    notifyListeners();
  }

  updateCartToSharedPref() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, dynamic> json = _cart.toJson();
    print(json);
    preferences.setString('cart', jsonEncode(json));
  }

  removeCartFromShredPref() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('cart');
  }

  Future<Map<String, dynamic>> checkOut(int addressId, String notes) async {
    Map<String, dynamic> result = {
      'success': false,
      'error': null,
      'orderSerialNumber': null
    };
    _isLoading = true;
    notifyListeners();
    String url = '/checkout';
    httpService.init();
    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      String token = preferences.getString('apiToken');
      print(token);
      print(_cart.resturantId);

      List<Map<String, dynamic>> cartItemsList = [];
      for (CartItemModel item in _cart.cartItems) {
        if (item.weightId != 0 &&
            item.firstAddId != 0 &&
            item.secondAddId != 0) {
          cartItemsList.add({
            "id": item.id,
            "rest_id": _cart.resturantId,
            "size_id": item.weightId,
            "addition1_id": item.firstAddId,
            "addition2_id": item.secondAddId,
            "quantity": item.quantity
          });
        } else if (item.weightId == 0 &&
            item.firstAddId == 0 &&
            item.secondAddId == 0) {
          cartItemsList.add({
            "id": item.id,
            "rest_id": _cart.resturantId,
            "quantity": item.quantity
          });
        } else if (item.weightId == 0 &&
            item.firstAddId != 0 &&
            item.secondAddId != 0) {
          cartItemsList.add({
            "id": item.id,
            "rest_id": _cart.resturantId,
            "addition1_id": item.firstAddId,
            "addition2_id": item.secondAddId,
            "quantity": item.quantity
          });
        } else if (item.weightId != 0 &&
            item.firstAddId == 0 &&
            item.secondAddId != 0) {
          cartItemsList.add({
            "id": item.id,
            "rest_id": _cart.resturantId,
            "size_id": item.weightId,
            "addition2_id": item.secondAddId,
            "quantity": item.quantity
          });
        } else if (item.weightId != 0 &&
            item.firstAddId != 0 &&
            item.secondAddId == 0) {
          cartItemsList.add({
            "id": item.id,
            "rest_id": _cart.resturantId,
            "size_id": item.weightId,
            "addition1_id": item.firstAddId,
            "quantity": item.quantity
          });
        } else if (item.weightId != 0 &&
            item.firstAddId == 0 &&
            item.secondAddId == 0) {
          cartItemsList.add({
            "id": item.id,
            "rest_id": _cart.resturantId,
            "size_id": item.weightId,
            "quantity": item.quantity
          });
        }
      }
      /*
      for (CartItemModel item in _cart.cartItems) {
        print(addressId);
        print(_cart.resturantId);
        print(item.id);
        print(item.name);
        print(item.weightId);
      }
      */
      Map<String, dynamic> cartMap = {
        'rest_id': _cart.resturantId,
        'payment_type': 1,
        'address_id': addressId,
        'notes': notes,
        'cart': cartItemsList,
      };
      Response response =
          await httpService.postRequest(url, cartMap, token ?? '');
      print(response);
      if (response.statusCode == 200 && response.data['status'] == true) {
        result['orderSerialNumber'] = response.data['serial_number'];
        print('Success');
        result['error'] = response.data['message'];
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
}
