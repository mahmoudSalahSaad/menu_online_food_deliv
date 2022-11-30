import 'package:flutter/material.dart';
import 'package:menu_egypt/providers/user_provider.dart';
import 'package:menu_egypt/screens/slider_screen/components/images_sliders.dart';
import 'package:menu_egypt/screens/slider_screen/components/slider_dots.dart';
import 'package:menu_egypt/screens/slider_screen/components/slider_started_button.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<String> imagesSliders = [
    'https://menuegypt.com/slider_images/slider1.jpg',
  ];

  int _pageIndex = 0;
  @override
  void initState() {
    List<String> sliderImages =
        Provider.of<UserProvider>(context, listen: false).sliders;
    if (imagesSliders.isNotEmpty) {
      imagesSliders = sliderImages;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          ImagesSlider(
            imagesSliders: imagesSliders,
            pageIndex: _pageIndex,
            onPageChange: (index, reason) {
              setState(() {
                _pageIndex = index;
              });
            },
          ),
          SliderDots(imagesSliders: imagesSliders, pageIndex: _pageIndex),
          SliderStartedButton(),
        ],
      ),
    );
  }
}
