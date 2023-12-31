import 'package:flutter/material.dart';
import 'package:menu_egypt/components/form_errors.dart';
import 'package:menu_egypt/components/input_text_field.dart';
import 'package:menu_egypt/models/City.dart';
import 'package:menu_egypt/models/Region.dart';
import 'package:menu_egypt/providers/region_provider.dart';
import 'package:menu_egypt/screens/sign_up_screen/components/city_drop_down_field.dart';
import 'package:menu_egypt/screens/sign_up_screen/components/region_drop_down_field.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SignUpForm extends StatefulWidget {
  SignUpForm(
      {Key? key,
      this.formKey,
      this.formData,
      this.cities,
      this.regions,
      this.city,
      this.region})
      : super(key: key);

  final formKey;
  final formData;
  final List<CityModel>? cities;
  List<RegionModel>? regions;
  CityModel? city;
  RegionModel? region;
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final List<String> errors = [];
  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error!);
        _scrollController.animateTo(
          0.0,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        );
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: SingleChildScrollView(
          controller: _scrollController,
          reverse: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormErrors(errors: errors),
              InputTextField(
                textInputType: TextInputType.name,
                labelText: "الأسم",
                iconPath: "assets/icons/Group 1000000781.png",
                border: false,
                onSaved: (String newValue) =>
                    widget.formData['fullName'] = newValue,
                onChanged: (String value) {
                  if (value.isNotEmpty) {
                    removeError(error: kNameNullError);
                    if (value.length >= 2) {
                      removeError(error: kNameLengthError);
                    }
                  }
                  return null;
                },
                validator: (String value) {
                  if (value.isEmpty) {
                    addError(error: kNameNullError);
                    return "";
                  } else if (value.length <= 1) {
                    addError(error: kNameLengthError);
                    return "";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 12,
              ),
              InputTextField(
                textInputType: TextInputType.emailAddress,
                labelText: "البريد إلالكترونى",
                iconPath: "assets/icons/mail.png",
                border: false,
                onSaved: (String newValue) =>
                    widget.formData['email'] = newValue,
                onChanged: (String value) {
                  if (value.isNotEmpty) {
                    removeError(error: kEmailNullError);
                    if (emailValidatorRegExp.hasMatch(value)) {
                      removeError(error: kInvalidEmailError);
                    }
                  }
                  return null;
                },
                validator: (String value) {
                  if (value.isEmpty) {
                    addError(error: kEmailNullError);
                    return "";
                  } else if (!emailValidatorRegExp.hasMatch(value)) {
                    addError(error: kInvalidEmailError);
                    return "";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 12,
              ),
              InputTextField(
                textInputType: TextInputType.visiblePassword,
                obscure: true,
                labelText: "الرقم السرى",
                isPassword: true,
                iconPath: "assets/icons/Group 1000000777.png",
                border: false,
                onSaved: (String newValue) =>
                    widget.formData['password'] = newValue,
                onChanged: (String value) {
                  if (value.isNotEmpty) {
                    removeError(error: kPassNullError);
                  } else if (value.length > 5) {
                    removeError(error: kShortPassError);
                  }
                  return null;
                },
                validator: (String value) {
                  if (value.isEmpty) {
                    addError(error: kPassNullError);
                    return "";
                  } else if (value.length <= 5) {
                    addError(error: kShortPassError);
                    return "";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 12,
              ) ,
              InputTextField(
                textInputType: TextInputType.phone,
                labelText: "الموبايل",
                iconPath: "assets/icons/phone.png",
                border: false,
                validator: (String? value){
                  return null ;
                },
                onSaved: (String newValue) =>
                    widget.formData['phoneNumber'] = newValue,
                onChanged: (String value) {
                  // if (value.isNotEmpty) {
                  //   removeError(error: kPhoneNumberNullError);
                  //   if (phoneValidatorRegExp.hasMatch(value)) {
                  //     removeError(error: kInvalidPhoneNumberError);
                  //   }
                  // }
                  return null;
                },
                // validator: (String value) {
                //   if (value.isEmpty) {
                //     addError(error: kPhoneNumberNullError);
                //     return "";
                //   } else if (!phoneValidatorRegExp.hasMatch(value)) {
                //     addError(error: kInvalidPhoneNumberError);
                //     return "";
                //   }
                //   return null;
                // },
              ),
              SizedBox(
                height: 12,
              ),
              CityDropDownField(
                items: widget.cities,
                text: 'اختار المحافظة',
                value: widget.city,
                onChanged: (CityModel? city) {
                  setState(() {
                    widget.city = city;
                    widget.formData['cityId'] = city!.cityId;
                    widget.regions =
                        Provider.of<RegionProvider>(context, listen: false)
                            .regionsOfCity(widget.city!.cityId!);
                    widget.formData['regionId'] = null;
                  });
                },
              ),
              SizedBox(
                height: 12,
              ),
              RegionDropDownField(
                items: widget.regions,
                text: 'اختار المنطقة',
                value:
                    widget.formData['regionId'] == null ? null : widget.region,
                onChanged: (RegionModel region) {
                  setState(() {
                    widget.region = region;
                    widget.formData['regionId'] = region.regionId;
                  });
                },
              ),
            ],
          ),
        ));
  }
}
