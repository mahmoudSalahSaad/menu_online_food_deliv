import 'package:menu_egypt/models/cart_item.dart';

class CartModel {
  double deliveryPrice = 0.0, subTotalPrice = 0.0, totalPrice = 0.0;
  List<CartItemModel> cartItems = [];

  CartModel({
    this.deliveryPrice,
    this.subTotalPrice,
    this.totalPrice,
    this.cartItems,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    CartModel(
      deliveryPrice: json['deliveryPrice'],
      subTotalPrice: json['subTotalPrice'],
      totalPrice: json['totalPrice'],
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
    data['deliveryPrice'] = this.deliveryPrice;
    data['subTotalPrice'] = this.subTotalPrice;
    data['totalPrice'] = this.totalPrice;
    data['cartItems'] = items;
    return data;
  }
}
