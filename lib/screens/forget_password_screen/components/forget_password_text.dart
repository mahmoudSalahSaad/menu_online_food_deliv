import 'package:flutter/material.dart';
import 'package:menu_egypt/utilities/size_config.dart';

class ForgetPasswordText extends StatelessWidget {
  const ForgetPasswordText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(330),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'أدخل بريدك الإلكتروني وسوف نرسل لك رمز التأكيد',
            style: Theme.of(context).textTheme.headline5!.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: getProportionateScreenHeight(18.0)),
          ),
        ],
      ),
    );
  }
}
