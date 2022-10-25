import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../../utilities/size_config.dart';

class ImageDialog extends StatelessWidget {
  const ImageDialog({
    Key key,
    @required this.images,
    @required this.index,
  }) : super(key: key);

  final List<String> images;
  final int index;
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Scaffold(
        body: SafeArea(
          child: Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.close)),
              ),
              Expanded(
                child: Container(
                  width: SizeConfig.screenWidth,
                  child: PhotoViewGallery.builder(
                    scrollPhysics: const BouncingScrollPhysics(),
                    builder: (BuildContext context, int index) {
                      return PhotoViewGalleryPageOptions(
                        basePosition: Alignment.topCenter,
                        imageProvider: NetworkImage(images[index]),
                        initialScale: PhotoViewComputedScale.covered,
                        heroAttributes:
                            PhotoViewHeroAttributes(tag: images[index]),
                      );
                    },
                    itemCount: images.length,
                    loadingBuilder: (context, event) => Center(
                      child: Container(
                        width: 20.0,
                        height: 20.0,
                        child: CircularProgressIndicator(
                          value: event == null
                              ? 0
                              : event.cumulativeBytesLoaded /
                                  event.expectedTotalBytes,
                        ),
                      ),
                    ),
                    pageController: PageController(initialPage: index),
                    onPageChanged: (int) {},
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
