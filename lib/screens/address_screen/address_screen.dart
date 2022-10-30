import 'package:flutter/material.dart';
import 'package:menu_egypt/components/loading_circle.dart';
import 'package:menu_egypt/providers/address_provider.dart';
import 'package:menu_egypt/screens/address_screen/components/body.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/widgets/BaseConnectivity.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatelessWidget {
  static String routeName = '/address';
  @override
  Widget build(BuildContext context) {
    final addressProvider = Provider.of<AddressProvider>(context, listen: true);
    return Container(
      decoration: BoxDecoration(gradient: kBackgroundColor),
      child: BaseConnectivity(
        child: Scaffold(
          body: addressProvider.isLoading ? LoadingCircle() : Body(),
        ),
      ),
    );
  }
}
