import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/components/app_bar.dart';
import 'package:menu_egypt/components/dialog.dart';
import 'package:menu_egypt/providers/cart_provider.dart';
import 'package:menu_egypt/providers/restaurants_provider.dart';
import 'package:menu_egypt/providers/user_provider.dart';
import 'package:menu_egypt/screens/new_restaurant_screen/edit_cart_widget.dart';
import 'package:menu_egypt/screens/new_restaurant_screen/new_restaurant_screen.dart';
import 'package:menu_egypt/screens/placement_order_screen/placement_order.dart';
import 'package:menu_egypt/screens/sign_in_screen/sign_in_screen.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    final cart = Provider.of<CartProvider>(context, listen: false).cart;
    return SafeArea(
      child: Consumer<CartProvider>(
        builder: (context, value, child) {
          return cart == null || cart.cartItems.isEmpty
              ? Center(child: Text('السلة فارغة'))
              : Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 100.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: getProportionateScreenHeight(2),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: AppBarWidget(
                                title: 'السلة',
                                withBack: false,
                              ),
                            ),
                            //resturant info
                            //resturant
                            GestureDetector(
                              child: ListTile(
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(cart.resturantLogo),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  "طلبك من مطعم",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          getProportionateScreenHeight(10)),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cart.resturantName,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              getProportionateScreenHeight(20)),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.motorcycle,
                                          size:
                                              getProportionateScreenHeight(10),
                                        ),
                                        SizedBox(
                                            width:
                                                getProportionateScreenWidth(5)),
                                        Text(
                                          "التوصيل خلال ${cart.deliveryTime} دقيقة",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                                  getProportionateScreenHeight(
                                                      10)),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                Provider.of<RestaurantsProvider>(context,
                                        listen: false)
                                    .fetchRestaurant(cart.resturantId);
                                Get.offNamed(NewRestaurantScreen.routeName);
                              },
                            ),

                            //cart info
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text('تفاصيل الطلب'),
                                          //clear cart
                                          MaterialButton(
                                            onPressed: () {
                                              clearCartDialog(context);
                                            },
                                            color: kAppBarColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              side: BorderSide(
                                                color: Colors.white,
                                                width:
                                                    getProportionateScreenWidth(
                                                        1),
                                                style: BorderStyle.solid,
                                              ),
                                            ),
                                            child: Text('حذف'),
                                          )
                                        ],
                                      ),
                                      //cart items
                                      ListView.separated(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return ListTile(
                                            title: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: getProportionateScreenWidth(160),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        cart.cartItems[index]
                                                            .quantity
                                                            .toString(),
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontSize: getProportionateScreenHeight(12)
                                                        ),
                                                      ),
                                                      Text(
                                                        'x ',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: getProportionateScreenHeight(12)
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: getProportionateScreenWidth(130),
                                                        child: Text(
                                                          cart.cartItems[index]
                                                              .name +
                                                              ' ' +
                                                              cart.cartItems[index]
                                                                  .weight,
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontWeight:
                                                              FontWeight.bold,
                                                              fontSize: getProportionateScreenHeight(12)
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                  cart.cartItems[index].price
                                                          .toStringAsFixed(2) +
                                                      'X' +
                                                      cart.cartItems[index]
                                                          .quantity
                                                          .toString(),
                                                  style: TextStyle(
                                                    fontSize:
                                                        getProportionateScreenHeight(
                                                            10),
                                                    color: Colors.grey[100],
                                                  ),
                                                )
                                              ],
                                            ),
                                            subtitle: Row(
                                              children: [
                                                Text(
                                                  cart.cartItems[index]
                                                              .firstAddonName ==
                                                          null
                                                      ? ''
                                                      : cart.cartItems[index]
                                                          .firstAddonName,
                                                  style: TextStyle(
                                                      color: Colors.grey[300]),
                                                ),
                                                Text('-'),
                                                Text(
                                                  cart.cartItems[index]
                                                              .secondAddonName ==
                                                          null
                                                      ? ''
                                                      : cart.cartItems[index]
                                                          .secondAddonName,
                                                  style: TextStyle(
                                                      color: Colors.grey[300]),
                                                ),
                                              ],
                                            ),
                                            trailing: SizedBox(
                                              width:
                                                  getProportionateScreenWidth(
                                                      110),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      (cart.cartItems[index]
                                                                      .price *
                                                                  cart
                                                                      .cartItems[
                                                                          index]
                                                                      .quantity)
                                                              .toString() +
                                                          ' جم',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              20))),
                                                          child:
                                                              GestureDetector(
                                                            //edit cart item
                                                            onTap: () {
                                                              /*
                                                              Provider.of<ResturantItemsProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .getResturantProduct(cart
                                                                      .cartItems[
                                                                          index]
                                                                      .id);
                                                              */
                                                              editCartBottomSheet(
                                                                  context,
                                                                  cart.cartItems[
                                                                      index],
                                                                  index);
                                                            },
                                                            child: Icon(
                                                              Icons.edit,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            getProportionateScreenWidth(
                                                                5),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                20,
                                                              ),
                                                            ),
                                                          ),
                                                          child:
                                                              GestureDetector(
                                                            //delete cart item
                                                            onTap: () {
                                                              deleteDialog(
                                                                  context,
                                                                  index);
                                                            },
                                                            child: Icon(
                                                              Icons.delete,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            Divider(
                                          height:
                                              getProportionateScreenHeight(1),
                                          color: Colors.white,
                                        ),
                                        itemCount: cart.cartItems.length,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            //payment info
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text('تفاصيل الدفع'),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'مجموع الطلب',
                                          ),
                                          Text(
                                            cart.subTotalPrice
                                                    .toStringAsFixed(2) +
                                                ' جم',
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'التوصيل',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Text(
                                            cart.deliveryPrice
                                                    .toStringAsFixed(2) +
                                                ' جم',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'الإجمالى',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            cart.totalPrice.toStringAsFixed(2) +
                                                ' جم',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //go to checkout
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: MaterialButton(
                        height: getProportionateScreenHeight(50),
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () {
                          if (user == null) {
                            Get.toNamed(SignInScreen.routeName);
                          } else {
                            Get.toNamed(PlacementOrder.routeName);
                          }
                        },
                        color: kAppBarColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              cart.totalPrice.toStringAsFixed(2) + ' جم',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              'تأكيد الطلب',
                              style: TextStyle(color: Colors.white),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.black12,
                              child: Text(
                                cart.cartItems.length.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }

  void deleteDialog(BuildContext context, int item) {
    AppDialog.confirmDialog(
      context: context,
      title: 'حذف المنتج',
      message: 'هل تريد الحذف ؟',
      confirmBtnTxt: 'حذف',
      cancelBtnTxt: 'رجوع',
      onConfirm: () async {
        Get.back();
        Provider.of<CartProvider>(context, listen: false)
            .removeItemFromCart(item);
      },
    );
  }

  void clearCartDialog(BuildContext context) {
    AppDialog.confirmDialog(
      context: context,
      title: 'حذف السلة',
      message: 'هل تريد الحذف ؟',
      confirmBtnTxt: 'حذف',
      cancelBtnTxt: 'رجوع',
      onConfirm: () async {
        Get.back();
        Provider.of<CartProvider>(context, listen: false).clearCart();
      },
    );
  }
}
