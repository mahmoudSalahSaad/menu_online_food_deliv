import 'package:flutter/material.dart';
import 'package:menu_egypt/models/Restaurant.dart';
import 'package:menu_egypt/screens/new_restaurant_screen/components/branches_tap/areas_widget.dart';
import 'package:menu_egypt/utilities/size_config.dart';

import 'branches_tap/branches_widget.dart';

class BranchesTabWidget extends StatelessWidget {
  const BranchesTabWidget(
      {Key key, @required this.resturant, @required this.areas})
      : super(key: key);
  final RestaurantModel resturant;
  final List<String> areas;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: getProportionateScreenHeight(5),
          left: getProportionateScreenWidth(10),
          right: getProportionateScreenWidth(10)),
      child: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            Text('الفروع'),
            Divider(
              color: Colors.black,
              thickness: 3,
            ),
          ])),
          BranchesWidget(resturant: resturant),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Text('مناطق التوصيل'),
            Divider(
              color: Colors.black,
              thickness: 3,
            ),
          ])),
          AreasWidget(areas: areas),
        ],
      ),
    );
  }
}
