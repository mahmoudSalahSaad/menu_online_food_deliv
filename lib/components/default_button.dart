import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton(
      {Key? key,
       this.onPressed,
       this.child,
       this.color,
       this.textColor,
       this.minWidth,
       this.height})
      : super(key: key);
  final Widget? child;
  final Function? onPressed;
  final Color? color;
  final Color? textColor;
  final double? minWidth;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0 , vertical: 6),
      child: MaterialButton(
        onPressed: ()=>onPressed!,
        height: height,
        minWidth: minWidth == 0.0 ? double.infinity : minWidth,
        color: color,

        textColor: textColor,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(15)) ,
                side: BorderSide(color: Color(0xffB90101))
        ),
        child: child,
      ),
    );
  }
}
