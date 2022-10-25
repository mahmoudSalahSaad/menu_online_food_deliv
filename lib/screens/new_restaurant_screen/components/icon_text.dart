import 'package:flutter/material.dart';
import 'package:menu_egypt/utilities/size_config.dart';

class IconTextWidget extends StatelessWidget {
  const IconTextWidget(
      {Key key,
      @required this.icon,
      @required this.iconColor,
      @required this.iconSize,
      this.fontColor,
      this.fontSize,
      @required this.text})
      : super(key: key);
  final IconData icon;
  final Color iconColor, fontColor;
  final double fontSize, iconSize;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ),
        SizedBox(
          width: 5,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: getProportionateScreenHeight(5),
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: fontColor ?? Colors.white,
                  fontSize: fontSize ?? getProportionateScreenHeight(16)),
            ),
          ],
        ),
      ],
    );
  }
}
