import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/screens/new_restaurant_screen/components/menu_tap/menu_widget_slider.dart';
import 'package:menu_egypt/screens/new_restaurant_screen/resturant_screen_new.dart';
import 'package:menu_egypt/utilities/size_config.dart';

import 'menu_tap/menu_widget.dart';

class MenuTabWidget extends StatelessWidget {
  const MenuTabWidget({Key key, @required this.images, @required this.date})
      : super(key: key);
  final List<String> images;
  final String date;
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
            MenuWidgetSlider(
                image:
                    'https://menuegypt.com/images/Dahan-app/Dahan-App-Download.jpg'),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('المنيو بتاريخ : ' + date),
                MaterialButton(
                  onPressed: () {
                    Get.offNamed(ResturantScreenNew.routeName);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: Colors.white,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                  ),
                  color: Colors.black,
                  child: Text('اطلب اونلاين'),
                )
              ],
            ),
            Divider(
              thickness: 2,
              color: Colors.black,
            )
          ])),
          images.length == 0
              ? SliverList(
                  delegate: SliverChildListDelegate([
                  Center(
                      child: Container(
                          child: Text('لا يوجد قوائم طعام لهذا المطعم')))
                ]))
              : MenuWidget(images: images)
        ],
      ),
    );
  }
}
