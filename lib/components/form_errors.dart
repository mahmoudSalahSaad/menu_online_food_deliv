import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';

class FormErrors extends StatelessWidget {
  const FormErrors({
    Key? key,
     this.errors,
  }) : super(key: key);

  final List<String>? errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(errors!.length, (index) => buildErrorRow(errors![index]))
      ],
    );
  }

  Row buildErrorRow(String error) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/icons/error.svg',
          height: getProportionateScreenWidth(20),
          width: getProportionateScreenWidth(20),
          color: Colors.red,
        ),
        SizedBox(
          width: getProportionateScreenWidth(10),
        ),
        Text(
          error,
          style: TextStyle(
            color: Colors.black,
            fontSize: getProportionateScreenWidth(14),
          ),
        ),
      ],
    );
  }
}
