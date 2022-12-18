import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/components/city_drop_down.dart';
import 'package:menu_egypt/components/region_drop_down.dart';
import 'package:menu_egypt/models/City.dart';
import 'package:menu_egypt/models/Region.dart';
import 'package:menu_egypt/models/address.dart';
import 'package:menu_egypt/providers/address_provider.dart';
import 'package:menu_egypt/providers/city_provider.dart';
import 'package:menu_egypt/providers/home_provider.dart';
import 'package:menu_egypt/providers/region_provider.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_search/dropdown_search.dart';

void addNewAddressBottomSheet(BuildContext context) {
  TextEditingController cityIdController = TextEditingController();
  TextEditingController regionIdController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController roundController = TextEditingController();
  TextEditingController apartmentController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<CityModel> cities;
  List<RegionModel> regions;
  CityModel city;
  RegionModel region;
  final homeProvider = Provider.of<HomeProvider>(context, listen: false);
  //city dropdown
  final cityProvider = Provider.of<CityProvider>(context, listen: false);
  cityProvider.setCities(homeProvider.cities);
  cities = cityProvider.cities;
  city = cities[0];
  //region dropdown
  final regionProvider = Provider.of<RegionProvider>(context, listen: false);
  regionProvider.setRegions(homeProvider.regions);
  regions = regionProvider.regionsOfCity(city.cityId);
  region = regions[15];
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (builder) {
      return StatefulBuilder(
        builder: (context, setBottomSheetState) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.60,
              color:
                  Colors.transparent, //could change this to Color(0xFF737373),
              //so you don't have to change MaterialApp canvasColor
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'عنوان جديد',
                          style: TextStyle(
                            color: kAppBarColor,
                            fontSize: getProportionateScreenHeight(20),
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(4),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: kAppBarColor,
                                border: Border.all(
                                  color: kAppBarColor,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: DropdownSearch<CityModel>(
                              items: cities,
                              itemAsString: (CityModel c) => c.nameAr,
                              onChanged: (CityModel cityModel) {
                                setBottomSheetState(() {
                                  city = cityModel;
                                  regions = Provider.of<RegionProvider>(context,
                                          listen: false)
                                      .regionsOfCity(city.cityId);
                                  if (cityModel.cityId == cities[18].cityId) {
                                    region = regions[24];
                                  } else {
                                    region = regions[0];
                                  }
                                  cityIdController.text =
                                      city.cityId.toString();
                                  print(cityIdController.text);
                                });
                              },
                              dropdownSearchDecoration: InputDecoration(
                                hintText: 'اختر المحافظة',
                                contentPadding: EdgeInsets.all(8),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                              ),
                            )
                            /*CityDropDownField(
                              items: cities,
                              value: city,
                              onChanged: (CityModel cityModel) {
                                setBottomSheetState(() {
                                  city = cityModel;
                                  regions = Provider.of<RegionProvider>(context,
                                          listen: false)
                                      .regionsOfCity(city.cityId);
                                  if (cityModel.cityId == cities[18].cityId) {
                                    region = regions[24];
                                  } else {
                                    region = regions[0];
                                  }
                                  cityIdController.text = city.cityId.toString();
                                  print(cityIdController.text);
                                });
                              }),*/
                            ),
                        SizedBox(
                          height: getProportionateScreenHeight(4),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: kAppBarColor,
                                border: Border.all(
                                  color: kAppBarColor,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: DropdownSearch<RegionModel>(
                              items: regions,
                              itemAsString: (RegionModel c) => c.nameAr,
                              onChanged: (RegionModel regionModel) {
                                setBottomSheetState(() {
                                  region = regionModel;
                                  regionIdController.text =
                                      region.regionId.toString();
                                  print(regionIdController.text);
                                });
                              },
                              dropdownSearchDecoration: InputDecoration(
                                hintText: 'اختر المنطقة',
                                contentPadding: EdgeInsets.all(8),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                              ),
                            )
                            /*RegionDropDownField(
                            items: regions,
                            value: region,
                            onChanged: (RegionModel regionModel) {
                              setBottomSheetState(() {
                                region = regionModel;
                                regionIdController.text =
                                    region.regionId.toString();
                                print(regionIdController.text);
                              });
                            },
                          ),*/
                            ),
                        SizedBox(
                          height: getProportionateScreenHeight(4),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: kAppBarColor,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: streetController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                FontAwesomeIcons.streetView,
                                color: kAppBarColor,
                                size: getProportionateScreenHeight(20),
                              ),
                              hintText: 'الشارع',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(4),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: kAppBarColor,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: buildingController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                FontAwesomeIcons.building,
                                color: kAppBarColor,
                                size: getProportionateScreenHeight(20),
                              ),
                              hintText: 'رقم العمارة',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(4),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: kAppBarColor,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: roundController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                FontAwesomeIcons.stairs,
                                color: kAppBarColor,
                                size: getProportionateScreenHeight(20),
                              ),
                              hintText: 'الدور',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(4),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: kAppBarColor,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: apartmentController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                FontAwesomeIcons.house,
                                color: kAppBarColor,
                                size: getProportionateScreenHeight(20),
                              ),
                              hintText: 'رقم الشقة',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(4),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: kAppBarColor,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: descriptionController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                FontAwesomeIcons.noteSticky,
                                color: kAppBarColor,
                                size: getProportionateScreenHeight(20),
                              ),
                              hintText: 'وصف',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(4),
                        ),
                        MaterialButton(
                          onPressed: () {
                            AddressModel addressModel = AddressModel(
                              street: streetController.text,
                              building: buildingController.text,
                              apartment: apartmentController.text,
                              description: descriptionController.text,
                              round: roundController.text,
                              cityId: cityIdController.text.isEmpty
                                  ? 0
                                  : int.parse(cityIdController.text),
                              regionId: regionIdController.text.isEmpty
                                  ? 0
                                  : int.parse(regionIdController.text),
                              type: 'work',
                            );
                            if (cityIdController.text.isEmpty ||
                                regionIdController.text.isEmpty ||
                                streetController.text.isEmpty ||
                                buildingController.text.isEmpty ||
                                apartmentController.text.isEmpty ||
                                roundController.text.isEmpty) {
                              dialog('من فضلك أدخل العنوان كاملا');
                            } else {
                              Provider.of<AddressProvider>(context,
                                      listen: false)
                                  .addAdress(addressModel);
                              Get.back();
                            }
                          },
                          minWidth: MediaQuery.of(context).size.width,
                          color: kAppBarColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text('اضف عنوان جديد'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

void editAddressBottomSheet(BuildContext context, AddressModel addressModel) {
  TextEditingController cityIdController =
      TextEditingController(text: addressModel.cityId.toString());

  TextEditingController regionIdController =
      TextEditingController(text: addressModel.regionId.toString());

  TextEditingController streetController =
      TextEditingController(text: addressModel.street);
  TextEditingController buildingController =
      TextEditingController(text: addressModel.building);
  TextEditingController apartmentController =
      TextEditingController(text: addressModel.apartment);
  TextEditingController descriptionController =
      TextEditingController(text: addressModel.description);
  TextEditingController roundController =
      TextEditingController(text: addressModel.round);
  List<CityModel> cities;
  List<RegionModel> regions;
  CityModel city;
  RegionModel region;
  final homeProvider = Provider.of<HomeProvider>(context, listen: false);
  //city dropdown
  final cityProvider = Provider.of<CityProvider>(context, listen: false);
  cityProvider.setCities(homeProvider.cities);
  cities = cityProvider.cities;
  city = cityProvider.getCityById(addressModel.cityId);

  //region dropdown
  final regionProvider = Provider.of<RegionProvider>(context, listen: false);
  regionProvider.setRegions(homeProvider.regions);
  region = regionProvider.getRegionById(addressModel.regionId);
  regions = regionProvider.regionsOfCity(city.cityId);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (builder) {
      return StatefulBuilder(
        builder: (context, setBottomSheetState) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.80,
              color:
                  Colors.transparent, //could change this to Color(0xFF737373),
              //so you don't have to change MaterialApp canvasColor
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'تعديل العنوان',
                          style: TextStyle(
                            color: kAppBarColor,
                            fontSize: getProportionateScreenHeight(20),
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(4),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: kAppBarColor,
                              border: Border.all(
                                color: kAppBarColor,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: CityDropDownField(
                              items: cities,
                              value: city,
                              onChanged: (CityModel cityModel) {
                                setBottomSheetState(() {
                                  city = cityModel;
                                  regions = Provider.of<RegionProvider>(context,
                                          listen: false)
                                      .regionsOfCity(city.cityId);
                                  if (cityModel.cityId == cities[18].cityId) {
                                    region = regions[24];
                                    regionIdController.text =
                                        region.regionId.toString();
                                  } else {
                                    region = regions[0];
                                    regionIdController.text =
                                        region.regionId.toString();
                                  }
                                  cityIdController.text =
                                      city.cityId.toString();
                                  print(cityIdController.text);
                                });
                              }),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(4),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: kAppBarColor,
                              border: Border.all(
                                color: kAppBarColor,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: RegionDropDownField(
                            items: regions,
                            value: region,
                            onChanged: (RegionModel regionModel) {
                              setBottomSheetState(() {
                                region = regionModel;
                                regionIdController.text =
                                    region.regionId.toString();
                                print(regionIdController.text);
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(4),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: kAppBarColor,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: streetController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                FontAwesomeIcons.streetView,
                                color: kAppBarColor,
                                size: getProportionateScreenHeight(20),
                              ),
                              prefix: Text('شارع'),
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(4),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: kAppBarColor,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: buildingController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                FontAwesomeIcons.building,
                                color: kAppBarColor,
                                size: getProportionateScreenHeight(20),
                              ),
                              prefix: Text('عمارة'),
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(4),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: kAppBarColor,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: roundController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                FontAwesomeIcons.stairs,
                                color: kAppBarColor,
                                size: getProportionateScreenHeight(20),
                              ),
                              prefix: Text('الدور'),
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(4),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: kAppBarColor,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: apartmentController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                FontAwesomeIcons.house,
                                color: kAppBarColor,
                                size: getProportionateScreenHeight(20),
                              ),
                              prefix: Text('شقة'),
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(4),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: kAppBarColor,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: descriptionController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                FontAwesomeIcons.noteSticky,
                                color: kAppBarColor,
                                size: getProportionateScreenHeight(20),
                              ),
                              prefix: Text('وصف'),
                              hintText: addressModel.description,
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(4),
                        ),
                        MaterialButton(
                          onPressed: () {
                            addressModel.cityId =
                                int.parse(cityIdController.text);
                            addressModel.regionId =
                                int.parse(regionIdController.text);
                            addressModel.street = streetController.text;
                            addressModel.building = buildingController.text;
                            addressModel.apartment = apartmentController.text;
                            addressModel.description =
                                descriptionController.text;
                            addressModel.round = roundController.text;
                            if (streetController.text.isEmpty ||
                                buildingController.text.isEmpty ||
                                apartmentController.text.isEmpty ||
                                roundController.text.isEmpty) {
                              dialog('من فضلك أدخل العنوان كاملا');
                            } else {
                              Provider.of<AddressProvider>(context,
                                      listen: false)
                                  .updateAdress(addressModel);
                              Get.back();
                            }
                          },
                          minWidth: MediaQuery.of(context).size.width,
                          color: kAppBarColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text('تعديل العنوان'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

void dialog(String message) {
  Get.defaultDialog(
      content: Text(message),
      textCancel: 'إغلاق',
      title: 'تنبيه',
      buttonColor: kPrimaryColor,
      cancelTextColor: kTextColor);
}
