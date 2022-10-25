import 'package:flutter/material.dart';
import 'package:menu_egypt/models/Region.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';

class RegionDropDownField extends StatelessWidget {
  const RegionDropDownField({
    Key key,
    @required this.value,
    @required this.items,
    @required this.onChanged,
  }) : super(key: key);
  final RegionModel value;
  final Function onChanged;
  final List<RegionModel> items;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
      height: getProportionateScreenHeight(36),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.25),
          borderRadius: BorderRadius.circular(kDefaultPadding / 1.5)),
      child: new DropdownButton<RegionModel>(
        value: value,
        items: items.map<DropdownMenuItem<RegionModel>>((RegionModel region) {
          return new DropdownMenuItem<RegionModel>(
            value: region,
            child: new Text(region.nameAr),
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
