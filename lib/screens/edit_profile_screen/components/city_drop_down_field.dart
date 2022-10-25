import 'package:flutter/material.dart';
import 'package:menu_egypt/models/City.dart';
import 'package:menu_egypt/utilities/constants.dart';

class CityDropDownField extends StatelessWidget {
  const CityDropDownField({
    Key key,
    @required this.text,
    @required this.value,
    @required this.items,
    @required this.onChanged,
  }) : super(key: key);
  final String text;
  final CityModel value;
  final Function onChanged;
  final List<CityModel> items;
  @override
  Widget build(BuildContext context) {
    return new DropdownButton<CityModel>(
      value: value,
      items: items.map<DropdownMenuItem<CityModel>>((CityModel city) {
        return new DropdownMenuItem<CityModel>(
          value: city,
          child: new Text(city.nameAr),
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
