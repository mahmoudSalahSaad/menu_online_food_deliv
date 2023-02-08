import 'package:flutter/material.dart';
import 'package:menu_egypt/utilities/size_config.dart';


class MenuWidget extends StatelessWidget {
  const MenuWidget({
    Key key,
    @required this.images,
  }) : super(key: key);

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
            (BuildContext context, index) {
          return Column(
            children: [
              Container(
                  width: double.infinity,
                  child: Image.network(images[index])
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              )
            ],
          );
        }, childCount: images.length),
      );
  }
}
