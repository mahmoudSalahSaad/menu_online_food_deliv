import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/components/app_bar.dart';
import 'package:menu_egypt/components/city_drop_down.dart';
import 'package:menu_egypt/components/dialog.dart';
import 'package:menu_egypt/components/region_drop_down.dart';
import 'package:menu_egypt/models/City.dart';
import 'package:menu_egypt/models/Region.dart';
import 'package:menu_egypt/models/address.dart';
import 'package:menu_egypt/providers/address_provider.dart';
import 'package:menu_egypt/providers/city_provider.dart';
import 'package:menu_egypt/providers/home_provider.dart';
import 'package:menu_egypt/providers/region_provider.dart';
import 'package:menu_egypt/providers/user_provider.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';
//import 'package:dropdown_search/dropdown_search.dart';


class AddNewAddress extends StatefulWidget {
  const AddNewAddress({Key? key}) : super(key: key);

  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  TextEditingController cityIdController = TextEditingController();
  TextEditingController regionIdController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController roundController = TextEditingController();
  TextEditingController apartmentController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController neighborhoodController = TextEditingController();

  List<CityModel>? cities;
  List<RegionModel>? regions;
  CityModel? city;
  RegionModel? region;
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final user = Provider.of<UserProvider>(context, listen: false);

    //city dropdown
    final cityProvider = Provider.of<CityProvider>(context, listen: false);
    cityProvider.setCities(homeProvider.cities);
    cities = cityProvider.cities;
    city = user.user != null
        ? cityProvider.getCityById(user.user!.cityId!)
        : cities![0];
    cityIdController.text = city!.cityId.toString();
    //region dropdown
    final regionProvider = Provider.of<RegionProvider>(context, listen: false);
    regionProvider.setRegions(homeProvider.regions);
    regions = regionProvider.regionsOfCity(city!.cityId!);
    region = user.user != null
        ? regionProvider.getRegionById(user.user!.regionId!)
        : regions![15];
    regionIdController.text = region!.regionId!.toString();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Padding(
          padding: EdgeInsets.zero,
          child: Container(
            height: MediaQuery.of(context).size.height *1,
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
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child:
                        AppBarWidget(title: 'عنوان جديد', withBack: true),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(50),
                      ),
                      CityDropDownField(
                          items: cities,
                          value: city,
                          onChanged: (CityModel cityModel) {
                            setState(() {
                              city = cityModel;
                              regions = Provider.of<RegionProvider>(
                                  context,
                                  listen: false)
                                  .regionsOfCity(city!.cityId!);
                              if (cityModel.cityId ==
                                  cities![18].cityId) {
                                region = regions![24];
                              } else {
                                region = regions![0];
                              }
                              cityIdController.text =
                                  city!.cityId!.toString();
                              print(cityIdController.text);
                            });
                          }),
                      SizedBox(
                        height: getProportionateScreenHeight(12),
                      ),
                      RegionDropDownField(
                        items: regions,
                        value: region,
                        onChanged: (RegionModel? regionModel) {
                          setState(() {
                            region = regionModel;
                            regionIdController.text =
                                region!.regionId.toString();
                            print(regionIdController.text);
                          });
                        },
                      ) ,
                      SizedBox(
                        height: getProportionateScreenHeight(12),
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: neighborhoodController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          prefixIcon:Image.asset("assets/icons/Group 1000000852.png"),
                          filled: true,
                          fillColor: Color(0xffF7F7F9),
                          enabledBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                              borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)) ,
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                              borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
                          contentPadding: EdgeInsets.zero,
                          focusedBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                              borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                              borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
                          hintText: 'الحى',
                          hintStyle: TextStyle(color: Colors.black),

                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(12),
                      ),
                      TextFormField (
                        textInputAction: TextInputAction.next,
                        controller: streetController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          prefixIcon:Image.asset("assets/icons/Group 1000000831.png", scale: 4,),
                          filled: true,
                          fillColor: Color(0xffF7F7F9),
                          enabledBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                              borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)) ,
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                              borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
                          contentPadding: EdgeInsets.zero,
                          focusedBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                              borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                              borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
                          hintText: 'الشارع',
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(12),
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: buildingController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          prefixIcon:Image.asset("assets/icons/Group 1000000856.png"),
                          filled: true,
                          fillColor: Color(0xffF7F7F9),
                          enabledBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                              borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)) ,
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                              borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
                          contentPadding: EdgeInsets.zero,
                          focusedBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                              borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),

                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                              borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
                          hintText: 'رقم العمارة',
                          hintStyle: TextStyle(color: Colors.black),

                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(12),
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: roundController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            FontAwesomeIcons.stairs,
                            color: Color(0xff222222),
                            size: getProportionateScreenHeight(20),
                          ),
                          filled: true,
                          fillColor: Color(0xffF7F7F9),
                          enabledBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                              borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)) ,
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                              borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
                          contentPadding: EdgeInsets.zero,
                          focusedBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                              borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                              borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
                          hintText: 'الدور',
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(12),
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: apartmentController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          prefixIcon:Image.asset("assets/icons/Group 1000000853.png"),
                          filled: true,
                          fillColor: Color(0xffF7F7F9),
                          enabledBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                              borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)) ,
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                              borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
                          contentPadding: EdgeInsets.zero,
                          focusedBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                              borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                              borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
                          hintText: 'رقم الشقة',
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(12),
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: descriptionController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            prefixIcon:Image.asset("assets/icons/Group 1000000834.png" , scale: 4,),
                          filled: true,
                          fillColor: Color(0xffF7F7F9),
                          enabledBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                              borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)) ,
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                              borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
                          contentPadding: EdgeInsets.zero,
                          focusedBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                              borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                              borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
                          hintText: 'وصف',
                          hintStyle: TextStyle(color: Colors.black),

                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(50),
                      ),
                      SizedBox(
                        height: 48,
                        child: MaterialButton(
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
                              neighborhood: neighborhoodController.text,
                            );
                            if (/*cityIdController.text.isEmpty ||
                                regionIdController.text.isEmpty ||*/
                            streetController.text.isEmpty ||
                                buildingController.text.isEmpty ||
                                apartmentController.text.isEmpty ||
                                roundController.text.isEmpty ) {
                              AppDialog.infoDialog(
                                context: context,
                                title: 'تنبيه',
                                message: 'من فضلك أدخل العنوان كاملا',
                                btnTxt: 'إغلاق',
                              );
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
                          child: Text('اضف عنوان جديد' , style: TextStyle(color: Colors.white),),
                        ),
                      ) ,

                    ],
                  ),
                ),
              ),
            ),
          ),
        ) ,
      ),
    );
  }
}



// void addNewAddressBottomSheet(BuildContext context) {
//
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     builder: (builder) {
//       return StatefulBuilder(
//         builder: (context, setBottomSheetState) {
//           return ;
//         },
//       );
//     },
//   );
// }

class EditMyAddress extends StatefulWidget {
  const EditMyAddress({Key? key, this.addressModel}) : super(key: key);
  final AddressModel? addressModel ;

  @override
  State<EditMyAddress> createState() => _EditMyAddressState();
}

class _EditMyAddressState extends State<EditMyAddress> {
  List<CityModel>? cities;
  List<RegionModel>? regions;
  CityModel? city;
  RegionModel? region;
  TextEditingController? cityIdController =
  TextEditingController();

  TextEditingController regionIdController =
  TextEditingController();

  TextEditingController streetController =
  TextEditingController();
  TextEditingController buildingController =
  TextEditingController();
  TextEditingController apartmentController =
  TextEditingController();
  TextEditingController descriptionController =
  TextEditingController();
  TextEditingController roundController =
  TextEditingController();
  TextEditingController neighborhoodController =
  TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     cityIdController =
         TextEditingController(text: widget.addressModel!.cityId.toString());

     regionIdController =
    TextEditingController(text: widget.addressModel!.regionId.toString());

     streetController =
    TextEditingController(text: widget.addressModel!.street);
     buildingController =
    TextEditingController(text: widget.addressModel!.building);
     apartmentController =
    TextEditingController(text: widget.addressModel!.apartment);
     descriptionController =
    TextEditingController(text: widget.addressModel!.description);
     roundController =
    TextEditingController(text: widget.addressModel!.round);
     neighborhoodController =
    TextEditingController(text: widget.addressModel!.neighborhood);

    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    //city dropdown
    final cityProvider = Provider.of<CityProvider>(context, listen: false);
    cityProvider.setCities(homeProvider.cities);
    cities = cityProvider.cities;
    city = cityProvider.getCityById(widget.addressModel!.cityId!);

    //region dropdown
    final regionProvider = Provider.of<RegionProvider>(context, listen: false);
    regionProvider.setRegions(homeProvider.regions);
    region = regionProvider.getRegionById(widget.addressModel!.regionId!);
    regions = regionProvider.regionsOfCity(city!.cityId!);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:
      Padding(
        padding: EdgeInsets.zero,
        child: Container(
          height: MediaQuery.of(context).size.height * 1,
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
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child:
                      AppBarWidget(title: 'تعديل العنوان', withBack: true),

                  ),
                    SizedBox(
                      height: getProportionateScreenHeight(50),
                    ),
                    CityDropDownField(
                        items: cities,
                        value: city,
                        onChanged: (CityModel cityModel) {
                          setState(() {
                            city = cityModel;
                            regions = Provider.of<RegionProvider>(context,
                                listen: false)
                                .regionsOfCity(city!.cityId!);
                            if (cityModel.cityId == cities![18].cityId) {
                              region = regions![24];
                              regionIdController.text =
                                  region!.regionId!.toString();
                            } else {
                              region = regions![0];
                              regionIdController.text =
                                  region!.regionId.toString();
                            }
                            cityIdController!.text =
                                city!.cityId.toString();
                            print(cityIdController!.text);
                          });
                        }),
                    SizedBox(
                      height: getProportionateScreenHeight(12),
                    ),
                    RegionDropDownField(
                      items: regions,
                      value: region,
                      onChanged: (RegionModel? regionModel) {
                        setState(() {
                          print("ca");
                          region = regionModel;
                          regionIdController.text =
                              region!.regionId.toString();
                          print(regionIdController.text);
                        });
                      },
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(12),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: neighborhoodController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        prefixIcon:Image.asset("assets/icons/Group 1000000852.png"),
                        filled: true,
                        fillColor: Color(0xffF7F7F9),
                        enabledBorder:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                            borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)) ,
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                            borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
                        contentPadding: EdgeInsets.zero,
                        focusedBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                            borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                            borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
                        prefix: Text('حى' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
                        hintStyle: TextStyle(color: Colors.black),


                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(12),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: streetController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffF7F7F9),
                        enabledBorder:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                            borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)) ,
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                            borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
                        prefixIcon:Image.asset("assets/icons/Group 1000000831.png" , scale: 4,),
                        contentPadding: EdgeInsets.zero,
                        focusedBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                            borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                            borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
                        hintStyle: TextStyle(color: Colors.black),
                        prefix: Text('شارع', style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),


                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(12),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: buildingController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        prefixIcon:Image.asset("assets/icons/Group 1000000856.png"),
                        filled: true,
                        fillColor: Color(0xffF7F7F9),
                        enabledBorder:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                            borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)) ,
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                            borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),

                        contentPadding: EdgeInsets.zero,
                        focusedBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                            borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                            borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
                        prefix: Text('عمارة' ,style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
                        hintStyle: TextStyle(color: Colors.grey),

                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(12),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: roundController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          FontAwesomeIcons.stairs,
                          color: Color(0xff222222),
                          size: getProportionateScreenHeight(20),
                        ),
                        filled: true,
                        fillColor: Color(0xffF7F7F9),
                        enabledBorder:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                            borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)) ,
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                            borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),

                        contentPadding: EdgeInsets.zero,
                        focusedBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                            borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                            borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
                        prefix: Text('الدور' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
                        hintStyle: TextStyle(color: Colors.grey),

                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(4),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: apartmentController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        prefixIcon:Image.asset("assets/icons/Group 1000000853.png"),
                        filled: true,
                        fillColor: Color(0xffF7F7F9),
                        enabledBorder:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                            borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)) ,
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                            borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),

                        contentPadding: EdgeInsets.zero,
                        focusedBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                            borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                            borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
                        prefix: Text('شقة' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
                        hintStyle: TextStyle(color: Colors.grey),

                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(12),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: descriptionController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        prefixIcon:Image.asset("assets/icons/Group 1000000834.png" ,scale: 4,),
                        filled: true,
                        fillColor: Color(0xffF7F7F9),
                        enabledBorder:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                            borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)) ,
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                            borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),

                        contentPadding: EdgeInsets.zero,
                        focusedBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                            borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                            borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
                        prefix: Text('وصف' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
                        hintText: widget.addressModel!.description,
                        hintStyle: TextStyle(color: Colors.grey),

                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(50),
                    ),
                    SizedBox(
                      height: 48,
                      child: MaterialButton(
                        onPressed: () {
                          widget.addressModel!.cityId =
                              int.parse(cityIdController!.text);
                          widget.addressModel!.regionId =
                              int.parse(regionIdController.text);
                          widget.addressModel!.street = streetController.text;
                          widget.addressModel!.building = buildingController.text;
                          widget.addressModel!.apartment = apartmentController.text;
                          widget.addressModel!.description =
                              descriptionController.text;
                          widget.addressModel!.round = roundController.text;
                          widget.addressModel!.neighborhood =
                              neighborhoodController.text;
                          if (streetController.text.isEmpty ||
                              buildingController.text.isEmpty ||
                              apartmentController.text.isEmpty ||
                              roundController.text.isEmpty ||
                              neighborhoodController.text.isEmpty) {
                            AppDialog.infoDialog(
                              context: context,
                              title: 'تنبيه',
                              message: 'من فضلك أدخل العنوان كاملا',
                              btnTxt: 'إغلاق',
                            );
                          } else {
                            Provider.of<AddressProvider>(context,
                                listen: false)
                                .updateAdress(widget.addressModel!);
                            Get.back();
                          }
                        },
                        minWidth: MediaQuery.of(context).size.width,
                        color: kAppBarColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text('تعديل العنوان' , style: TextStyle(color: Colors.white),),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }
}


