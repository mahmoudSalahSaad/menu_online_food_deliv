import 'package:flutter/material.dart';
import 'package:menu_egypt/services/create_dynamic_links.dart';
import 'package:menu_egypt/utilities/size_config.dart';

class HomeHeader extends StatelessWidget {
  final bool? back ;
  final ontap ;
  final bool? isFav ;
  final pathFrom ;
  final restId ;
  final name ;
  final image ;

  const HomeHeader({
    Key? key, this.back, this.ontap, this.isFav, this.pathFrom, this.restId, this.name, this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CreateDynamicLinks dynamicLink = CreateDynamicLinks();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: ()=> Navigator.pop(context),
          child: Container(
            height: getProportionateScreenHeight(40),
            width: getProportionateScreenHeight(40),
            decoration: BoxDecoration(
              color: Color(0xffF7F7F9) ,
              shape: BoxShape.circle ,

            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_back_ios ,size: getProportionateScreenHeight(16),)
              ],
            ),
          ),
        ) ,
        Row(
          children: [
            GestureDetector(
              onTap: ontap,
              child: Container(
                height: getProportionateScreenHeight(40),
                width: getProportionateScreenHeight(40),
                decoration: BoxDecoration(
                  color: Color(0xffF7F7F9) ,
                  shape: BoxShape.circle ,

                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isFav == false ?Image.asset("assets/icons/home_heart.png"  , height: 24,) :
                    Image.asset("assets/icons/red_sold_heart.png" , height: 24,)
                  ],
                ),
              ),
            ) ,
            SizedBox(width: getProportionateScreenWidth(5),) ,
            GestureDetector(
              onTap: () {
                if (pathFrom == 'resturant') {
                  dynamicLink.createRestruantDynamicLink(
                      context, restId, name, image, true);
                } else if (pathFrom == 'products') {
                  dynamicLink.createProductsDynamicLink(
                      context, restId, name, image, true);
                }
              },
              child: Container(
                height: getProportionateScreenHeight(40),
                width: getProportionateScreenHeight(40),
                decoration: BoxDecoration(
                  color: Color(0xffF7F7F9) ,
                  shape: BoxShape.circle ,

                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/share.png" , height: 36,)
                  ],
                ),
              ),
            ) ,
          ],
        )
      ],
    );
  }
}