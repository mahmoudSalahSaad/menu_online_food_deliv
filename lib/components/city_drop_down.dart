import 'package:flutter/material.dart';
import 'package:menu_egypt/models/City.dart';
import 'package:menu_egypt/utilities/constants.dart';

import '../utilities/size_config.dart';

class CityDropDownField extends StatelessWidget {
  const CityDropDownField({
    Key key,
    @required this.value,
    @required this.items,
    @required this.onChanged,
  }) : super(key: key);
  final CityModel value;
  final Function onChanged;
  final List<CityModel> items;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
      height: getProportionateScreenHeight(36),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.25),
          borderRadius: BorderRadius.circular(kDefaultPadding / 1.5)),
      child: new DropdownButton<CityModel>(
        value: value,
        items: items.map<DropdownMenuItem<CityModel>>((CityModel city) {
          return new DropdownMenuItem<CityModel>(
            value: city,
            child: new Text(city.nameAr),
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
        onChanged: onChanged,
        itemHeight: getProportionateScreenHeight(50),
      ),
    );
  }
}
