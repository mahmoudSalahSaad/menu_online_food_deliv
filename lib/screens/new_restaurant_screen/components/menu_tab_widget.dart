import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/providers/resturant_items_provider.dart';
import 'package:menu_egypt/screens/new_restaurant_screen/components/menu_tap/menu_widget_slider.dart';
import 'package:menu_egypt/screens/new_restaurant_screen/resturant_screen_new.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';

import 'menu_tap/menu_widget.dart';

class MenuTabWidget extends StatelessWidget {
  const MenuTabWidget(
      {Key key,
      @required this.images,
      @required this.date,
      @required this.isOnline,
      @required this.isOutOfTime,
      @required this.restId})
      : super(key: key);
  final int restId;
  final List<String> images;
  final String date, isOnline, isOutOfTime;
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
                isOnline == 'yes' && isOutOfTime == 'no'
                    ? MaterialButton(
                        onPressed: () {
                          print('RESTURANT ID ' + restId.toString());
                          Provider.of<ResturantItemsProvider>(context,
                                  listen: false)
                              .getResturantCategories(restId);
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
                    : isOnline == 'yes' && isOutOfTime == 'yes'
                        ? IgnorePointer(
                            child: MaterialButton(
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
                              color: Colors.black87,
                              child: Text('اطلب اونلاين'),
                            ),
                          )
                        : SizedBox(),
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
