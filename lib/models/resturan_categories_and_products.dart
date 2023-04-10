class ResturantCategoriesAndProducts {
  bool? status;
  String? errorNumber;
  String? message;
  ResturantData? resturantData;

  ResturantCategoriesAndProducts(
      {this.status, this.errorNumber, this.message, this.resturantData});

  ResturantCategoriesAndProducts.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorNumber = json['errorNumber'];
    message = json['message'];
    resturantData =
        json['data'] != null ? new ResturantData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errorNumber'] = this.errorNumber;
    data['message'] = this.message;
    if (this.resturantData != null) {
      data['data'] = this.resturantData!.toJson();
    }
    return data;
  }
}

class ResturantData {
  int? restId;
  num? deliveryFee;
  int? deliveryTime;
  List<CatgeoriesList>? catgeoriesList;

  ResturantData(
      {this.restId, this.deliveryFee, this.deliveryTime, this.catgeoriesList});

  ResturantData.fromJson(Map<String, dynamic> json) {
    restId = json['rest_id'];
    deliveryFee = json['delivery_fee'];
    deliveryTime = json['delivery_time'];
    if (json['catgeories_list'] != null) {
      catgeoriesList = [];
      json['catgeories_list'].forEach((v) {
        catgeoriesList!.add(new CatgeoriesList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rest_id'] = this.restId;
    data['delivery_fee'] = this.deliveryFee;
    data['delivery_time'] = this.deliveryTime;
    if (this.catgeoriesList != null) {
      data['catgeories_list'] =
          this.catgeoriesList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CatgeoriesList {
  int? catgeoryId;
  String? catgeoryTitle;
  List<CatgeoryProduct>? catgeoryProducts;

  CatgeoriesList({this.catgeoryId, this.catgeoryTitle, this.catgeoryProducts});

  CatgeoriesList.fromJson(Map<String, dynamic> json) {
    catgeoryId = json['catgeory_id'];
    catgeoryTitle = json['catgeory_title'];
    if (json['catgeory_products'] != null) {
      catgeoryProducts = [];
      json['catgeory_products'].forEach((v) {
        catgeoryProducts!.add(new CatgeoryProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['catgeory_id'] = this.catgeoryId;
    data['catgeory_title'] = this.catgeoryTitle;
    if (this.catgeoryProducts != null) {
      data['catgeory_products'] =
          this.catgeoryProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CatgeoryProduct {
  Product? product;
  List<Sizes>? sizes;
  String? firstAdditionTitle;
  List<FirstAdditionsData>? firstAdditionsData;
  String? secondAdditionTitle;
  List<SecondAdditionsData>? secondAdditionsData;

  CatgeoryProduct(
      {this.product,
      this.sizes,
      this.firstAdditionTitle,
      this.firstAdditionsData,
      this.secondAdditionTitle,
      this.secondAdditionsData});

  CatgeoryProduct.fromJson(Map<String, dynamic> json) {
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
    data['product'] = this.product!.toJson();
    data['sizes'] = this.sizes!.map((v) => v.toJson()).toList();
    data['first_addition_title'] = this.firstAdditionTitle;
    data['first_additions_data'] =
        this.firstAdditionsData!.map((v) => v.toJson()).toList();
    data['second_addition_title'] = this.secondAdditionTitle;
    data['second_additions_data'] =
        this.secondAdditionsData!.map((v) => v.toJson()).toList();
    return data;
  }
}

class Product {
  int? id;
  String? title;
  String? image;
  num? price;
  num? min;
  num? max;
  String? shortDescription;
  String? haveSizes;

  Product(
      {this.id,
      this.title,
      this.image,
      this.price,
      this.min,
      this.max,
      this.shortDescription,
      this.haveSizes});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    price = json['price'];
    min = json['min'];
    max = json['max'];
    shortDescription = json['short_description'];
    haveSizes = json['have_sizes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['price'] = this.price;
    data['min'] = this.min;
    data['max'] = this.max;
    data['short_description'] = this.shortDescription;
    data['have_sizes'] = this.haveSizes;
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
