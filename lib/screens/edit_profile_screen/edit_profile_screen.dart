import 'package:flutter/material.dart';
import 'package:menu_egypt/screens/edit_profile_screen/components/body.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/widgets/BaseConnectivity.dart';

class ProfileEditScreen extends StatelessWidget {
  static String routeName = '/profile_edit_screen';
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: BaseConnectivity(
        child: Scaffold(
          body: Body(),
        ),
      ),
    );
  }
}
