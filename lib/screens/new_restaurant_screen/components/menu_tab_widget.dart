import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/providers/resturant_items_provider.dart';
import 'package:menu_egypt/screens/new_restaurant_screen/components/menu_tap/menu_widget_slider.dart';
import 'package:menu_egypt/screens/new_restaurant_screen/resturant_screen_new.dart';
import 'package:menu_egypt/screens/slider_screen/components/images_sliders.dart';
import 'package:menu_egypt/screens/slider_screen/components/slider_dots.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';

import 'menu_tap/menu_widget.dart';

class MenuTabWidget extends StatefulWidget {
  const MenuTabWidget({
    Key key,
    @required this.images,
    @required this.date,
    @required this.isOnline,
    @required this.isOutOfTime,
    @required this.restId,
    @required this.sliderImages,
    @required this.sliderImagesLink,
  }) : super(key: key);
  final int restId;
  final List<String> images, sliderImages;
  final String date, isOnline, isOutOfTime, sliderImagesLink;

  @override
  State<MenuTabWidget> createState() => _MenuTabWidgetState();
}

class _MenuTabWidgetState extends State<MenuTabWidget> {
  int _pageIndex = 0;
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
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  ImagesSlider(
                    imagesSliders: widget.sliderImages,
                    pageIndex: _pageIndex,
                    onPageChange: (index, reason) {
                      setState(() {
                        _pageIndex = index;
                      });
                    },
                  ),
                  SliderDots(
                      imagesSliders: widget.sliderImages,
                      pageIndex: _pageIndex),
                ],
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.date.isNotEmpty
                    ? Text('المنيو بتاريخ : ' + widget.date)
                    : Text(''),
                widget.isOnline == 'yes' && widget.isOutOfTime == 'no'
                    ? MaterialButton(
                        onPressed: () {
                          print('RESTURANT ID ' + widget.restId.toString());
                          Provider.of<ResturantItemsProvider>(context,
                                  listen: false)
                              .getResturantCategories(widget.restId);
                          Get.offNamed(ResturantScreenNew.routeName);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: Colors.white,
                            width: getProportionateScreenWidth(1),
                            style: BorderStyle.solid,
                          ),
                        ),
                        color: Colors.black,
                        child: Text('اطلب اونلاين'),
                      )
                    : widget.isOnline == 'yes' && widget.isOutOfTime == 'yes'
                        ? IgnorePointer(
                            child: MaterialButton(
                              onPressed: () {
                                Get.offNamed(ResturantScreenNew.routeName);
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: Colors.grey[600],
                                  width: getProportionateScreenWidth(1),
                                  style: BorderStyle.solid,
                                ),
                              ),
                              color: Colors.grey,
                              child: Text('خارج توقيت العمل'),
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
          widget.images.length == 0
              ? SliverList(
                  delegate: SliverChildListDelegate([
                  Center(
                      child: Container(
                          child: Text('لا يوجد قوائم طعام لهذا المطعم')))
                ]))
              : MenuWidget(images: widget.images)
        ],
      ),
    );
  }
}
