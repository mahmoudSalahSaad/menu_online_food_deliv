import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:menu_egypt/utilities/constants.dart';

class LoadingCircle extends StatelessWidget {
  const LoadingCircle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.stretchedDots(
        color: kPrimaryColor,
        size: 50,
      ),
    );
  }
}
