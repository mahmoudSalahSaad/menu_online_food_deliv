import 'package:flutter/material.dart';
import 'package:menu_egypt/components/bottom_nav_bar_widget_new.dart';
import 'package:menu_egypt/components/loading_circle.dart';
import 'package:menu_egypt/providers/orders_provider.dart';
import 'package:menu_egypt/screens/orders_screen/components/order_details_body.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/widgets/BaseConnectivity.dart';
import 'package:provider/provider.dart';

class OrderDetails extends StatelessWidget {
  static String routeName = '/order_details';

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrderProvider>(context, listen: true);

    return Container(
      decoration: BoxDecoration(gradient: kBackgroundColor),
      child: BaseConnectivity(
        child: Scaffold(
          body: ordersProvider.isLoading ? LoadingCircle() : OrderDetailsBody(),
          bottomNavigationBar: BottomNavBarWidgetNew(index: 1),
        ),
      ),
    );
  }
}
