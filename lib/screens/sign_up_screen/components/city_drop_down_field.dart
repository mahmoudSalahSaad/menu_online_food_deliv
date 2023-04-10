import 'package:flutter/material.dart';
import 'package:menu_egypt/models/City.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';

class CityDropDownField extends StatelessWidget {
  const CityDropDownField({
    Key? key,
     this.text,
     this.value,
     this.items,
     this.onChanged,

  }) : super(key: key);
  final String? text;
  final CityModel? value;
  final Function(CityModel)? onChanged;
  final List<CityModel>? items;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffF7F7F9) ,
        borderRadius: BorderRadius.circular(12) ,
        border: Border.all(color: Color(0xffE4E4E5)) ,

      ),
      child: new DropdownButton<CityModel>(
        value: value,
        items: items!.map<DropdownMenuItem<CityModel>>((CityModel city) {
          return new DropdownMenuItem<CityModel>(
            value: city,
            child: new Text(city.nameAr!, style : TextStyle(
              color: Colors.black,
            )),
          );
        }).toList(),
        selectedItemBuilder: (BuildContext context) {
          return items!.map<Widget>((value) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 10),
              child: Row(
                children: [
                  Image.asset("assets/icons/location.png") ,
                  SizedBox(
                    width: getProportionateScreenWidth(16),
                  ),
                  Text(value.nameAr!,
                      style: TextStyle(
                        color: Colors.black,
                        height: 1.4
                      ))
                ],
              ),
            );
          }).toList();
        },
        hint: Padding(
          padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
          child: Text(text!,
              style: TextStyle(
                color: Colors.black,
                height: 1.8
              )),
        ),
        isExpanded: true,
        icon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Image.asset("assets/icons/Vector (1).png"),
        ),

        underline: const SizedBox(),
        onChanged:(value)=> onChanged,
      ),
    );
  }
}
/*
 decoration: BoxDecoration(
        color: Color(0xffF7F7F9) ,
        borderRadius: BorderRadius.circular(12) ,
        border: Border.all(color: Color(0xffE4E4E5)) ,

      ),
      */
