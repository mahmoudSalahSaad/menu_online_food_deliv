import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/components/app_bar.dart';
import 'package:menu_egypt/components/default_button.dart';
import 'package:menu_egypt/components/dialog.dart';
import 'package:menu_egypt/components/loading_circle.dart';
import 'package:menu_egypt/models/City.dart';
import 'package:menu_egypt/models/Region.dart';
import 'package:menu_egypt/providers/city_provider.dart';
import 'package:menu_egypt/providers/region_provider.dart';
import 'package:menu_egypt/providers/user_provider.dart';
import 'package:menu_egypt/screens/edit_profile_screen/components/edit_form.dart';
import 'package:menu_egypt/screens/profile_screen/profile_screen.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

enum Gender { male, female }

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Gender _gender = Gender.male;
  String? birthDate;
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'fullName': null,
    'email': null,
    'phoneNumber': null,
    'cityId': null,
    'regionId': null,
    'gender': null,
    'birth_date': null
  };
  CityModel? city;
  RegionModel? region;
  void onSubmit() async {
    if (!_formKey.currentState!.validate() ||
        _formData['cityId'] == null ||
        _formData['regionId'] == null) {
      return;
    }
    _formKey.currentState!.save();
    _formData['birth_date'] = DateFormat("yyyy-MM-dd").format(_selectedDate);
    _formData['gender'] = _gender.toString().split('Gender.')[1];
    var result = await Provider.of<UserProvider>(context, listen: false)
        .editUserData(_formData);
    if (result['success']) {
      Get.offNamed(ProfileScreen.routeName);
    } else {
      dialog(result['error']);
    }
  }

  @override
  void initState() {
    _formData['regionId'] =
        Provider.of<UserProvider>(context, listen: false).user!.regionId!;
    _formData['cityId'] =
        Provider.of<UserProvider>(context, listen: false).user!.cityId!;
    _formData['email'] =
        Provider.of<UserProvider>(context, listen: false).user!.email;
    _formData['fullname'] =
        Provider.of<UserProvider>(context, listen: false).user!.fullName;
    _formData['phoneNumber'] =
        Provider.of<UserProvider>(context, listen: false).user!.phoneNumber;
    _formData['gender'] =
        Provider.of<UserProvider>(context, listen: false).user!.gender;
    _formData['birth_date'] =
        Provider.of<UserProvider>(context, listen: false).user!.birthDate;
    _gender =
        Provider.of<UserProvider>(context, listen: false).user!.gender == 'male'
            ? Gender.male
            : Gender.female;
    _selectedDate =
        DateTime.parse(Provider.of<UserProvider>(context, listen: false).user!.birthDate.toString());

    print(Provider.of<UserProvider>(context, listen: false).user!.birthDate);
/*
DateFormat('yyyy-MM-dd').format(DateTime.parse(
            Provider.of<UserProvider>(context, listen: false)
                .user
                .birthDate)) 
 */
    if (_formData['cityId'] != null) {
      city = Provider.of<CityProvider>(context, listen: false)
          .getCityById(_formData['cityId']);
    }
    if (_formData['regionId'] != null) {
      region = Provider.of<RegionProvider>(context, listen: false)
          .getRegionById(_formData['regionId']);
    }
    super.initState();
  }
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: true);
    final regionProvider = Provider.of<RegionProvider>(context, listen: false);
    CityProvider cityProvider =
        Provider.of<CityProvider>(context, listen: false);
    return SafeArea(
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(10.0),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: AppBarWidget(
                    title: 'تعديل الملف الشخصى',
                    withBack: true,
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight !* 0.04),
                EditForm(
                  formKey: _formKey,
                  formData: _formData,
                  cities: cityProvider.cities,
                  regions: city != null
                      ? regionProvider.regionsOfCity(city!.cityId!)
                      : regionProvider
                          .regionsOfCity(cityProvider.cities[0].cityId!),
                  city: city ?? cityProvider.cities[0],
                  region: region
                      ?? regionProvider
                          .regionsOfCity(cityProvider.cities[0].cityId!)[0],
                ),

                SizedBox(
                  height: SizeConfig.screenHeight !* 0.02,
                ),
                GestureDetector(
                  child: TextFormField(
                    initialValue: DateFormat("yyyy-MM-dd").format(_selectedDate)??'اختر تاريخ الميلاد',
                    enabled: false,
                    style: TextStyle(color: Colors.black , height: 2.0) ,
                    decoration: InputDecoration(
                      prefixIcon: Image.asset("assets/icons/birthdate.png" , scale: 3.6,),
                      contentPadding:
                          EdgeInsets.all(getProportionateScreenHeight(10)),
                      hintText:'اختر تاريخ الميلاد',
                      filled: true,
                      fillColor: Color(0xffF7F7F9),
                      hintStyle: TextStyle(color: Colors.black),
                      focusColor: Colors.white,
                        enabledBorder:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                            borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)) ,
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                            borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),

                        focusedBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                            borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                            borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),

                    ),
                  ),
                  // onTap: () async {
                  //   DateTime selected = await showDatePicker(
                  //     context: context,
                  //     initialDate: DateTime.now(),
                  //     firstDate: DateTime(1900),
                  //     lastDate: DateTime(2100),
                  //   );
                  //   if (selected == null) return;
                  //   setState(() {
                  //     birthDate = DateFormat('yyyy-MM-dd').format(selected);
                  //   });
                  // },
                  onTap: ()=> dialogD() ,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight !* 0.02,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: getProportionateScreenWidth(getProportionateScreenWidth(150)),
                      child: RadioListTile(

                        title: Text('ذكر' , style: TextStyle(color: Colors.black)),
                        groupValue: _gender,
                        value: Gender.male,
                        activeColor: Colors.red,


                        onChanged: (Gender? value) {
                          setState(() {
                            _gender = value!;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(getProportionateScreenWidth(150)),
                      child: RadioListTile(
                        title: Text('انثى',style: TextStyle(color: Colors.black),),
                        groupValue: _gender,
                        value: Gender.female,
                        activeColor: Colors.red,
                        onChanged: (Gender? value) {
                          setState(() {
                            _gender = value!;
                          });
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: SizeConfig.screenHeight !* 0.02,
                ),
                userProvider.isLoading
                    ? LoadingCircle()
                    : DefaultButton(
                        textColor: Colors.white,
                        onPressed: onSubmit,
                        child: Text('تعديل'),
                        color: kPrimaryColor,
                        minWidth: 0.0,
                        height: getProportionateScreenHeight(45)),
                SizedBox(
                  height: SizeConfig.screenHeight !* 0.02,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight !* 0.06,
                ),
                SizedBox(height: getProportionateScreenHeight(30.0))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void dialog(String message) {
    AppDialog.infoDialog(
      context: context,
      title: 'تنبيه',
      message: message,
      btnTxt: 'إغلاق',
    );
  }



  Future<void> dialogD() async {
    return Get.defaultDialog(
      // backgroundColor: kAppBarColor,
      title:  "تاريخ  الميلاد" ,
      content:SizedBox(
        height: 250,
        width: 250,
        child: ScrollDatePicker(
          selectedDate: _selectedDate,

          locale: Locale('ar'),
          onDateTimeChanged: (DateTime value) {
            setState(() {
              _selectedDate = value;
            });
          },
        ),
      ),
      confirm: GestureDetector(
        onTap: (){
          Get.back();
        },
        child: Container(
          padding: EdgeInsets.all(getProportionateScreenHeight(10)),
          decoration: BoxDecoration(
            color:  kAppBarColor ,
            borderRadius:  BorderRadius.circular(getProportionateScreenHeight(10)) ,
            
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("تأكيد" , style: TextStyle(
                color: Colors.white ,
                fontSize: getProportionateScreenHeight(14)
              ),)
            ],
          ),
        ),
      )
    ) ;
  }
}
