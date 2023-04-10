import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/providers/cart_provider.dart';
import 'package:menu_egypt/providers/restaurants_provider.dart';
import 'package:menu_egypt/providers/user_provider.dart';
import 'package:menu_egypt/screens/basket_screen/basket_screen.dart';
import 'package:menu_egypt/screens/favorites_screen/favorites_screen.dart';
import 'package:menu_egypt/screens/home_screen/home_screen.dart';
import 'package:menu_egypt/screens/orders_screen/my_orders.dart';
import 'package:menu_egypt/screens/profile_screen/profile_screen.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/sign_in_screen/sign_in_screen.dart';

// ignore: must_be_immutable
class BottomNavBarWidgetNew extends StatefulWidget {
  BottomNavBarWidgetNew({Key? key, this.index}) : super(key: key);
  int? index;
  @override
  _BottomNavBarWidgetNewState createState() => _BottomNavBarWidgetNewState();
}

class _BottomNavBarWidgetNewState extends State<BottomNavBarWidgetNew> {
  int _index = 0;

  @override
  void initState() {
    if (widget.index != null) {
      _index = widget.index!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Stack(
      children: [
        BottomNavigationBar(
          elevation: 0.0,
          type: BottomNavigationBarType.fixed,

          backgroundColor: Colors.white,
          selectedItemColor: Color(0xffB90101),
          unselectedItemColor: Color(0xff7D848D),
          items: [
            BottomNavigationBarItem(
                icon : widget.index == 0 ? Image.asset("assets/icons/Group 41.png" , scale: 4, height: 20,) : Image.asset("assets/icons/Group 41 (1).png" , scale: 4,height: 20,),
                label: "الرئيسية" ,
            ),
            BottomNavigationBarItem(
                backgroundColor: kBottomNavBarBackgroundColor,
                icon: widget.index == 1 ? Image.asset("assets/icons/Group 1000000724 (1).png" , height: 20,) : Image.asset("assets/icons/Group 1000000724.png" ,height: 20,),
                label: "طلباتى"),
            BottomNavigationBarItem(
                backgroundColor: kBottomNavBarBackgroundColor,
                icon: Stack(
                  // alignment: Alignment.topLeft,
                  children: [
                    Align(alignment: Alignment.center,
                    child:  widget.index == 2 ? Image.asset("assets/icons/Group 1000000722 (1).png" , height: 24,) : Image.asset("assets/icons/Group 1000000722.png" ,height: 24,),
                    ),
                    Consumer<CartProvider>(
                      builder: (context, value, child) {
                        return cartProvider.cart.cartItems!.isNotEmpty
                            ? CircleAvatar(
                                radius: 11,
                                backgroundColor: Colors.redAccent,
                                child: Text(
                                  cartProvider.cart.cartItems!.isNotEmpty
                                      ? '${cartProvider.cart.cartItems!.length}'
                                      : '0',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            : SizedBox();
                      },
                    ),
                  ],
                ),
                label: "السلة"
            ),
            BottomNavigationBarItem(
                backgroundColor: kBottomNavBarBackgroundColor,
                icon: widget.index == 3 ? Image.asset("assets/icons/Group 1000000723 (3).png" , height: 24,) : Image.asset("assets/icons/Group 1000000723 (2).png" ,height: 24,),
                label: "المفضلة"),
            BottomNavigationBarItem(
                backgroundColor: kBottomNavBarBackgroundColor,
                icon:widget.index == 4 ? Image.asset("assets/icons/Icon-4.png" , height: 24,) : Image.asset("assets/icons/Icon.png" , height: 24,),
                label: "حسابى"),
          ],
          currentIndex: _index,
          onTap: (index) async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            setState(() {
              _index = index;
              if (_index == 0) {
                Get.toNamed(HomeScreen.routeName);
              } else if (_index == 1) {
                if (user == null) {
                  Get.toNamed(SignInScreen.routeName);
                } else {
                  Get.toNamed(MyOrders.routeName);
                }
              } else if (_index == 2) {
                //if (user == null) {
                //Get.toNamed(SignInScreen.routeName);
                //} else {
                Get.toNamed(MyBasket.routeName);
                //}
              } else if (_index == 3) {
                if (user == null) {
                  Get.toNamed(SignInScreen.routeName);
                } else {
                  /*
                  var userFavorites =
                      Provider.of<UserProvider>(context, listen: false)
                          .user
                          .favorites;
                  */
                  List<String> savedFavsStrList =
                      prefs.getStringList('favList')!;
                  List<int> intFavList =
                      savedFavsStrList.map((i) => int.parse(i)).toList();
                  Provider.of<RestaurantsProvider>(context, listen: false)
                      .favoritesRestaurantsFilter(intFavList);
                  Get.toNamed(FavoritesScreen.routeName);
                }
              } else if ((_index == 4)) {
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
