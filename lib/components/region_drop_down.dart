import 'package:flutter/material.dart';
import 'package:menu_egypt/models/Region.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';

class RegionDropDownField extends StatelessWidget {
  const RegionDropDownField({
    Key? key,
     this.value,
     this.items,
     this.onChanged,
  }) : super(key: key);
  final RegionModel? value;
  final Function(RegionModel)? onChanged;
  final List<RegionModel>? items;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
      height: getProportionateScreenHeight(50),
      decoration: BoxDecoration(
          color: Color(0xffF7F7F9),
          border: Border.all(color: Color(0xffE4E4E5)),
          borderRadius: BorderRadius.circular(kDefaultPadding / 1.5)),
      child: new DropdownButton<RegionModel>(
        value: value,
        icon: Image.asset("assets/icons/Vector (1).png"),
        dropdownColor: Colors.white,
        items: items!.map<DropdownMenuItem<RegionModel>>((RegionModel region) {
          return new DropdownMenuItem<RegionModel>(
            value: region,
            child: new Text(region.nameAr , style: TextStyle(
              color: Colors.black ,
              fontSize: 18
            ),),
          );
        }).toList(),
        underline: Container(),
        selectedItemBuilder: (BuildContext context) {
          return items!.map<Widget>((value) {
            return Align(
              alignment: Alignment.centerRight,
              child: Row(
                children: [

                  Text(value.nameAr,
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
        onChanged: (RegionModel? model)=> onChanged,
        // itemHeight: getProportionateScreenHeightreenHeight(50),
      ),
    );
  }
}
