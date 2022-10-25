class RestaurantModel {
  final int id;
  final String nameAr;
  final String nameEn;
  final String logoSmall;
  final String phoneNumber1, phoneNumber2, phoneNumber3;
  final int categoryId;
  final String viewTimes;
  final int review;
  String date;
  List<String> images;
  List<Map<String, dynamic>> branches;
  List<int> regions;
  List<String> areas;

  RestaurantModel(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.logoSmall,
      this.phoneNumber1,
      this.phoneNumber2,
      this.phoneNumber3,
      this.categoryId,
      this.review,
      this.viewTimes,
      this.branches,
      this.regions,
      this.areas,
      this.images,
      this.date});
}
