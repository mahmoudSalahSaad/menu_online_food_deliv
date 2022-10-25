import 'package:flutter/material.dart';
import 'package:menu_egypt/models/Region.dart';
import 'package:menu_egypt/utilities/constants.dart';

class RegionDropDownField extends StatelessWidget {
  const RegionDropDownField({
    Key key,
    @required this.text,
    @required this.value,
    @required this.items,
    @required this.onChanged,
  }) : super(key: key);
  final String text;
  final RegionModel value;
  final Function onChanged;
  final List<RegionModel> items;
  @override
  Widget build(BuildContext context) {
    return new DropdownButton<RegionModel>(
      value: value,
      items: items.map((RegionModel region) {
        return new DropdownMenuItem<RegionModel>(
          value: region,
          child: Text(region.nameAr),
        );
      }).toList(),
      selectedItemBuilder: (BuildContext context) {
        return items.map<Widget>((value) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
            child: Text(value.nameAr,
                style: TextStyle(
                  color: Colors.white,
                )),
          );
        }).toList();
      },
      hint: Padding(
        padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
        child: Text(text,
            style: TextStyle(
              color: Colors.white,
            )),
      ),
      isExpanded: true,
      itemHeight: kDefaultButtonHeight * 1.4,
      onChanged: onChanged,
    );
  }
}
