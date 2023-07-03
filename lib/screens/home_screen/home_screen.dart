import 'dart:io';

import 'package:flutter/material.dart';
import 'package:menu_egypt/components/bottom_nav_bar_widget_new.dart';
import 'package:menu_egypt/components/loading_circle.dart';
import 'package:menu_egypt/providers/home_provider.dart';
import 'package:menu_egypt/screens/home_screen/components/body.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/widgets/BaseConnectivity.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/home_screen';
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: true);
    DateTime? lastPressed;
    return WillPopScope(child: Container(
      decoration: BoxDecoration(color: Colors.white),
      child: BaseConnectivity(
        child: Scaffold(
          body: homeProvider.isLoading ? LoadingCircle() : Body(),
          bottomNavigationBar: BottomNavBarWidgetNew(index: 0),
        ),
      ),
    ),
     onWillPop: ()async{
       final now = DateTime.now();
       const maxDuration =  Duration(seconds: 2);
       final isWarning =
           lastPressed == null || now.difference(lastPressed!) > maxDuration;
       if (isWarning) {
         lastPressed = DateTime.now();
         final snackBar = SnackBar(
           backgroundColor:kPrimaryColor,
           content: Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text(
                 'اذا كنت تريد الخروج من البرنامج اضغط مرة اخرى',
                 style: TextStyle(),
               ),
             ],
           ) ,
           duration: maxDuration ,);

         ScaffoldMessenger.of(context)
           ..removeCurrentSnackBar()
           ..showSnackBar(snackBar) ;
         return false ;
       }else{
         exit(0) ;

       }
     });
  }
}
