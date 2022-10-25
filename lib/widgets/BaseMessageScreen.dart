import 'package:flutter/material.dart';
import 'package:menu_egypt/utilities/constants.dart';

class BaseMessageScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Widget child;
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
                size: 60.0,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(height: 20.0),
              Text('لايوجد اتصال بالشبكة',
                  style: TextStyle(
                    fontSize: 14.0,
                  )),
              SizedBox(height: 10.0),
              if (subtitle != null)
                Text(
                  '$subtitle',
                  style: TextStyle(fontSize: 12.0, color: Colors.grey.shade500),
                ),
              SizedBox(
                height: 20.0,
              ),
              if (child != null) child,
            ],
          ),
        ),
      ),
    );
  }
}
