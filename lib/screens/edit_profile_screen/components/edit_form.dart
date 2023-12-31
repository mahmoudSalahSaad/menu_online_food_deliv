import 'package:flutter/material.dart';
import 'package:menu_egypt/components/form_errors.dart';
import 'package:menu_egypt/components/input_text_field.dart';
import 'package:menu_egypt/models/City.dart';
import 'package:menu_egypt/models/Region.dart';
import 'package:menu_egypt/models/User.dart';
import 'package:menu_egypt/providers/region_provider.dart';
import 'package:menu_egypt/providers/user_provider.dart';
import 'package:menu_egypt/screens/edit_profile_screen/components/city_drop_down_field.dart';
import 'package:menu_egypt/screens/edit_profile_screen/components/region_drop_down_field.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EditForm extends StatefulWidget {
  EditForm(
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
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final List<String> errors = [];
  UserModel? user;
  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error!);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  void initState() {
    user = Provider.of<UserProvider>(context, listen: false).user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormErrors(errors: errors),
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),
              InputTextField(
                intialValue: user!.fullName != null ? user!.fullName : '',
                textInputType: TextInputType.name,
                labelText: "الأسم",
                iconPath: "assets/icons/Group 1000000781.png",
                border: true,
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
                height: getProportionateScreenHeight(12),
              ),
              IgnorePointer(
                child: InputTextField(
                  intialValue: user!.email ?? '',
                  textInputType: TextInputType.emailAddress,
                  labelText: "البريد إلالكترونى",
                  border: true,
                  iconPath: "assets/icons/mail.png",
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
              ),
              SizedBox(
                height: getProportionateScreenHeight(12),
              ),
              InputTextField(
                intialValue:  user!.phoneNumber ?? '',
                textInputType: TextInputType.phone,
                labelText: "الموبايل",
                border: true,
                  iconPath: "assets/icons/phone.png",
                onSaved: (String newValue) =>
                    widget.formData['phoneNumber'] = newValue,
                onChanged: (String value) {
                  if (value.isNotEmpty) {
                    removeError(error: kPhoneNumberNullError);
                    if (phoneValidatorRegExp.hasMatch(value)) {
                      removeError(error: kInvalidPhoneNumberError);
                    }
                  }
                  return null;
                },
                validator: (String value) {
                  if (value.isEmpty) {
                    addError(error: kPhoneNumberNullError);
                    return "";
                  } else if (!phoneValidatorRegExp.hasMatch(value)) {
                    addError(error: kInvalidPhoneNumberError);
                    return "";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: getProportionateScreenHeight(12),
              ),
              CityDropDownField(
                items: widget.cities,
                text: user!.cityId == null ? 'اختار المحافظة' : '',
                value: widget.formData['cityId'] == null ? null : widget.city,
                onChanged: (CityModel city) {
                  print(city.cityId);
                  setState(() {
                    widget.city = city;
                    widget.formData['cityId'] = city.cityId;
                    widget.regions =
                        Provider.of<RegionProvider>(context, listen: false)
                            .regionsOfCity(widget.city!.cityId!);
                    widget.formData['regionId'] = widget.regions![0].regionId;
                    widget.region = widget.regions![0];
                  });
                },
              ),
              SizedBox(
                height: getProportionateScreenHeight(12),
              ),
              RegionDropDownField(
                items: widget.regions!,
                text: user!.regionId == null ? 'اختار المنطقة' : '',
                value:
                     widget.region!,
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
