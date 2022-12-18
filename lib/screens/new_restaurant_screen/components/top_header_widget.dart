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
      {Key key,
      @required this.restId,
      @required this.image,
      @required this.name,
      @required this.review,
      @required this.viewTime,
      @required this.phone1,
      @required this.phone2,
      @required this.phone3,
      @required this.userProvider,
      @required this.isFav,
      @required this.onTap,
      @required this.pathFrom})
      : super(key: key);

  final String image, name, review, viewTime, phone1, phone2, phone3, pathFrom;
  final UserProvider userProvider;
  final onTap;
  final bool isFav;
  final int restId;
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
      children: [
        Container(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
          width: getProportionateScreenHeight(90),
          height: getProportionateScreenHeight(90),
          alignment: Alignment.centerRight,
          child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(getProportionateScreenHeight(10)),
              child: FadeInImage.assetNetwork(
                placeholder: "assets/icons/menu_egypt_logo.png",
                image: image,
                fit: BoxFit.contain,
              )),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: getProportionateScreenWidth(18)),
                  ),
                  Row(
                    children: [
                      userProvider.user != null
                          ? TextIconWidget(
                              fav: true,
                              text: '',
                              icon: isFav
                                  ? FontAwesomeIcons.solidHeart
                                  : FontAwesomeIcons.heart,
                              onTap: onTap)
                          : Container(),
                      Container(
                        padding: EdgeInsets.only(
                            left: getProportionateScreenWidth(10)),
                        child: InkWell(
                            onTap: () {
                              if (pathFrom == 'resturant') {
                                dynamicLink.createRestruantDynamicLink(
                                    context, restId, true);
                              } else if (pathFrom == 'products') {
                                dynamicLink.createProductsDynamicLink(
                                    context, restId, true);
                              }
                            },
                            child: Icon(
                              FontAwesomeIcons.share,
                              size: getProportionateScreenHeight(20),
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: getProportionateScreenWidth(5)),
                        child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(
                              FontAwesomeIcons.chevronLeft,
                              size: getProportionateScreenHeight(20),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconTextWidget(
                      icon: Icons.star,
                      iconColor: Colors.yellow,
                      iconSize: getProportionateScreenWidth(20),
                      text: review,
                      fontSize: getProportionateScreenHeight(14),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(30),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (phoneCount > 1) {
                          dialog([phone1, phone2, phone3],
                              'ارقام تليفونات ' + name);
                        } else {
                          bool result =
                              await FlutterPhoneDirectCaller.callNumber(
                                  '$phone1');
                          if (result) {
                            print('call');
                          }
                        }
                      },
                      child: IconTextWidget(
                        icon: Icons.phone,
                        iconColor: Colors.yellow,
                        iconSize: getProportionateScreenWidth(20),
                        text: phoneCount > 1 ? 'اتصل بينا' : phone1,
                        fontSize: getProportionateScreenHeight(14),
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(30),
                    ),
                    IconTextWidget(
                      icon: Icons.remove_red_eye_rounded,
                      iconColor: Colors.yellow,
                      iconSize: getProportionateScreenWidth(20),
                      text: viewTime,
                      fontSize: getProportionateScreenHeight(14),
                    ),
                  ],
                ),
              )
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
          width: SizeConfig.screenWidth * 0.8,
          height: SizeConfig.screenHeight * 0.5,
          child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, index) {
                return GestureDetector(
                  onTap: () async {
                    bool result = await FlutterPhoneDirectCaller.callNumber(
                        '${list[index]}');
                    if (result) {
                      print('call');
                    }
                    Get.back();
                  },
                  child: Text(list[index],
                      style:
                          TextStyle(fontSize: SizeConfig.screenWidth * 0.04)),
                );
              }),
        ),
        textCancel: 'اغلاق',
        buttonColor: kPrimaryColor,
        cancelTextColor: kTextColor);
  }
}
