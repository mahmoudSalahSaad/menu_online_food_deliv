class OrderDetailsModel {
  RestDetails restDetails;
  OrderDetails orderDetails;
  List<ItemDetails> itemDetails;

  OrderDetailsModel({this.restDetails, this.orderDetails, this.itemDetails});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    restDetails = json['rest_details'] != null
        ? new RestDetails.fromJson(json['rest_details'])
        : null;
    orderDetails = json['order_details'] != null
        ? new OrderDetails.fromJson(json['order_details'])
        : null;
    if (json['item_details'] != null) {
      itemDetails = [];
      json['item_details'].forEach((v) {
        itemDetails.add(new ItemDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.restDetails != null) {
      data['rest_details'] = this.restDetails.toJson();
    }
    if (this.orderDetails != null) {
      data['order_details'] = this.orderDetails.toJson();
    }
    if (this.itemDetails != null) {
      data['item_details'] = this.itemDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RestDetails {
  int id;
  String name;
  String logo;

  RestDetails({this.id, this.name, this.logo});

  RestDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    return data;
  }
}

class OrderDetails {
  int id;
  String date;
  String serialNumber;
  int countItems;
  int subTotal;
  int deliveryFee;
  int total;
  int deliveryTime;
  String orderStatus;
  String notes;
  Address address;

  OrderDetails(
      {this.id,
      this.date,
      this.serialNumber,
      this.countItems,
      this.subTotal,
      this.deliveryFee,
      this.total,
      this.deliveryTime,
      this.orderStatus,
      this.notes,
      this.address});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    serialNumber = json['serial_number'];
    countItems = json['count_items'];
    subTotal = json['sub_total'];
    deliveryFee = json['delivery_fee'];
    total = json['total'];
    deliveryTime = json['delivery_time'];
    orderStatus = json['order_status'];
    notes = json['notes'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['serial_number'] = this.serialNumber;
    data['count_items'] = this.countItems;
    data['sub_total'] = this.subTotal;
    data['delivery_fee'] = this.deliveryFee;
    data['total'] = this.total;
    data['delivery_time'] = this.deliveryTime;
    data['order_status'] = this.orderStatus;
    data['notes'] = this.notes;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    return data;
  }
}

class Address {
  String regionName;
  String cityIName;
  String neighborhood;
  String street;
  String building;
  String round;
  String apartmentNumber;
  String type;
  String addressDescription;
  String description;

  Address(
      {this.regionName,
      this.cityIName,
      this.neighborhood,
      this.street,
      this.building,
      this.round,
      this.apartmentNumber,
      this.type,
      this.addressDescription,
      this.description});

  Address.fromJson(Map<String, dynamic> json) {
    regionName = json['region_id'] ?? '';
    cityIName = json['city_id'] ?? '';
    neighborhood = json['neighborhood'] ?? '';
    street = json['street'] ?? '';
    building = json['building'] ?? '';
    round = json['round'] ?? '';
    apartmentNumber = json['apartment_number'] ?? '';
    type = json['type'];
    addressDescription = json['address_description'] ?? '';
    description = json['description'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['region_name'] = this.regionName;
    data['city_name'] = this.cityIName;
    data['neighborhood'] = this.neighborhood;
    data['street'] = this.street;
    data['building'] = this.building;
    data['round'] = this.round;
    data['apartment_number'] = this.apartmentNumber;
    data['type'] = this.type;
    data['address_description'] = this.addressDescription;
    data['description'] = this.description;
    return data;
  }
}

class ItemDetails {
  int id;
  String product;
  String size;
  String addition1;
  String addition2;
  int sizeId;
  int addition1Id;
  int addition2Id;
  int quantity;
  int subTotal;
  int total;

  ItemDetails(
      {this.id,
      this.product,
      this.size,
      this.addition1,
      this.addition2,
      this.sizeId,
      this.addition1Id,
      this.addition2Id,
      this.quantity,
      this.subTotal,
      this.total});

  ItemDetails.fromJson(Map<String, dynamic> json) {
    id = json['product_id'];
    product = json['product'];
    size = json['size'];
    addition1 = json['addition1'];
    addition2 = json['addition2'];
    sizeId = json['size_id'];
    addition1Id = json['addition1_id'];
    addition2Id = json['addition2_id'];
    quantity = json['quantity'];
    subTotal = json['sub_total'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.id;
    data['product'] = this.product;
    data['size'] = this.size;
    data['addition1'] = this.addition1;
    data['addition2'] = this.addition2;
    data['size_id'] = this.sizeId;
    data['addition1_id'] = this.addition1Id;
    data['addition2_id'] = this.addition2Id;
    data['quantity'] = this.quantity;
    data['sub_total'] = this.subTotal;
    data['total'] = this.total;
    return data;
  }
}
