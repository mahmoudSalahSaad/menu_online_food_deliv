import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
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
    return Column(
      children: List.generate(
        images.length,
        (index) => Column(
          children: [
            InstaImageViewer(
              child:
                  CachedNetworkImage(key: UniqueKey(), imageUrl: images[index]),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            )
          ],
        ),
      ),
    );
    /*
ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        },
      ),
      child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => InstaImageViewer(
                child: CachedNetworkImage(
                    key: UniqueKey(), imageUrl: images[index]),
              ),
          separatorBuilder: (context, index) => SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
          itemCount: images.length),
    );
    */

    /*
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, index) {
        return Column(
          children: [
            InstaImageViewer(
              child:
                  CachedNetworkImage(key: UniqueKey(), imageUrl: images[index]),
            ),

            /*
            Container(
                width: double.infinity,
                child: InteractiveViewer(
                  minScale: 0.5,
                  maxScale: 4,
                  child: GestureDetector(
                    onTap: () {
                      imageDialog(images, index, context);
                    },
                    child: CachedNetworkImage(
                        key: UniqueKey(), imageUrl: images[index]),
                  ),
                )),
                */
            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            )
          ],
        );
      }, childCount: images.length),
    );
            */
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
