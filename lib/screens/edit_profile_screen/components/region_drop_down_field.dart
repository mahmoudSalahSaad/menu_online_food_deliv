import 'package:flutter/material.dart';
import 'package:menu_egypt/models/Region.dart';
import 'package:menu_egypt/utilities/size_config.dart';

class RegionDropDownField extends StatelessWidget {
  const RegionDropDownField({
    Key? key,
    @required this.text,
    @required this.value,
    @required this.items,
    @required this.onChanged,
  }) : super(key: key);
  final String? text;
  final RegionModel? value;
  final Function(RegionModel)? onChanged;
  final List<RegionModel>? items;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xffF7F7F9) ,
          borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)) ,
          border: Border.all(color: Color(0xffE4E4E5))
      ),
      child: new DropdownButton<RegionModel>(
        value: value,
        items: items!.map((RegionModel region) {
          return new DropdownMenuItem<RegionModel>(
            value: region,
            child: Text(region.nameAr ,style: TextStyle(
              color: Colors.black,
            ), ),
          );
        }).toList(),
        selectedItemBuilder: (BuildContext context) {
          return items!.map<Widget>((value) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 10),
              child: Row(
                children: [
                  Image.asset("assets/icons/Group 1000000793.png") ,
                  SizedBox(
                    width: getProportionateScreenWidth(16),
                  ),
                  Text(value.nameAr,
                      style: TextStyle(
                        color: Colors.black,
                      ))
                ],
              ),
            );
          }).toList();
        },
        hint: Padding(
          padding: const EdgeInsets.symmetric(vertical:10 ,  horizontal: 10),
          child:  Row(
            children: [
              Image.asset("assets/icons/Group 1000000793.png") ,
              SizedBox(
                width: getProportionateScreenWidth(16),
              ),
              Text(value!.nameAr!,
                  style: TextStyle(
                    color: Colors.black,
                  ))
            ],
          ),
        ),
        underline: const SizedBox(),
        dropdownColor: Colors.white,

        icon: Padding(
          padding: EdgeInsets.only(left: 10),
          child: Image.asset("assets/icons/Vector (1).png"),
        ),
        isExpanded: true,
        
        onChanged: (value)=>onChanged!(value!),
      ),
    );
  }
}
