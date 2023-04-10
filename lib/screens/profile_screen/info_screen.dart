import 'package:flutter/material.dart';
import 'package:menu_egypt/components/app_bar.dart';
import 'package:menu_egypt/utilities/size_config.dart';


class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              AppBarWidget(
                title: 'معلومات عنا',
                withBack: true,
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * 0.04,
              ), 
              Directionality(textDirection: TextDirection.ltr, child: SizedBox(
                width: 340,
                child:Text(
                    "Launched in December 2012, MenuEgypt.com was established with the aim of availing all menus of all restaurants, coffee places and food stores all over Egypt. It first kicked off with an already rich portal comprising almost all menus of Egypt food destinations and went on growing to now cover over 6500 restaurants and related F&B vendors. The overall concept of the portal and main goals of menuEgypt.com focus on the fast-food delivery sector in Egypt. Recognizing the growing need for an easy way to check stores' menus and order food, we worked to provide a user-friendly and ultimately easy tool through our website, availing all menus therein through a credible, scanned copies of original ones that we get from the actual restaurants and food destinations across the  country.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Color(0xff222222) ,
                      fontSize: 16 ,
                      fontWeight: FontWeight.bold
                    ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
