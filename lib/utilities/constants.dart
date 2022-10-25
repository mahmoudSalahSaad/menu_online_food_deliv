import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFB90101);
const kBottomNavBarBackgroundColor = Color(0xFF000310);
const kAppBarColor = Color(0xFFA90102);
const kBackgroundColor = LinearGradient(
  colors: [Color(0xFFA90102), Color(0xFF240312)],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

const kTextColor = Colors.white;
const kDefaultPadding = 20.0;
const kDefaultButtonHeight = 50.0;
const kDefaultHeight = 40.0;
const kDefaultWidth = 40.0;

// Form Error
final RegExp emailValidatorRegExp = RegExp(
    r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
final RegExp phoneValidatorRegExp = RegExp(r"^01[0,1,2,5]{1}[0-9]{8}");
const String kEmailNullError = "من فضلك ادخل بريدك إلكترونى.";
const String kInvalidEmailError = "من فضلك ادخل بريد إلكترونى صحيح.";
const String kPassNullError = "من فضلك ادخل الرقم السرى الخاص بك.";
const String kShortPassError = "الرقم السرى يجب أن يكون اكثر من 6 احروف.";
const String kMatchPassError = "Passwords don't match";
const String kNameNullError = "من فضلك ادخل الاسم كامل.";
const String kNameLengthError = "الاسم يجيب ان يكون اكثر من  حرفين.";
const String kPhoneNumberNullError = "من فضلك ادخل رقم الهاتف.";
const String kInvalidPhoneNumberError = "من فضلك ادخل رقم الهاتف بشكل صحيح.";
const String kCityNullError = "من فضلك اختار المحافظة الخاصة بك.";
const String kRegionNullError = "من فضلك اختار المنطقة الخاصة بك.";
const String kCommentNullError = "من فضلك قم بإدخال التعليق";

// Firebase Errors
//Conditions
const String kNetworkPlatFormFieldCond = "network_error";
const String kNetworkFieldCond = "ERROR_NETWORK_REQUEST_FAILED";
const String kUserNotFoundCond = "user-not-found";
const String kEmailInUseCond = "email-already-exists";
const String kWrongPasswordCond = "firebase_auth/wrong-password";
//Messages
const String kNetworkFieldMessage = "تأكد من الانترنت الخاص بك.";
const String kEmailInUseMessage = "هذا البريد الالكترونى مستخدم.";
const String kUserNotFoundMessage =
    "هذا المستخدم غير موجود. من فضلك قم بالتسجيل .";
const String kUserPasswordInvaild = "الرقم السرى غير صحيح.";
const String kCodePassError = "رقم التحقيق يجب ان لا يقل عن 4 ارقام.";
const String kCodeNullError = "من فضلك ادخل رقم التحقيق الخاص بك.";
const String kNewShortPassError = "";
const String kNewConfimPassError = "كلمات المرور غير متطابقة";
