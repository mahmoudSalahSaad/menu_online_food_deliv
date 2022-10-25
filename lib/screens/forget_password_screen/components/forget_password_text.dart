import 'package:flutter/material.dart';
import 'package:menu_egypt/utilities/size_config.dart';

class ForgetPasswordText extends StatelessWidget {
  const ForgetPasswordText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: getProportionateScreenHeight(20.0)),
      child: Column(
        children: [
          Text(
            'أدخل بريدك الإلكتروني وسوف نرسل لك تعليمات حول كيفية إعادة تعيينه',
            style: Theme.of(context).textTheme.headline5.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: getProportionateScreenHeight(14.0)),
          ),
        ],
      ),
    );
  }
}
