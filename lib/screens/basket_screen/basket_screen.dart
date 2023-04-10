import 'package:flutter/material.dart';
import 'package:menu_egypt/components/bottom_nav_bar_widget_new.dart';
import 'package:menu_egypt/components/loading_circle.dart';
import 'package:menu_egypt/providers/cart_provider.dart';
import 'package:menu_egypt/screens/basket_screen/components/body.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/widgets/BaseConnectivity.dart';
import 'package:provider/provider.dart';

class MyBasket extends StatelessWidget {
  static String routeName = '/basket';

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: true);

    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: BaseConnectivity(
        child: Scaffold(
          body: cartProvider.isLoading ? LoadingCircle() : Body(),
          bottomNavigationBar: BottomNavBarWidgetNew(index: 2),
        ),
      ),
    );
  }
}
