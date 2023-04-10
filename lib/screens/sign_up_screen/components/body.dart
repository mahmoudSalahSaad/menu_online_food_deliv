import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:menu_egypt/components/app_bar.dart';
import 'package:menu_egypt/components/default_button.dart';
import 'package:menu_egypt/components/dialog.dart';
import 'package:menu_egypt/components/loading_circle.dart';
import 'package:menu_egypt/providers/city_provider.dart';
import 'package:menu_egypt/providers/region_provider.dart';
import 'package:menu_egypt/providers/user_provider.dart';
import 'package:menu_egypt/screens/otp_screen/otp_screen.dart';
import 'package:menu_egypt/screens/sign_up_screen/components/sign_up_form.dart';
import 'package:menu_egypt/screens/sign_in_screen/sign_in_screen.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

enum Gender { male, female }

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Gender _gender = Gender.male;
  DateTime _selectedDate = DateTime.parse('1990-08-08');

  String birthDate =
      DateFormat('yyyy-MM-dd').format(DateTime.parse('1988-08-08'));
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'fullName': null,
    'password': null,
    'email': null,
    'phoneNumber': null,
    'cityId': null,
    'regionId': null,
  };
  void onSubmit() async {
    print("Clicked");
    if (!_formKey.currentState!.validate() ||
        _formData['cityId'] == null ||
        _formData['regionId'] == null) {
      return;
    }
    _formKey.currentState!.save();
    _formData['birth_date'] = DateFormat("yyyy-MM-dd").format(_selectedDate);
    _formData['gender'] = _gender.toString().split('Gender.')[1];
    print(_formData);
    var result = await Provider.of<UserProvider>(context, listen: false)
        .signUp(_formData);
    print(result);
    if (result['success']) {
      Get.toNamed(OtpScreen.routeName);
      AppDialog.mailDialog( btnTxt: "استمر"  , message:result['msg'] , context: context , title: "") ;
    } else {
      dialog(result['error'].toString());
    }
  }

  @override
  void initState() {
    CityProvider cityProvider =
        Provider.of<CityProvider>(context, listen: false);
    _formData['cityId'] = cityProvider.cities[0].cityId;
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppBarWidget(
                  title: 'انشاء حساب',
                  withBack: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20.0)),
                      child: Image.asset('assets/images/menu-egypt-logo.png' , height: 60,),
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(5.0)),
                SignUpForm(
                  formKey: _formKey,
                  formData: _formData,
                  cities: cityProvider.cities,
                  regions: regionProvider
                      .regionsOfCity(cityProvider.cities[0].cityId!),
                  city: cityProvider.cities[0],
                  region: regionProvider
                      .regionsOfCity(cityProvider.cities[0].cityId!)[0],
                ),
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.02,
                ),
                GestureDetector(
                  child: TextFormField(

                    enabled: false,
                    decoration: InputDecoration(

                      hintText: DateFormat("yyyy-MM-dd").format(_selectedDate)??'اختر تاريخ الميلاد',
                      prefixStyle: TextStyle(
                         color: Color(0xff222222) ,
                        fontSize: 18 ,
                        height: 2.0
                      ),
                      focusColor: Colors.white,
                      labelStyle: TextStyle(color: Colors.black , height: 2.0 ,fontSize: 18),
                      prefixIcon: Image.asset("assets/icons/birthdate.png" , scale: 3.6,),
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 12),
                      filled: true,
                      fillColor: Color(0xffF7F7F9),
                      hintStyle: TextStyle(color: Colors.black , height: 2.0 ,fontSize: 18),

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
                  onTap: () => dialogD(),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight !* 0.02,
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        title: Text('ذكر'),
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
                    Expanded(
                      child: RadioListTile(
                        title: Text('انثى'),
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
                  height: SizeConfig.screenHeight! * 0.02,
                ),
                userProvider.isLoading
                    ? LoadingCircle()
                    : DefaultButton(
                        textColor: Colors.white,
                        onPressed:()=> onSubmit(),
                        child: Text('التسجيل'),
                        color: kPrimaryColor,
                        minWidth: 0.0,
                        height: getProportionateScreenHeight(45)),
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('  لديك حساب؟ '),
                    GestureDetector(
                      onTap: () {
                        Get.offNamed(SignInScreen.routeName);
                      },
                      child: Text(
                        ' تسجيل الدخول ',
                        style: TextStyle(color: kPrimaryColor),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> dialog(String message) {
    return AppDialog.infoDialog(
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
          width:300,
          height: 300,
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
                Text("تأكيد" , style: TextStyle(color: Colors.white),)
              ],
            ),
          ),
        )
    ) ;
  }
}
