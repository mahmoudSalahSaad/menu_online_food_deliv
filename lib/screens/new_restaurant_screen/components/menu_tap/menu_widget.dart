import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:menu_egypt/utilities/size_config.dart';

import 'image_slider_dialog.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({
    Key? key,
     this.images, this.isOnline, this.isOutOfTime,
  }) : super(key: key);

  final List<String>? images;
  final String? isOnline ;
  final String? isOutOfTime ;

  @override

  Widget build(BuildContext context) {

    return Column(
      children: [
        Column(
            children: List.generate(
              images!.length,
                  (index) => Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      showImageViewer(context,  Image.network(images![index]).image, onViewerDismissed: () {
                        print("dismissed");
                      });

                    },
                    child: Image.network(images![index]),
                  ) ,
                  SizedBox(
                    height: SizeConfig.screenHeight !* 0.02,
                  )
                ],
              ),
            )
        ) ,
        isOnline == 'yes' && isOutOfTime == 'no' ? SizedBox(
          height: getProportionateScreenHeight(35),
        ) : SizedBox()
      ],
    );
  }



}
