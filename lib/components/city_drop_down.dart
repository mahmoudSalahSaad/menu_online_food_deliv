import 'package:flutter/material.dart';
import 'package:menu_egypt/models/City.dart';
import 'package:menu_egypt/utilities/constants.dart';

import '../utilities/size_config.dart';

class CityDropDownField extends StatelessWidget {
  const CityDropDownField({
    Key? key,
     this.value,
     this.items,
     this.onChanged,
  }) : super(key: key);
  final CityModel? value;
  final Function(CityModel)? onChanged;
  final List<CityModel>? items;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
      height: getProportionateScreenHeight(50),

      decoration: BoxDecoration(
          color: Color(0xffF7F7F9),
          border: Border.all(color:Color(0xffE4E4E5) ),
          borderRadius: BorderRadius.circular(kDefaultPadding / 1.5)),
      child: new DropdownButton<CityModel>(
        value: value,
        dropdownColor:Colors.white,
        icon: Image.asset("assets/icons/Vector (1).png"),
        items: items!.map<DropdownMenuItem<CityModel>>((CityModel city) {
          return new DropdownMenuItem<CityModel>(
            value: city,

            child: new Text(city.nameAr!,style: TextStyle(
              color: Colors.black,
            )),
          );
        }).toList(),
        underline: Container(),
        selectedItemBuilder: (BuildContext context) {
          return items!.map<Widget>((value) {
            return Align(
              alignment: Alignment.centerRight,
              child: Row(
                children: [

                  Text(value.nameAr!,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18 ,
                        height: 2.0
                      ))
                ],
              ),
            );
          }).toList();
        },
        isExpanded: true,
        onChanged: (value)=>onChanged!(value!),
        // itemHeight: getProportionateScreenHeight(30),
      ),
    );
  }
}
