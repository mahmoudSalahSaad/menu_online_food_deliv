import 'package:menu_egypt/models/cart_item.dart';

class ResturantItemModel {
  int categoryId;
  String categoryName;
  List<CartItemModel> items = [];

  ResturantItemModel({this.categoryId, this.categoryName, this.items});

  factory ResturantItemModel.fromJson(Map<String, dynamic> json) {
    return ResturantItemModel(
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      items: (json['items'] as List)
          ?.map((cartItem) => cartItem as CartItemModel)
          ?.toList(),
    );
  }

  Map<String, dynamic> toJson(ResturantItemModel instance) => <String, dynamic>{
        'categoryId': instance.categoryId,
        'categoryName': instance.categoryName,
        'items': instance.items,
      };
}
