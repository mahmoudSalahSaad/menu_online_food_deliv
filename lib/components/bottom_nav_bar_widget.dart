/*
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/providers/restaurants_provider.dart';
import 'package:menu_egypt/providers/user_provider.dart';
import 'package:menu_egypt/screens/favorites_screen/favorites_screen.dart';
import 'package:menu_egypt/screens/filter_screen/filter_screen.dart';
import 'package:menu_egypt/screens/home_screen/home_screen.dart';
import 'package:menu_egypt/screens/profile_screen/profile_screen.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:provider/provider.dart';

import '../screens/sign_in_screen/sign_in_screen.dart';

// ignore: must_be_immutable
class BottomNavBarWidget extends StatefulWidget {
  BottomNavBarWidget({Key key, this.index}) : super(key: key);
  int index;
  @override
  _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  int _index = 0;

  @override
  void initState() {
    if (widget.index != null) {
      _index = widget.index;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    return Stack(
      children: [
        BottomNavigationBar(
          elevation: 0.0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: kBottomNavBarBackgroundColor,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: kTextColor,
          items: user != null
              ? [
                  BottomNavigationBarItem(
                      backgroundColor: kBottomNavBarBackgroundColor,
                      icon: Icon(
                        FontAwesomeIcons.utensils,
                      ),
                      label: "الرئيسية"),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.list_alt,
                      ),
                      label: 'البحث'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        FontAwesomeIcons.solidHeart,
                      ),
                      label: 'المفضلات'),
                  BottomNavigationBarItem(
                      icon: Icon(FontAwesomeIcons.solidUser),
                      label: 'الملف الشخصى'),
                ]
              : [
                  BottomNavigationBarItem(
                      backgroundColor: kBottomNavBarBackgroundColor,
                      icon: Icon(
                        FontAwesomeIcons.utensils,
                      ),
                      label: "الرئيسية"),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.list_alt,
                    ),
                    label: 'البحث',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.list_alt,
                    ),
                    label: 'الملف الشخصى',
                  ),
                ],
          currentIndex: _index,
          onTap: (index) {
            setState(() {
              _index = index;
              if (_index == 0) {
                Get.toNamed(HomeScreen.routeName);
              } else if (_index == 1) {
                Get.toNamed(FilterScreen.routeName);
              } else if (_index == 2 && user != null) {
                var userFavorites =
                    Provider.of<UserProvider>(context, listen: false)
                        .user
                        .favorites;
                Provider.of<RestaurantsProvider>(context, listen: false)
                    .favoritesRestaurantsFilter(userFavorites);
                Get.toNamed(FavoritesScreen.routeName);
              } else if ((_index == 3) || (_index == 2 && user == null)) {
                if (user == null) {
                  Get.toNamed(SignInScreen.routeName);
                } else {
                  Get.toNamed(ProfileScreen.routeName);
                }
              }
            });
          },
        ),
      ],
    );
  }
}
*/