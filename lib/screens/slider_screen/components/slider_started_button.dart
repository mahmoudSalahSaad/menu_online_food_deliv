import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/components/default_button.dart';
import 'package:menu_egypt/screens/home_screen/home_screen.dart';
import 'package:menu_egypt/utilities/constants.dart';

class SliderStartedButton extends StatelessWidget {
  const SliderStartedButton({
    Key ?key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: DefaultButton(
            textColor: Colors.white,
            onPressed: () {
              Get.offAllNamed(HomeScreen.routeName);
            },
            color: kPrimaryColor,
            child: Text('إبدأ'),
            minWidth: double.infinity,
            height: kDefaultButtonHeight,
          ),
        ),
        SizedBox(
          height: kDefaultButtonHeight / 2,
        )
      ],
    );
  }
}
