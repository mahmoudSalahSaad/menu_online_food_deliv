import 'package:flutter/material.dart';
import 'package:menu_egypt/utilities/size_config.dart';

class IconTextWidget extends StatelessWidget {
  const IconTextWidget(
      {Key? key,
      @required this.icon,
      @required this.iconColor,
      @required this.iconSize,
      this.fontColor,
      this.fontSize,
      @required this.text, this.isImage = false, this.imagePath})
      : super(key: key);
  final bool? isImage ;
  final imagePath ;
  final IconData? icon;
  final Color? iconColor, fontColor;
  final double? fontSize, iconSize;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
       isImage == false?  Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ) :Image.asset(imagePath , height: 18,),
        SizedBox(
          width: getProportionateScreenWidth(2),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: getProportionateScreenHeight(6),
            ),
            Text(
              text.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: fontColor ?? Color(0xff212121),
                  fontSize: fontSize ?? getProportionateScreenHeight(16) ,
                  fontWeight: FontWeight.w400
              ),
            ),
          ],
        ),
      ],
    );
  }
}
