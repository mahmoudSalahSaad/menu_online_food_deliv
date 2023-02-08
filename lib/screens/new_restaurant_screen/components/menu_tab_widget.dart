import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/providers/restaurants_provider.dart';
import 'package:menu_egypt/providers/resturant_items_provider.dart';
import 'package:menu_egypt/screens/new_restaurant_screen/resturant_screen_new.dart';
import 'package:menu_egypt/screens/slider_screen/components/images_sliders.dart';
import 'package:menu_egypt/screens/slider_screen/components/slider_dots.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverList(
                  delegate: SliverChildListDelegate([
                    GestureDetector(
                      child: SizedBox(
                        height: 400,
                        width: 400,
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
                      onTap: () {
                        if (Platform.isIOS) {
                          print('ios');
                          Provider.of<RestaurantsProvider>(context, listen: false)
                              .detectAddsClick(widget.restId, 'ios')
                              .then((value) {
                            if (value['status']) {
                              _launchUrl();
                            }
                          });
                        } else if (Platform.isAndroid) {
                          print('android');
                          Provider.of<RestaurantsProvider>(context, listen: false)
                              .detectAddsClick(widget.restId, 'android')
                              .then((value) {
                            if (value['status']) {
                              _launchUrl();
                            }
                          });
                        } else {
                          print('something else');
                        }
                      },
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

                      ],
                    ),
                    Divider(
                      thickness: 2,
                      color: Colors.black,
                    ),


                  ])),
              widget.images.length == 0
                  ? SliverList(
                  delegate: SliverChildListDelegate([
                    Center(
                        child: Container(
                            child: Text('لا يوجد قوائم طعام لهذا المطعم')))
                  ]))
                  : SliverToBoxAdapter(child: MenuWidget(images: widget.images ,isOnline: widget.isOnline,isOutOfTime: widget.isOutOfTime,)) ,



            ],
          ) ,
          Align(
            alignment: Alignment.bottomCenter,
            child: widget.isOnline == 'yes' && widget.isOutOfTime == 'no'
                ? MaterialButton(
              onPressed: () {
                print('RESTURANT ID ' + widget.restId.toString());
                Provider.of<ResturantItemsProvider>(context,
                    listen: false)
                    .getResturantCategoriesAndProducts(widget.restId);
                Get.toNamed(ResturantScreenNew.routeName);
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
                  Get.toNamed(ResturantScreenNew.routeName);
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
          )



        ],
      ),
    );
  }

  Future<void> _launchUrl() async {
    final Uri _url = Uri.parse('${widget.sliderImagesLink}');
    if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $_url';
    }
  }
}
