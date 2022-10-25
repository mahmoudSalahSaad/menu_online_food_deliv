import 'package:flutter/material.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';

class TextIconWidget extends StatelessWidget {
  const TextIconWidget(
      {Key key,
      @required this.text,
      @required this.icon,
      @required this.onTap,
      this.isFav,
      this.fav})
      : super(key: key);

  final String text;
  final Function onTap;
  final IconData icon;
  final bool isFav;
  final bool fav;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          fav
              ? Container(
                  width: kDefaultHeight,
                  height: kDefaultHeight,
                  child: Icon(
                    icon,
                    size: getProportionateScreenHeight(20),
                    color: Colors.white,
                  ),
                )
              : Container(
                  width: kDefaultHeight,
                  height: kDefaultHeight,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: kPrimaryColor),
                  child: Icon(
                    icon,
                    size: kDefaultPadding,
                  ),
                ),
          SizedBox(width: getProportionateScreenHeight(10.0)),
          Text(
            text,
            style: TextStyle(fontSize: SizeConfig.screenWidth * 0.05),
          ),
        ],
      ),
    );
  }
}
