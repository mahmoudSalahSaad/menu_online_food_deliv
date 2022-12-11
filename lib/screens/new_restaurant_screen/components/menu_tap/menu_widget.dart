import 'package:flutter/material.dart';
import 'package:menu_egypt/utilities/size_config.dart';

import 'image_slider_dialog.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({
    Key key,
    @required this.images,
  }) : super(key: key);

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    /*
    return SingleChildScrollView(
      child: ListView.separated(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                imageDialog(images, index, context);
              },
              child: FittedBox(
                fit: BoxFit.cover,
                child: Image.network('${images[index]}'),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            );
          },
          itemCount: images.length),
    );
  */
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, index) {
        return Column(
          children: [
            Container(
                width: double.infinity,
                child: InteractiveViewer(
                  minScale: 0.5,
                  maxScale: 4,
                  child: GestureDetector(
                    onTap: () {
                      imageDialog(images, index, context);
                    },
                    child: Image.network(images[index]),
                  ),
                )),
            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            )
          ],
        );
      }, childCount: images.length),
    );
  }

  void imageDialog(List<String> menus, index, context) {
    showGeneralDialog(
        context: context, // background color
        barrierDismissible: false,
        transitionDuration: Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) {
          // your widget implementation
          return ImageDialog(images: images, index: index);
        });
  }
}
