import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/providers/user_provider.dart';
import 'package:menu_egypt/services/create_dynamic_links.dart';

import '../../../utilities/constants.dart';
import '../../../utilities/size_config.dart';
import '../../restaurant_screen/components/text_icon_widget.dart';
import 'icon_text.dart';

class TopHeaderWidget extends StatelessWidget {
  const TopHeaderWidget(
      {Key? key,
       this.restId,
       this.image,
       this.name,
       this.review,
       this.viewTime,
       this.phone1,
       this.phone2,
       this.phone3,
       this.userProvider,
       this.isFav,
       this.onTap,
       this.pathFrom, this.lastUpdate})
      : super(key: key);

  final String? image, name, review, viewTime, phone1, phone2, phone3, pathFrom ,lastUpdate;
  final UserProvider? userProvider;
  final onTap;
  final bool? isFav;
  final int? restId;
  @override
  Widget build(BuildContext context) {
    int phoneCount = 0;
    CreateDynamicLinks dynamicLink = CreateDynamicLinks();

    if (phone1 != null && phone1 != '') {
      phoneCount++;
    }
    if (phone2 != null && phone2 != '') {
      phoneCount++;
    }
    if (phone3 != null && phone3 != '') {
      phoneCount++;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 16.0,
        ),
        Container(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(0)),
          width: getProportionateScreenHeight(80),
          height: getProportionateScreenHeight(80),
          alignment: Alignment.centerRight,
          child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(getProportionateScreenHeight(12)),
              child: FadeInImage.assetNetwork(
                placeholder: "assets/icons/menu_egypt_logo.png",
                image: image!,
                fit: BoxFit.contain,
              )),
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: getProportionateScreenWidth(24),
                  ),

                  // Row(
                  //   children: [
                  //     userProvider.user != null
                  //         ? TextIconWidget(
                  //             fav: true,
                  //             text: '',
                  //             icon: isFav
                  //                 ? FontAwesomeIcons.solidHeart
                  //                 : FontAwesomeIcons.heart,
                  //             onTap: onTap)
                  //         : Container(),
                  //     Container(
                  //       padding: EdgeInsets.only(
                  //           left: getProportionateScreenWidth(10)),
                  //       child: InkWell(
                  //           onTap: () {
                  //             if (pathFrom == 'resturant') {
                  //               dynamicLink.createRestruantDynamicLink(
                  //                   context, restId, name, image, true);
                  //             } else if (pathFrom == 'products') {
                  //               dynamicLink.createProductsDynamicLink(
                  //                   context, restId, name, image, true);
                  //             }
                  //           },
                  //           child: Icon(
                  //             FontAwesomeIcons.shareNodes,
                  //             size: getProportionateScreenHeight(20),
                  //           )),
                  //     ),
                  //     Container(
                  //       padding: EdgeInsets.only(
                  //           left: getProportionateScreenWidth(5)),
                  //       child: InkWell(
                  //           onTap: () {
                  //             Get.back();
                  //           },
                  //           child: Icon(
                  //             FontAwesomeIcons.chevronLeft,
                  //             size: getProportionateScreenHeight(20),
                  //           )),
                  //     ),
                  //   ],
                  // ),
                  )],
              ),
              GestureDetector(
                onTap: () async {
                  if (phoneCount > 1) {
                    dialog([phone1!, phone2!, phone3!],
                        'ارقام تليفونات ' + name!);
                  } else {
                    bool? result =
                    await FlutterPhoneDirectCaller.callNumber(
                        '$phone1');
                    if (result!) {
                      print('call');
                    }
                  }
                },
                child: IconTextWidget(
                  icon: Icons.phone,
                  isImage: true,
                  imagePath: "assets/icons/red1-call.png",
                  iconColor: Color(0xffB90101),
                  iconSize: getProportionateScreenWidth(20),
                  text: phoneCount > 1 ? 'اتصل بينا' : phone1,
                  fontSize: getProportionateScreenHeight(16),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(8),
              ),
              Container(
                width: getProportionateScreenWidth(300),
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconTextWidget(
                      icon: Icons.star,
                      iconColor: Color(0xffFFC107),
                      iconSize: getProportionateScreenWidth(16),
                      text: review,
                      fontSize: getProportionateScreenHeight(14),
                    ),
                    SizedBox(
                      width:  40,
                    ) ,
                    IconTextWidget(
                      icon: Icons.visibility_outlined,
                      iconColor: Color(0xffFFC107),
                      iconSize: getProportionateScreenWidth(16),
                      text: viewTime,
                      fontSize: getProportionateScreenHeight(14),
                    ),
                    SizedBox(
                      width:  40,
                    ) ,

                    pathFrom == "products" ? Container():  IconTextWidget(
                      icon: Icons.calendar_month_rounded,
                      imagePath: "assets/icons/calender.png",
                      isImage: true,
                      iconColor:Color(0xffFFC107),
                      iconSize: getProportionateScreenWidth(20),
                      text:lastUpdate ,
                      fontSize: getProportionateScreenHeight(14),
                    ),
                    SizedBox(
                      width: 0,
                    )
                  ],
                ),
              ),

              // SizedBox(
              //   height: getProportionateScreenHeight(27),
              // ),
            ],
          ),
        ),
      ],
    );
  }

  void dialog(List<String> list, String title) {
    Get.defaultDialog(
        title: title,
        content: Container(
          width: SizeConfig.screenWidth !* 0.8,
          height: SizeConfig.screenHeight! * 0.5,
          child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, index) {
                return GestureDetector(
                  onTap: () async {
                    bool? result = await FlutterPhoneDirectCaller.callNumber(
                        '${list[index]}');
                    if (result!) {
                      print('call');
                    }
                    Get.back();
                  },
                  child: Text(list[index],
                      style:
                          TextStyle(fontSize: SizeConfig.screenWidth! * 0.04)),
                );
              }),
        ),
        textCancel: 'اغلاق',
        buttonColor: kPrimaryColor,
        cancelTextColor: kTextColor);
  }
}
