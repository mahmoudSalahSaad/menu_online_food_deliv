import 'package:flutter/material.dart';
import 'package:menu_egypt/components/bottom_nav_bar_widget_new.dart';
import 'package:menu_egypt/components/loading_circle.dart';
import 'package:menu_egypt/providers/address_provider.dart';
import 'package:menu_egypt/providers/cart_provider.dart';
import 'package:menu_egypt/screens/placement_order_screen/components/body.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/widgets/BaseConnectivity.dart';
import 'package:provider/provider.dart';

class PlacementOrder extends StatefulWidget {
  final String? orderName ;
  static String routeName = '/placement';

  const PlacementOrder({Key? key, this.orderName}) : super(key: key);

  @override
  State<PlacementOrder> createState() => _PlacementOrderState();
}

class _PlacementOrderState extends State<PlacementOrder> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    Provider.of<AddressProvider>(context, listen: true);

    return Container(
      decoration: BoxDecoration(gradient: kBackgroundColor),
      child: BaseConnectivity(
        child: Scaffold(
          body: Body(),
          bottomNavigationBar: BottomNavBarWidgetNew(index: 2),
        ),
      ),
    );
  }
}
