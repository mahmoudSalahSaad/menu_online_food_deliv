import 'package:flutter/material.dart';
import 'package:menu_egypt/models/Restaurant.dart';
import 'package:menu_egypt/screens/new_restaurant_screen/components/branches_tap/areas_widget.dart';
import 'package:menu_egypt/utilities/size_config.dart';

import 'branches_tap/branches_widget.dart';

class BranchesTabWidget extends StatelessWidget {
  const BranchesTabWidget(
      {Key? key,  this.resturant,  this.areas})
      : super(key: key);
  final RestaurantModel? resturant;
  final List<String>? areas;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: getProportionateScreenHeight(5),
          left: getProportionateScreenWidth(10),
          right: getProportionateScreenWidth(16)),
      child: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                  height: 6,
                ),
            Text('الفروع' , style: TextStyle(
              color: Colors.black ,
              fontSize: 20 ,
              fontWeight: FontWeight.bold
            ),),

          ])),
          BranchesWidget(resturant: resturant),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Text('مناطق التوصيل' , style: TextStyle(
              fontSize: 18 ,
              fontWeight: FontWeight.bold
            ),),
            SizedBox(
              height: 4,
            )

          ])),
          AreasWidget(areas: areas),
        ],
      ),
    );
  }
}
