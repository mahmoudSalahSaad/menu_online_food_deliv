import 'package:menu_egypt/models/cart_item.dart';

class CartModel {
  int resturantId = 0, deliveryTime = 0;
  num deliveryPrice = 0.0, subTotalPrice = 0.0, totalPrice = 0.0;
  String resturantName = '', resturantLogo = '';
  List<CartItemModel> cartItems = [];

  CartModel({
    this.resturantId,
    this.deliveryTime,
    this.deliveryPrice,
    this.subTotalPrice,
    this.totalPrice,
    this.resturantName,
    this.resturantLogo,
    this.cartItems,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    CartModel(
      resturantId: json['resturantId'],
      deliveryTime: json['deliveryTime'],
      deliveryPrice: json['deliveryPrice'],
      subTotalPrice: json['subTotalPrice'],
      totalPrice: json['totalPrice'],
      resturantName: json['resturantName'],
      resturantLogo: json['resturantLogo'],
      cartItems: json['cartItems'].forEach((e) {
        cartItems.add(CartItemModel.fromJson(e));
      }),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    List<Map> items = this.cartItems != null
        ? this.cartItems.map((i) => i.toJson()).toList()
        : null;
    data['resturantId'] = this.resturantId;
    data['deliveryTime'] = this.deliveryTime;
    data['deliveryPrice'] = this.deliveryPrice;
    data['subTotalPrice'] = this.subTotalPrice;
    data['totalPrice'] = this.totalPrice;
    data['resturantName'] = this.resturantName;
    data['resturantLogo'] = this.resturantLogo;
    data['cartItems'] = items;
    return data;
  }
}
