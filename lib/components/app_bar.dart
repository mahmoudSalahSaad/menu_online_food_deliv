import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/utilities/size_config.dart';

class AppBarWidget extends StatelessWidget {
  AppBarWidget(
      { this.title,
       this.withBack,
      this.navigationPage = ''});

  final String? title;
  final String? navigationPage;
  final bool? withBack;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: getProportionateScreenHeight(0.0)),
      decoration: BoxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          withBack!
              ? GestureDetector(
                  onTap: () {
                    if (navigationPage!.isNotEmpty) {
                      Get.toNamed(navigationPage!);
                    } else {
                      Get.back();
                    }
                  },
                  child: Container(
                    height: getProportionateScreenHeight(40),
                    width: getProportionateScreenHeight(40),
                    decoration: BoxDecoration(
                      color: Color(0xffF7F7F9) ,
                      shape: BoxShape.circle
                    ),
                    child: Icon(FontAwesomeIcons.chevronRight , color: Colors.black,size: getProportionateScreenHeight(13),),
                  ),
                )
              : SizedBox(
            width: getProportionateScreenHeight(40),
          ),
          // Spacer(
          //   flex: 2,
          // ),
          Text(
            title.toString(),
            style: TextStyle(
              fontSize: getProportionateScreenHeight(18),
              fontWeight: FontWeight.bold,
              color: Colors.black
            ),
          ),
          SizedBox(
            width: getProportionateScreenHeight(40),
          )
          // Spacer(
          //   flex: 3,
          // ),
        ],
      ),
    );
  }
}
