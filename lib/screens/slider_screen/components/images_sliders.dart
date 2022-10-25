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
                  child: FadeInImage.assetNetwork(
                      fit: BoxFit.fill,
                      placeholder: 'assets/images/01-Splash-Screen.png',
                      image: image),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
