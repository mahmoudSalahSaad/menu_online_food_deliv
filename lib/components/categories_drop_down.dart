import 'package:flutter/material.dart';
import 'package:menu_egypt/models/Category.dart';
import 'package:menu_egypt/utilities/constants.dart';

import '../utilities/size_config.dart';

class CategoriesDropDownField extends StatelessWidget {
  const CategoriesDropDownField({
    Key key,
    @required this.value,
    @required this.items,
    @required this.onChanged,
  }) : super(key: key);
  final CategoryModel value;
  final Function onChanged;
  final List<CategoryModel> items;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
      height: getProportionateScreenHeight(36),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.25),
          borderRadius: BorderRadius.circular(kDefaultPadding / 1.5)),
      child: new DropdownButton<CategoryModel>(
        value: value,
        items: items
            .map<DropdownMenuItem<CategoryModel>>((CategoryModel category) {
          return new DropdownMenuItem<CategoryModel>(
            value: category,
            child: new Text(category.nameAr),
          );
        }).toList(),
        underline: Container(),
        selectedItemBuilder: (BuildContext context) {
          return items.map<Widget>((value) {
            return Align(
              alignment: Alignment.centerRight,
              child: Text(value.nameAr,
                  style: TextStyle(
                    color: Colors.white,
                  )),
            );
          }).toList();
        },
        isExpanded: true,
        itemHeight: getProportionateScreenHeight(50),
        onChanged: onChanged,
      ),
    );
  }
}
