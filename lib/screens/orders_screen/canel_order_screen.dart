import 'package:flutter/material.dart';
import 'package:menu_egypt/components/bottom_nav_bar_widget_new.dart';
import 'package:menu_egypt/utilities/constants.dart';

import 'components/cancel_order_body.dart';



class CancelOrderScreen extends StatelessWidget {
  final String? orderNumber ;
  const CancelOrderScreen({Key? key, this.orderNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: kBackgroundColor),

      child: Scaffold(

        body: SafeArea(
          child: CancelOrderBody(orderNumber: orderNumber!),
        ),
        bottomNavigationBar: BottomNavBarWidgetNew(index: 1),

      ),
    );

  }
}
