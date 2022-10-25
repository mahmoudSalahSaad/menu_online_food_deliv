import 'package:flutter/material.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';

class TextIconWidget extends StatelessWidget {
  const TextIconWidget({
    Key key,
    @required this.text,
    @required this.icon,
    @required this.onTap,
  }) : super(key: key);

  final String text;
  final Function onTap;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: kDefaultHeight,
                      height: kDefaultHeight,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: kPrimaryColor),
                      child: Icon(
                        icon,
                        size: kDefaultPadding,
                      ),
                    ),
                    SizedBox(width: getProportionateScreenWidth(5)),
                    Text(
                      text,
                      maxLines: 3,
                      style:
                          TextStyle(fontSize: getProportionateScreenWidth(18)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
