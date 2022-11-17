import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/utilities/size_config.dart';

class AppBarWidget extends StatelessWidget {
  AppBarWidget(
      {@required this.title,
      @required this.withBack,
      this.navigationPage = ''});

  final String title;
  final String navigationPage;
  final bool withBack;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: getProportionateScreenHeight(5.0)),
      decoration: BoxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          withBack
              ? IconButton(
                  onPressed: () {
                    if (navigationPage.isNotEmpty) {
                      Get.toNamed(navigationPage);
                    } else {
                      Get.back();
                    }
                  },
                  icon: Icon(FontAwesomeIcons.chevronRight),
                )
              : Spacer(
                  flex: 1,
                ),
          Spacer(
            flex: 2,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: getProportionateScreenHeight(16),
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(
            flex: 3,
          ),
        ],
      ),
    );
  }
}
