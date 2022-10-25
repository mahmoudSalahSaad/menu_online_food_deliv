import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/providers/restaurants_provider.dart';
import 'package:menu_egypt/providers/user_provider.dart';
import 'package:menu_egypt/screens/new_restaurant_screen/components/comments_tap/comments_form.dart';
import 'package:menu_egypt/screens/new_restaurant_screen/components/comments_tap/comments_widget.dart';
import 'package:menu_egypt/screens/sign_in_screen/sign_in_screen.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';

import '../../../components/default_button.dart';
import '../../../utilities/constants.dart';

class CommentsTabWidget extends StatefulWidget {
  CommentsTabWidget({
    Key key,
    @required this.id,
  }) : super(key: key);
  final int id;
  @override
  State<CommentsTabWidget> createState() => _CommentsTabWidgetState();
}

class _CommentsTabWidgetState extends State<CommentsTabWidget> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'email': null,
    'name': null,
    'comment': null,
    'review': null
  };

  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  void onSubmit() async {
    if (_formData['comment'] == null || _formData['comment'] == '') {
      return;
    } else {
      Get.back();
      final resturantProvider =
          Provider.of<RestaurantsProvider>(context, listen: false);
      var result = await resturantProvider.addComment(widget.id, _formData);
      if (result['success']) {
        await messageDialog('تم إضافة التقييم بنجاح');
      } else {
        if (result['error'] != null) {
          if (result['error'].toString().contains('برجاء أختيار مطعم')) {
            messageDialog('برجاء أختيار مطعم');
          } else if (result['error']
              .toString()
              .contains('برجاء أختيار البريد إلكترونى')) {
            messageDialog('برجاء أختيار البريد إلكترونى');
          } else if (result['error']
              .toString()
              .contains('برجاء أختيار الاسم')) {
            messageDialog('برجاء أختيار الاسم');
          } else if (result['error']
              .toString()
              .contains('برجاء أختيار التقييم')) {
            messageDialog('برجاء أختيار التقييم');
          } else if (result['error']
              .toString()
              .contains('برجاء أختيار تعليق')) {
            messageDialog('برجاء أختيار تعليق');
          } else {
            messageDialog('حدث خطأ ما حاول مرة اخرى لاحقاً.');
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final resturantProvider =
        Provider.of<RestaurantsProvider>(context, listen: false);
    return Padding(
      padding: EdgeInsets.only(
          top: getProportionateScreenHeight(5),
          left: getProportionateScreenWidth(10),
          right: getProportionateScreenWidth(10)),
      child: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            DefaultButton(
                textColor: Colors.white,
                onPressed: () {
                  final userProvier =
                      Provider.of<UserProvider>(context, listen: false);
                  dialog(userProvier);
                },
                child: Text('إضافة تقييم جديد'),
                color: kPrimaryColor,
                minWidth: 0.0,
                height: getProportionateScreenHeight(45)),
            SizedBox(
              height: getProportionateScreenHeight(30),
            )
          ])),
          CommentsWidget(comments: resturantProvider.comments)
        ],
      ),
    );
  }

  Future<void> messageDialog(String message) {
    return Get.defaultDialog(
        content: Text(message),
        textCancel: 'إغلاق',
        title: '',
        buttonColor: kPrimaryColor,
        cancelTextColor: kTextColor);
  }

  void dialog(UserProvider userProvider) {
    if (userProvider.user != null) {
      _formData['email'] = userProvider.user.email;
      _formData['name'] = userProvider.user.fullName;
    }
    Get.defaultDialog(
        title: '',
        content: userProvider.user == null
            ? Column(
                children: [
                  Text('يجب تسجبل الدخول أولا.'),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DefaultButton(
                        onPressed: () {
                          Get.toNamed(SignInScreen.routeName);
                        },
                        child: Text('تسجيل الدخول'),
                        color: kPrimaryColor,
                        textColor: Colors.white,
                        minWidth: getProportionateScreenWidth(60),
                        height: getProportionateScreenHeight(45),
                      ),
                      DefaultButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text('الغاء'),
                        color: kPrimaryColor,
                        textColor: Colors.white,
                        minWidth: getProportionateScreenWidth(60),
                        height: getProportionateScreenHeight(40),
                      ),
                    ],
                  )
                ],
              )
            : Container(
                width: SizeConfig.screenWidth * 0.8,
                height: SizeConfig.screenHeight * 0.5,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CommentsForm(
                        formData: _formData,
                        formKey: _formKey,
                      ),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      DefaultButton(
                        onPressed: () {
                          onSubmit();
                        },
                        child: Text('إرسال'),
                        color: kPrimaryColor,
                        textColor: Colors.white,
                        minWidth: getProportionateScreenWidth(80),
                        height: getProportionateScreenHeight(40),
                      ),
                    ],
                  ),
                ),
              ),
        buttonColor: kPrimaryColor,
        cancelTextColor: kTextColor);
  }
}
