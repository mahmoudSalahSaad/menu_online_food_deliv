class OrderModel {
  int id;
  int restId;
  String restName;
  String restLogo;
  String operationDate;
  String serialNumber;
  int countItems;
  int total;
  String orderStatus;

  OrderModel(
      {this.restId,
      this.restName,
      this.restLogo,
      this.id,
      this.operationDate,
      this.serialNumber,
      this.countItems,
      this.total,
      this.orderStatus});

  OrderModel.fromJson(Map<String, dynamic> json) {
    restId = json['rest_details']['id'];
    restName = json['rest_details']['name'];
    restLogo = json['rest_details']['logo'];

    id = json['order_details']['id'];
    operationDate = json['order_details']['date'];
    serialNumber = json['order_details']['serial_number'];
    countItems = json['order_details']['count_items'];
    total = json['order_details']['total'];
    orderStatus = json['order_details']['order_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rest_details']['id'] = this.restId;
    data['rest_details']['name'] = this.restName;
    data['rest_details']['logo'] = this.restLogo;

    data['order_details']['id'] = this.id;
    data['order_details']['date'] = this.operationDate;
    data['order_details']['serial_number'] = this.serialNumber;
    data['order_details']['count_items'] = this.countItems;
    data['order_details']['total'] = this.total;
    data['order_details']['order_status'] = this.orderStatus;
    return data;
  }
}
