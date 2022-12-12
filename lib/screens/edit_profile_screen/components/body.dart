import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/components/app_bar.dart';
import 'package:menu_egypt/components/default_button.dart';
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

enum Gender { male, female }

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Gender _gender = Gender.male;
  String birthDate;
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'fullName': null,
    'email': null,
    'phoneNumber': null,
    'cityId': null,
    'regionId': null,
    'gender': null,
    'birthDate': null
  };
  CityModel city;
  RegionModel region;
  void onSubmit() async {
    if (!_formKey.currentState.validate() ||
        _formData['cityId'] == null ||
        _formData['regionId'] == null) {
      return;
    }
    _formKey.currentState.save();
    _formData['birth_date'] = birthDate;
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
        Provider.of<UserProvider>(context, listen: false).user.regionId;
    _formData['cityId'] =
        Provider.of<UserProvider>(context, listen: false).user.cityId;
    _formData['email'] =
        Provider.of<UserProvider>(context, listen: false).user.email;
    _formData['fullname'] =
        Provider.of<UserProvider>(context, listen: false).user.fullName;
    _formData['phoneNumber'] =
        Provider.of<UserProvider>(context, listen: false).user.phoneNumber;
    _formData['gender'] =
        Provider.of<UserProvider>(context, listen: false).user.gender;
    _formData['birthDate'] =
        Provider.of<UserProvider>(context, listen: false).user.birthDate;
    _gender =
        Provider.of<UserProvider>(context, listen: false).user.gender == 'male'
            ? Gender.male
            : Gender.female;
    birthDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    print(Provider.of<UserProvider>(context, listen: false).user.birthDate);
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
                  padding: const EdgeInsets.all(16.0),
                  child: AppBarWidget(
                    title: 'تعديل الملف الشخصى',
                    withBack: true,
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                EditForm(
                  formKey: _formKey,
                  formData: _formData,
                  cities: cityProvider.cities,
                  regions: city != null
                      ? regionProvider.regionsOfCity(city.cityId)
                      : regionProvider
                          .regionsOfCity(cityProvider.cities[0].cityId),
                  city: city != null ? city : cityProvider.cities[0],
                  region: region != null
                      ? region
                      : regionProvider
                          .regionsOfCity(cityProvider.cities[0].cityId)[0],
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        title: Text('ذكر'),
                        groupValue: _gender,
                        value: Gender.male,
                        activeColor: Colors.red,
                        onChanged: (Gender value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: Text('انثى'),
                        groupValue: _gender,
                        value: Gender.female,
                        activeColor: Colors.red,
                        onChanged: (Gender value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                TextButton(
                  onPressed: () async {
                    DateTime selected = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    if (selected == null) return;
                    setState(() {
                      birthDate = DateFormat('yyyy-MM-dd').format(selected);
                    });
                  },
                  child: Text(
                    'اختر تاريخ الميلاد ' + birthDate,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontSize: getProportionateScreenHeight(15),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
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
                  height: SizeConfig.screenHeight * 0.02,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.06,
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
    Get.defaultDialog(
        content: Text(message),
        textCancel: 'إغلاق',
        title: 'تنبيه',
        buttonColor: kPrimaryColor,
        cancelTextColor: kTextColor);
  }
}
