import 'package:flutter/material.dart';

import 'package:menu_egypt/screens/slider_screen/components/body.dart';
import 'package:menu_egypt/utilities/size_config.dart';

class SliderScreen extends StatefulWidget {
  static String routeName = '/slider_screen';

  @override
  _SliderScreenState createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body:  Body(),
    );
  }
}
