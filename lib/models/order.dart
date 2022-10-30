class OrderModel {
  int id;
  int restId;
  String operationDate;
  String serialNumber;
  int countItems;
  int total;
  String orderStatus;

  OrderModel(
      {this.id,
      this.restId,
      this.operationDate,
      this.serialNumber,
      this.countItems,
      this.total,
      this.orderStatus});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restId = json['rest_id'];
    operationDate = json['operation_date'];
    serialNumber = json['serial_number'];
    countItems = json['count_items'];
    total = json['total'];
    orderStatus = json['order_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rest_id'] = this.restId;
    data['operation_date'] = this.operationDate;
    data['serial_number'] = this.serialNumber;
    data['count_items'] = this.countItems;
    data['total'] = this.total;
    data['order_status'] = this.orderStatus;
    return data;
  }
}
