import 'package:flutter/material.dart';
import 'package:menu_egypt/utilities/size_config.dart';

class SliderDots extends StatelessWidget {
  const SliderDots({
    Key key,
    @required this.imagesSliders,
    @required this.pageIndex,
  }) : super(key: key);

  final List<String> imagesSliders;
  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imagesSliders.map((image) {
            int index = imagesSliders.indexOf(image);
            return Container(
              width: getProportionateScreenWidth(8),
              height: getProportionateScreenHeight(8),
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: pageIndex == index
                    ? Color.fromRGBO(255, 255, 255, 0.9)
                    : Color.fromRGBO(255, 255, 255, 0.3),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
