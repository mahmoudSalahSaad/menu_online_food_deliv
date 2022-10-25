import 'package:flutter/material.dart';
import 'package:menu_egypt/utilities/constants.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton(
      {Key key,
      @required this.onPressed,
      @required this.child,
      @required this.color,
      @required this.textColor,
      @required this.minWidth,
      @required this.height})
      : super(key: key);
  final Widget child;
  final Function onPressed;
  final Color color;
  final Color textColor;
  final double minWidth;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: MaterialButton(
        onPressed: onPressed,
        height: height,
        minWidth: minWidth == 0.0 ? double.infinity : minWidth,
        color: color,
        textColor: textColor,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(kDefaultPadding / 4))),
        child: child,
      ),
    );
  }
}
