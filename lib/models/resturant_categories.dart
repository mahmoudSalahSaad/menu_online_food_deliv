class ResturantCategoriesModel {
  int restId;
  num deliveryFee;
  int deliveryTime;
  List<CatgeoriesList> catgeoriesList;

  ResturantCategoriesModel(
      {this.restId, this.deliveryFee, this.deliveryTime, this.catgeoriesList});

  ResturantCategoriesModel.fromJson(Map<String, dynamic> json) {
    restId = json['rest_id'];
    deliveryFee = json['delivery_fee'];
    deliveryTime = json['delivery_time'];
    if (json['catgeories_list'] != null) {
      catgeoriesList = [];
      json['catgeories_list'].forEach((v) {
        catgeoriesList.add(new CatgeoriesList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rest_id'] = this.restId;
    if (this.catgeoriesList != null) {
      data['catgeories_list'] =
          this.catgeoriesList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CatgeoriesList {
  int catgeoryId;
  String catgeoryTitle;
  List<CatgeoryProducts> catgeoryProducts;

  CatgeoriesList({this.catgeoryId, this.catgeoryTitle, this.catgeoryProducts});

  CatgeoriesList.fromJson(Map<String, dynamic> json) {
    catgeoryId = json['catgeory_id'];
    catgeoryTitle = json['catgeory_title'];
    if (json['catgeory_products'] != null) {
      catgeoryProducts = [];
      json['catgeory_products'].forEach((v) {
        catgeoryProducts.add(new CatgeoryProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['catgeory_id'] = this.catgeoryId;
    data['catgeory_title'] = this.catgeoryTitle;
    if (this.catgeoryProducts != null) {
      data['catgeory_products'] =
          this.catgeoryProducts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CatgeoryProducts {
  int id;
  String title;
  String image;
  num price;
  num minPrice;
  num maxPrice;
  String shortDescription;
  String haveSizes;

  CatgeoryProducts(
      {this.id,
      this.title,
      this.image,
      this.price,
      this.minPrice,
      this.maxPrice,
      this.shortDescription,
      this.haveSizes});

  CatgeoryProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    price = json['price'];
    minPrice = json['min'];
    maxPrice = json['max'];
    shortDescription = json['short_description'];
    haveSizes = json['have_sizes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['price'] = this.price;
    data['min'] = this.minPrice;
    data['max'] = this.maxPrice;
    data['short_description'] = this.shortDescription;
    data['have_sizes'] = this.haveSizes;
    return data;
  }
}
