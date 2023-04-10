class ResturantProductModel {
  Product? product;
  List<Sizes>? sizes;
  String? firstAdditionTitle;
  List<FirstAdditionsData>? firstAdditionsData;
  String? secondAdditionTitle;
  List<SecondAdditionsData>? secondAdditionsData;

  ResturantProductModel(
      {this.product,
      this.sizes,
      this.firstAdditionTitle,
      this.firstAdditionsData,
      this.secondAdditionTitle,
      this.secondAdditionsData});

  ResturantProductModel.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    if (json['sizes'] != null) {
      sizes = [];
      json['sizes'].forEach((v) {
        sizes!.add(new Sizes.fromJson(v));
      });
    }
    firstAdditionTitle = json['first_addition_title'];
    if (json['first_additions_data'] != null) {
      firstAdditionsData = [];
      json['first_additions_data'].forEach((v) {
        firstAdditionsData!.add(new FirstAdditionsData.fromJson(v));
      });
    }
    secondAdditionTitle = json['second_addition_title'];
    if (json['second_additions_data'] != null) {
      secondAdditionsData = [];
      json['second_additions_data'].forEach((v) {
        secondAdditionsData!.add(new SecondAdditionsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.sizes != null) {
      data['sizes'] = this.sizes!.map((v) => v.toJson()).toList();
    }
    data['first_addition_title'] = this.firstAdditionTitle;
    if (this.firstAdditionsData != null) {
      data['first_additions_data'] =
          this.firstAdditionsData!.map((v) => v.toJson()).toList();
    }
    data['second_addition_title'] = this.secondAdditionTitle;
    if (this.secondAdditionsData != null) {
      data['second_additions_data'] =
          this.secondAdditionsData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  int? id;
  int? restId;
  int? categoryId;
  String? title;
  String? image;
  num? price;
  String? shortDescription;
  String? productHaveSizes;

  Product(
      {this.id,
      this.restId,
      this.categoryId,
      this.title,
      this.image,
      this.price,
      this.shortDescription,
      this.productHaveSizes});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restId = json['rest_id'];
    categoryId = json['category_id'];
    title = json['title'];
    image = json['image'];
    price = json['price'];
    shortDescription = json['short_description'];
    productHaveSizes = json['product_have_sizes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rest_id'] = this.restId;
    data['category_id'] = this.categoryId;
    data['title'] = this.title;
    data['image'] = this.image;
    data['price'] = this.price;
    data['short_description'] = this.shortDescription;
    data['product_have_sizes'] = this.productHaveSizes;
    return data;
  }
}

class Sizes {
  int? id;
  String? title;
  num? price;

  Sizes({this.id, this.title, this.price});

  Sizes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    return data;
  }
}

class FirstAdditionsData {
  int? id;
  String? title;

  FirstAdditionsData({this.id, this.title});

  FirstAdditionsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}

class SecondAdditionsData {
  int? id;
  String? title;

  SecondAdditionsData({this.id, this.title});

  SecondAdditionsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
