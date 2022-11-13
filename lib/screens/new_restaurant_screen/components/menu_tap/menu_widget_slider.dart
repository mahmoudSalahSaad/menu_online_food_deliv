import 'package:flutter/material.dart';
import 'package:menu_egypt/utilities/size_config.dart';

class MenuWidgetSlider extends StatelessWidget {
  const MenuWidgetSlider({Key key, @required this.image}) : super(key: key);
  final String image;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: getProportionateScreenHeight(350),
          width: getProportionateScreenWidth(350),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: NetworkImage(image),
          )),
        ),
      ],
    );
  }
}
