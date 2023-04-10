import 'package:flutter/material.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';

class BaseMessageScreen extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final IconData? icon;
  final Widget? child;
  BaseMessageScreen({this.title, this.subtitle, this.icon, this.child});
  static String routeName = '/base_message';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: kBackgroundColor),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.perm_scan_wifi,
                size: getProportionateScreenHeight(60),
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Text('لايوجد اتصال بالشبكة',
                  style: TextStyle(
                    fontSize: getProportionateScreenHeight(14),
                  )),
              SizedBox(height: getProportionateScreenHeight(10)),
              if (subtitle != null)
                Text(
                  '$subtitle',
                  style: TextStyle(
                      fontSize: getProportionateScreenHeight(12),
                      color: Colors.grey.shade500),
                ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              if (child != null) child!,
            ],
          ),
        ),
      ),
    );
  }
}
