import 'package:menu_egypt/models/resturan_categories_and_products.dart';

class CartItemModel {
  int id, quantity, weightId, firstAddId, secondAddId;
  num price, firstAddonPrice, secondAddonPrice;
  String name, description, weight, firstAddonName, secondAddonName, photoUrl;
  CatgeoryProduct product;

  CartItemModel({
    this.id,
    this.weightId,
    this.firstAddId,
    this.secondAddId,
    this.quantity,
    this.price,
    this.firstAddonPrice = 0.0,
    this.secondAddonPrice = 0.0,
    this.name,
    this.description,
    this.weight,
    this.firstAddonName,
    this.secondAddonName,
    this.photoUrl,
    this.product,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      weightId: json['weightId'],
      firstAddId: json['firstAddId'],
      secondAddId: json['secondAddId'],
      quantity: json['quantity'],
      price: json['price'],
      firstAddonPrice: json['firstAddonPrice'],
      secondAddonPrice: json['secondAddonPrice'],
      name: json['name'],
      description: json['description'],
      weight: json['weight'],
      firstAddonName: json['firstAddonName'],
      secondAddonName: json['secondAddonName'],
      photoUrl: json['photoUrl'],
      product: CatgeoryProduct.fromJson(json['product']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['weightId'] = this.weightId;
    data['firstAddId'] = this.firstAddId;
    data['secondAddId'] = this.secondAddId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['firstAddonPrice'] = this.firstAddonPrice;
    data['secondAddonPrice'] = this.secondAddonPrice;
    data['name'] = this.name;
    data['description'] = this.description;
    data['weight'] = this.weight;
    data['firstAddonName'] = this.firstAddonName;
    data['secondAddonName'] = this.secondAddonName;
    data['product'] = this.product.toJson();
    return data;
  }
}
