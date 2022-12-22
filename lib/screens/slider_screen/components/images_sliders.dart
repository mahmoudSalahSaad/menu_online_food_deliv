import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImagesSlider extends StatelessWidget {
  ImagesSlider(
      {Key key,
      @required this.imagesSliders,
      @required this.onPageChange,
      @required this.pageIndex})
      : super(key: key);

  final List<String> imagesSliders;
  final Function onPageChange;
  final int pageIndex;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        child: CarouselSlider(
          options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 2),
              height: double.infinity,
              viewportFraction: 1.0,
              initialPage: pageIndex,
              enableInfiniteScroll: false,
              reverse: false,
              scrollDirection: Axis.horizontal,
              onPageChanged: onPageChange),
          items: imagesSliders.map((image) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(),
                  child: CachedNetworkImage(key: UniqueKey(), imageUrl: image , width: 1000,fit: BoxFit.fill,),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
