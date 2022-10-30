class AddressModel {
  int id, regionId, cityId;
  String round,
      apartment,
      street,
      building,
      regionName,
      cityName,
      type,
      description;

  AddressModel({
    this.id,
    this.regionId,
    this.cityId,
    this.round,
    this.apartment,
    this.street,
    this.building,
    this.regionName,
    this.cityName,
    this.type,
    this.description,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      regionId: json['region_id'],
      cityId: json['city_id'],
      round: json['round'],
      apartment: json['apartment_number'],
      street: json['street'],
      building: json['building'],
      regionName: json['regionName'],
      cityName: json['cityName'],
      type: json['type'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['region_id'] = this.regionId;
    data['city_id'] = this.cityId;
    data['round'] = this.round;
    data['apartment_number'] = this.apartment;
    data['street'] = this.street;
    data['building'] = this.building;
    data['regionName'] = this.regionName;
    data['cityName'] = this.cityName;
    data['type'] = this.type;
    data['description'] = this.description;
    return data;
  }
}
