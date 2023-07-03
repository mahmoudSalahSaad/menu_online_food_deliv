import 'package:flutter/material.dart';
import 'package:menu_egypt/models/Category.dart';
import 'package:menu_egypt/utilities/constants.dart';

import '../utilities/size_config.dart';

class CategoriesDropDownField extends StatelessWidget {
  const CategoriesDropDownField({
    Key? key,
     this.value,
     this.items,
     this.onChanged,
  }) : super(key: key);
  final CategoryModel? value;
  final Function(CategoryModel?)? onChanged;
  final List<CategoryModel>? items;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      height: getProportionateScreenHeight(50),
      decoration: BoxDecoration(
          color: Color(0xffF7F7F9),
          border: Border.all(
            color: Color(0xffE4E4E5)
          ),
          borderRadius: BorderRadius.circular(kDefaultPadding / 1.5)),
      child: new DropdownButton<CategoryModel>(
        value: value,
        icon: Image.asset("assets/icons/Vector (1).png"),
        dropdownColor: Colors.white,

        items: items
            !.map<DropdownMenuItem<CategoryModel>>((CategoryModel category) {
          return new DropdownMenuItem<CategoryModel>(
            value: category,
            child: new Text(category.nameAr!, style: TextStyle(
              color: Colors.black,
              fontSize: 18
            )),
          );
        }).toList(),
        underline: Container(),

        selectedItemBuilder: (BuildContext context) {
          return items!.map<Widget>((value) {
            return Align(
              alignment: Alignment.centerRight,
              child: Text(value.nameAr!,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18 ,
                      height:1.6

                  )),
            );
          }).toList();
        },
        isExpanded: true,
        // itemHeight: getProportionateScreenHeight(50),
        onChanged: (value) =>onChanged!(value!),
      ),
    );
  }
}
