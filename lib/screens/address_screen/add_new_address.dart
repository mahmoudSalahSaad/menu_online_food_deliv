import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/models/address.dart';
import 'package:menu_egypt/providers/address_provider.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:provider/provider.dart';

void addNewAddressBottomSheet(BuildContext context) {
  TextEditingController cityController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController roundController = TextEditingController();
  TextEditingController apartmentController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (builder) {
      return StatefulBuilder(
        builder: (context, setBottomSheetState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.60,
            color: Colors.transparent, //could change this to Color(0xFF737373),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'عنوان جديد',
                      style: TextStyle(
                        color: kAppBarColor,
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: kAppBarColor,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: TextFormField(
                        controller: cityController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            FontAwesomeIcons.house,
                            color: kAppBarColor,
                            size: 15.0,
                          ),
                          hintText: 'المحافظة',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: kAppBarColor,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: TextFormField(
                        controller: regionController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            FontAwesomeIcons.house,
                            color: kAppBarColor,
                            size: 15.0,
                          ),
                          hintText: 'الحى',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: kAppBarColor,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: TextFormField(
                        controller: streetController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            FontAwesomeIcons.house,
                            color: kAppBarColor,
                            size: 15.0,
                          ),
                          hintText: 'الشارع',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: kAppBarColor,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: TextFormField(
                        controller: buildingController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            FontAwesomeIcons.house,
                            color: kAppBarColor,
                            size: 15.0,
                          ),
                          hintText: 'رقم العمارة',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: kAppBarColor,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: TextFormField(
                        controller: roundController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            FontAwesomeIcons.house,
                            color: kAppBarColor,
                            size: 15.0,
                          ),
                          hintText: 'الدور',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: kAppBarColor,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: TextFormField(
                        controller: apartmentController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            FontAwesomeIcons.house,
                            color: kAppBarColor,
                            size: 15.0,
                          ),
                          hintText: 'رقم الشقة',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: kAppBarColor,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: TextFormField(
                        controller: descriptionController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            FontAwesomeIcons.house,
                            color: kAppBarColor,
                            size: 15.0,
                          ),
                          hintText: 'وصف',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        AddressModel addressModel = AddressModel(
                          cityName: cityController.text,
                          regionName: regionController.text,
                          street: streetController.text,
                          building: buildingController.text,
                          apartment: apartmentController.text,
                          description: descriptionController.text,
                          round: roundController.text,
                          //fake
                          cityId: 6,
                          regionId: 42,
                          type: 'work',
                        );
                        if (cityController.text.isEmpty ||
                            regionController.text.isEmpty ||
                            streetController.text.isEmpty ||
                            buildingController.text.isEmpty ||
                            apartmentController.text.isEmpty ||
                            descriptionController.text.isEmpty ||
                            roundController.text.isEmpty) {
                          dialog('من فضلك أدخل العنوان كاملا');
                        } else {
                          Provider.of<AddressProvider>(context, listen: false)
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
          );
        },
      );
    },
  );
}

void editAddressBottomSheet(BuildContext context, AddressModel addressModel) {
  TextEditingController cityController =
      TextEditingController(text: addressModel.cityName);
  TextEditingController regionController =
      TextEditingController(text: addressModel.regionName);
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
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (builder) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.60,
        color: Colors.transparent, //could change this to Color(0xFF737373),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'تعديل العنوان',
                  style: TextStyle(
                    color: kAppBarColor,
                    fontSize: 20,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: kAppBarColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: TextFormField(
                    controller: cityController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        FontAwesomeIcons.house,
                        color: kAppBarColor,
                        size: 15.0,
                      ),
                      prefix: Text('محافظة'),
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: kAppBarColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: TextFormField(
                    controller: regionController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        FontAwesomeIcons.house,
                        color: kAppBarColor,
                        size: 15.0,
                      ),
                      prefix: Text('حى'),
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: kAppBarColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: TextFormField(
                    controller: streetController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        FontAwesomeIcons.house,
                        color: kAppBarColor,
                        size: 15.0,
                      ),
                      prefix: Text('شارع'),
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: kAppBarColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: TextFormField(
                    controller: buildingController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        FontAwesomeIcons.house,
                        color: kAppBarColor,
                        size: 15.0,
                      ),
                      prefix: Text('عمارة'),
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: kAppBarColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: TextFormField(
                    controller: roundController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        FontAwesomeIcons.house,
                        color: kAppBarColor,
                        size: 15.0,
                      ),
                      prefix: Text('الدور'),
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: kAppBarColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: TextFormField(
                    controller: apartmentController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        FontAwesomeIcons.house,
                        color: kAppBarColor,
                        size: 15.0,
                      ),
                      prefix: Text('شقة'),
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: kAppBarColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: TextFormField(
                    controller: descriptionController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        FontAwesomeIcons.house,
                        color: kAppBarColor,
                        size: 15.0,
                      ),
                      prefix: Text('وصف'),
                      hintText: addressModel.description,
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    addressModel.cityName = cityController.text;
                    addressModel.regionName = regionController.text;
                    addressModel.street = streetController.text;
                    addressModel.building = buildingController.text;
                    addressModel.apartment = apartmentController.text;
                    addressModel.description = descriptionController.text;
                    addressModel.round = roundController.text;
                    if (cityController.text.isEmpty ||
                        regionController.text.isEmpty ||
                        streetController.text.isEmpty ||
                        buildingController.text.isEmpty ||
                        apartmentController.text.isEmpty ||
                        descriptionController.text.isEmpty ||
                        roundController.text.isEmpty) {
                      dialog('من فضلك أدخل العنوان كاملا');
                    } else {
                      Provider.of<AddressProvider>(context, listen: false)
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
      );
    },
  );
}

void dialog(String message) {
  Get.defaultDialog(
      content: Text(message),
      textCancel: 'إغلاق',
      title: 'تحذير',
      buttonColor: kPrimaryColor,
      cancelTextColor: kTextColor);
}
