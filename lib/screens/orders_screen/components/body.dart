import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/components/app_bar.dart';
import 'package:menu_egypt/components/dialog.dart';
import 'package:menu_egypt/components/loading_circle.dart';
import 'package:menu_egypt/models/cart_item.dart';
import 'package:menu_egypt/models/order.dart';
import 'package:menu_egypt/providers/cart_provider.dart';
import 'package:menu_egypt/providers/orders_provider.dart';
import 'package:menu_egypt/providers/restaurants_provider.dart';
import 'package:menu_egypt/screens/basket_screen/basket_screen.dart';
import 'package:menu_egypt/screens/new_restaurant_screen/new_restaurant_screen.dart';
import 'package:menu_egypt/screens/orders_screen/canel_order_screen.dart';
import 'package:menu_egypt/screens/orders_screen/order_details_screen.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';

import '../../../models/order_details.dart' as ReOrder;

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<OrderModel> orders = [];
  @override
  void initState() {
    orders = Provider.of<OrderProvider>(context, listen: false).orders;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return RefreshIndicator(
      onRefresh: () async {
        await Provider.of<OrderProvider>(context, listen: false).getOrders();
      },
      child: SafeArea(
        child: FutureProvider<Map<String, dynamic>>(
          initialData: {},
          create: (_) =>
              Provider.of<OrderProvider>(context, listen: true).getOrders(),
          child: Consumer<Map<String, dynamic>>(
            builder: (_, value, __) {
              if (value.isNotEmpty) {
                return orders.isNotEmpty
                    ? SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: getProportionateScreenHeight(2),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: AppBarWidget(
                                title: 'طلباتى',
                                withBack: false,
                              ),
                            ),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                    onTap: () async {

                                      await Provider.of<RestaurantsProvider>(context,
                                              listen: false)
                                          .fetchRestaurant(
                                              orders[index].restId!);
                                      Get.offNamed(NewRestaurantScreen.routeName);
                                    },
                                    child: Container(
                                      child: Column(

                                        children: [
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Row(

                                            children: [

                                              SizedBox(
                                                width:
                                                getProportionateScreenWidth(10),
                                              ),
                                              Container(
                                                height: 80,
                                                width: 80,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      12.0),
                                                  image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: NetworkImage(
                                                        'https://menuegypt.com/' +
                                                            orders[index]
                                                                .restLogo!),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                getProportionateScreenWidth(10),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [

                                                  //name - price
                                                  SizedBox(
                                                    width:SizeConfig.screenHeight! < 900 ?
                                                    getProportionateScreenWidth(
                                                        265) : getProportionateScreenWidth(290),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Text(
                                                          orders[index].restName!,
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                            FontWeight.w400,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${orders[index].total!.toStringAsFixed(0)} جم',
                                                          style: TextStyle(
                                                            color: Colors.black,

                                                            fontWeight:
                                                            FontWeight.w400
                                                            ,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  //order_name

                                                  SizedBox(
                                                    width: getProportionateScreenWidth(200) ,
                                                    child: Directionality(
                                                      textDirection: TextDirection.ltr,
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [Text(orders[index].orderName??"#"+"${orders[index].serialNumber}" , style: TextStyle(
                                                            color: Colors.black ,
                                                            fontWeight: FontWeight.w400
                                                        ),)],
                                                      ),
                                                    ) ,
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        //   subtitle: SizedBox(
                                                        width:
                                                        getProportionateScreenWidth(
                                                            200),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "${orders[index].countItems} منتج",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                Text(' - ' , style: TextStyle(color: Colors.black),),
                                                                Text(
                                                                  orders[index]
                                                                      .operationDate!,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ],
                                                            ),
                                                            //status


                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  orders[index]
                                                      .orderStatus ==
                                                      'hold'
                                                      ? Text(
                                                    "مراجعة",
                                                    style: TextStyle(
                                                        color: Colors
                                                            .black  ,height: 1.2),
                                                  )
                                                      : orders[index]
                                                      .orderStatus ==
                                                      'in-progress'
                                                      ? Text(
                                                    "تجهيز",
                                                    style: TextStyle(
                                                        color: Colors
                                                            .black,height: 1.2),
                                                  )
                                                      : orders[index]
                                                      .orderStatus ==
                                                      'shipping'
                                                      ? Text(
                                                    "فى الطريق",
                                                    style: TextStyle(
                                                        color:
                                                        Colors.black,height: 1.2),
                                                  )
                                                      : orders[index].orderStatus ==
                                                      'delivered'
                                                      ? Text(
                                                    "وصل",
                                                    style:
                                                    TextStyle(color: Colors.black,height: 1.2),
                                                  )
                                                      : orders[index].orderStatus ==
                                                      'canceled'
                                                      ? Text(
                                                    "ملغى",
                                                    style: TextStyle(color: Colors.black,height: 1.2),
                                                  )
                                                      : Text(''),

                                                ],
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:orders[index].orderStatus ==
                                                'delivered' ||
                                                orders[index]
                                                    .orderStatus ==
                                                    'canceled' || orders[index]
                                                .orderStatus ==
                                                'hold'
                                                ?
                                            MainAxisAlignment
                                                .spaceAround : MainAxisAlignment.start,
                                            children: [
                                              //order details btn
                                              SizeConfig.screenHeight! > 900 ? SizedBox(
                                                width: getProportionateScreenWidth(10),
                                              )  : SizedBox(),
                                              //re-order btn
                                              orders[index].orderStatus ==
                                                  'delivered' ||
                                                  orders[index]
                                                      .orderStatus ==
                                                      'canceled'
                                                  ? Container(
                                                width: getProportionateScreenWidth(170),
                                                margin: EdgeInsets.symmetric(horizontal: 8),
                                                child: MaterialButton(
                                                  onPressed:
                                                      () async {
                                                    if (cartProvider.cart.resturantId == orders[index].restId ||
                                                        cartProvider.cart.resturantId ==
                                                            0) {
                                                      Get.defaultDialog(
                                                        title:
                                                        'اعادة الطلب',
                                                        content:
                                                        LoadingCircle(),
                                                      );
                                                      Map<String, dynamic>
                                                      result =
                                                      await Provider.of<OrderProvider>(context, listen: false).reOrder(orders[index].serialNumber!);
                                                      List<ReOrder.ReOrderItemDetails> or = result['data'] ;
                                                      print(or.first.comment);
                                                      if (result[
                                                      'success']) {
                                                        for (int i = 0;
                                                        i < result['data'].length;
                                                        i++) {
                                                          CartItemModel cartItem = CartItemModel(
                                                            //fixed params
                                                            id: result['data'][i].id,
                                                            name: result['data'][i].product,
                                                            description: '',
                                                            photoUrl: '',
                                                            //selected params
                                                            price: result['data'][i].subTotal.toDouble(),
                                                            quantity: result['data'][i].quantity,
                                                            weight: result['data'][i].size,
                                                            firstAddonName: result['data'][i].addition1,
                                                            secondAddonName: result['data'][i].addition2,
                                                            firstAddonPrice: 0.0,
                                                            secondAddonPrice: 0.0,
                                                            weightId: result['data'][i].sizeId,
                                                            firstAddId: result['data'][i].addition1Id,
                                                            secondAddId: result['data'][i].addition2Id,
                                                            product: result['data'][i].productInfo,
                                                            comment: or[i].comment ,

                                                          );

                                                          cartProvider.addItemToCart(
                                                            cartItem,
                                                            result['restId'],
                                                            result['deliveryFee'],
                                                            result['deliveryTime'],
                                                            result['restName'],
                                                            "https://menuegypt.com//" + result['restLogo'],
                                                          );
                                                          cartProvider.addOrderName(result['order_name']) ;
                                                        }
                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                          SnackBar(
                                                            backgroundColor: kAppBarColor,
                                                            content: Text(
                                                              result['error'],
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontFamily: 'DroidArabic',
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: getProportionateScreenHeight(15),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                        Get.offNamed(MyBasket.routeName);
                                                      } else {
                                                        dialog(result['error']);
                                                      }
                                                    } else {
                                                      deleteDialog(
                                                          context);
                                                    }
                                                  },
                                                  color:
                                                  kAppBarColor,


                                                  shape: RoundedRectangleBorder(

                                                      borderRadius:
                                                      BorderRadius.circular(10.0) , side: BorderSide(color: Color(0xffB90101))),

                                                  child:
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        'إعادة الطلب ',
                                                        style:
                                                        TextStyle(fontSize: getProportionateScreenHeight(14), fontWeight: FontWeight.bold , color: Colors.white),
                                                      ),

                                                    ],

                                                  ),

                                                ),
                                              )
                                                  :orders[index].orderStatus == "hold" ?
                                              SizedBox(
                                                width: getProportionateScreenWidth(170),
                                                child: MaterialButton(
                                                  onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> CancelOrderScreen(orderNumber: orders[index].serialNumber,))) ,
                                                  color: kAppBarColor,

                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(10.0)),
                                                  child:
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        'ألغاء الطلب ',
                                                        style:
                                                        TextStyle(fontSize: getProportionateScreenHeight(15), fontWeight: FontWeight.bold , color:Colors.white),
                                                      ),
                                                      // Icon(
                                                      //   FontAwesomeIcons.cancel,
                                                      //   size:
                                                      //   getProportionateScreenHeight(7),
                                                      // ),
                                                    ],
                                                  ),


                                                ),
                                              ): SizedBox(),

                                             Padding(

                                               padding:  orders[index].orderStatus !=
                                                   'delivered' ||
                                                   orders[index]
                                                       .orderStatus !=
                                                       'canceled' || orders[index]
                                                   .orderStatus !=
                                                   'hold'
                                                   ? EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(8)) : EdgeInsets.zero,
                                             child:  SizedBox(
                                               width:getProportionateScreenWidth(170) ,
                                               child: MaterialButton(
                                                 onPressed:
                                                     () async {
                                                   Get.defaultDialog(
                                                     title:
                                                     'تفاصيل الطلب',

                                                     content:
                                                     LoadingCircle(),
                                                   );
                                                   await Provider.of<
                                                       OrderProvider>(
                                                       context,
                                                       listen:
                                                       false)
                                                       .getOrderDetails(
                                                       orders[index]
                                                           .serialNumber!);
                                                   Get.offNamed(
                                                       OrderDetails
                                                           .routeName);
                                                 },
                                                 color:
                                                 Colors.white,

                                                 shape: RoundedRectangleBorder(
                                                     borderRadius:
                                                     BorderRadius.circular(
                                                         10.0) , side: BorderSide(color: Color(0xffB90101))),
                                                 child: Row(
                                                   mainAxisAlignment: MainAxisAlignment.center,
                                                   children: [
                                                     Text(
                                                       'تفاصيل الطلب ',
                                                       style: TextStyle(
                                                           fontSize: getProportionateScreenHeight(
                                                               14),
                                                           color: Color(0xffB90101),
                                                           fontWeight:
                                                           FontWeight.bold),
                                                     ),

                                                   ],

                                                 ),

                                               ),
                                             ),
                                             )
                                            ],
                                          ) , 
                                          SizedBox(
                                            height: getProportionateScreenHeight(12),
                                          )
                                        ],
                                      ),
                                    ));
                              },
                              separatorBuilder: (context, index) =>
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     Divider(
                                       indent: 15,
                                       height: 2,

                                       color: Color(0xff222222).withOpacity(0.9),
                                     )
                                   ],
                                 ),
                              itemCount: orders.length,
                            )
                          ],
                        ),
                      )
                    : Center(
                        child: Center(child: Text('لا يوجد لديك طلبات')),
                      );
              } else {
                return Center(child: LoadingCircle());
              }
            },
          ),
        ),
      ),
    );
  }
//   ListTile(
//   leading: Container(
//   height: 50,
//   width: 50,
//   alignment: Alignment.center,
//   decoration: BoxDecoration(
//   borderRadius:
//   BorderRadius.circular(5.0),
//   image: DecorationImage(
//   fit: BoxFit.fill,
//   image: NetworkImage(
//   'https://menuegypt.com/' +
//   orders[index].restLogo),
//   ),
//   ),
//   ),
//   title: Text(
//   orders[index].restName,
//   style: TextStyle(
//   color: Colors.white,
//   fontWeight: FontWeight.bold,
//   ),
//   ),
//   subtitle: SizedBox(
//   width: getProportionateScreenWidth(340),
//   child: Column(
//   crossAxisAlignment:
//   CrossAxisAlignment.start,
//   children: [
//   Row(
//   children: [
//   Text(
//   "${orders[index].countItems} منتج ",
//   style: TextStyle(
//   color: Colors.grey[300]),
//   ),
//   Text(' - '),
//   Text(
//   orders[index].operationDate,
//   style: TextStyle(
//   color: Colors.grey[300]),
//   ),
//   ],
//   ),
//   //status
//   orders[index].orderStatus == 'hold'
//   ? Text(
//   "مراجعة",
//   style: TextStyle(
//   color: Colors.grey[300]),
//   )
//       : orders[index].orderStatus ==
//   'in-progress'
//   ? Text(
//   "تجهيز",
//   style: TextStyle(
//   color:
//   Colors.grey[300]),
//   )
//       : orders[index].orderStatus ==
//   'shipping'
//   ? Text(
//   "فى الطريق",
//   style: TextStyle(
//   color: Colors
//       .grey[300]),
//   )
//       : orders[index]
//       .orderStatus ==
//   'delivered'
//   ? Text(
//   "وصل",
//   style: TextStyle(
//   color: Colors
//       .grey[300]),
//   )
//       : orders[index]
//       .orderStatus ==
//   'canceled'
//   ? Text(
//   "ملغى",
//   style: TextStyle(
//   color: Colors
//       .grey[
//   300]),
//   )
//       : Text(''),
//   SizedBox(
//   width: getProportionateScreenWidth(340),
//   child: Row(
//   mainAxisAlignment:
//   MainAxisAlignment.center,
//   children: [
//   //order details btn
//   MaterialButton(
//   onPressed: () async {
//   Get.defaultDialog(
//   title: 'تفاصيل الطلب',
//   content: LoadingCircle(),
//   );
//   await Provider.of<
//       OrderProvider>(
//   context,
//   listen: false)
//       .getOrderDetails(
//   orders[index]
//       .serialNumber);
//   Get.offNamed(
//   OrderDetails.routeName);
// },
// color: kAppBarColor,
// shape: RoundedRectangleBorder(
// borderRadius:
// BorderRadius.circular(
// 10.0)),
// child: Row(
// children: [
// Text(
// 'تفاصيل الطلب ',
// style: TextStyle(
// fontSize:
// getProportionateScreenHeight(
// 10),
// fontWeight:
// FontWeight.bold),
// ),
// Icon(
// FontAwesomeIcons.list,
// size:
// getProportionateScreenHeight(
// 7),
// ),
// ],
// ),
// ),
// SizedBox(
// width:
// getProportionateScreenWidth(
// 10),
// ),
// //re-order btn
// orders[index].orderStatus ==
// 'delivered' ||
// orders[index].orderStatus ==
// 'canceled'
// ? MaterialButton(
// onPressed: () async {
// if (cartProvider.cart
//     .resturantId ==
// orders[index]
//     .restId ||
// cartProvider.cart
//     .resturantId ==
// 0) {
// Get.defaultDialog(
// title: 'اعادة الطلب',
// content:
// LoadingCircle(),
// );
// Map<String, dynamic>
// result =
// await Provider.of<
// OrderProvider>(
// context,
// listen:
// false)
//     .reOrder(orders[
// index]
//     .serialNumber);
//
// if (result['success']) {
// for (int i = 0;
// i <
// result['data']
//     .length;
// i++) {
// CartItemModel
// cartItem =
// CartItemModel(
// //fixed params
// id: result['data']
// [i]
//     .id,
// name:
// result['data']
// [i]
//     .product,
// description: '',
// photoUrl: '',
// //selected params
// price: result[
// 'data'][i]
//     .subTotal
//     .toDouble(),
// quantity:
// result['data']
// [i]
//     .quantity,
// weight:
// result['data']
// [i]
//     .size,
// firstAddonName:
// result['data']
// [i]
//     .addition1,
// secondAddonName:
// result['data']
// [i]
//     .addition2,
// firstAddonPrice:
// 0.0,
// secondAddonPrice:
// 0.0,
// weightId:
// result['data']
// [i]
//     .sizeId,
// firstAddId: result[
// 'data'][i]
//     .addition1Id,
// secondAddId: result[
// 'data'][i]
//     .addition2Id,
// product: result[
// 'data'][i]
//     .productInfo,
// comment:  result['data'][i].comment
// );
//
// cartProvider
//     .addItemToCart(
// cartItem,
// result['restId'],
// result[
// 'deliveryFee'],
// result[
// 'deliveryTime'],
// result[
// 'restName'],
// "https://menuegypt.com//" +
// result[
// 'restLogo'],
// );
// }
// ScaffoldMessenger.of(
// context)
//     .showSnackBar(
// SnackBar(
// backgroundColor:
// kAppBarColor,
// content: Text(
// result['error'],
// textAlign:
// TextAlign
//     .center,
// style:
// TextStyle(
// color: Colors
//     .white,
// fontFamily:
// 'DroidArabic',
// fontSize:
// getProportionateScreenHeight(
// 15),
// ),
// ),
// ),
// );
// Get.offNamed(MyBasket
//     .routeName);
// } else {
// dialog(
// result['error']);
// }
// } else {
// deleteDialog(context);
// }
// },
// color: kAppBarColor,
// shape:
// RoundedRectangleBorder(
// borderRadius:
// BorderRadius
//     .circular(
// 10.0)),
// child: Row(
// children: [
// Text(
// 'إعادة الطلب ',
// style: TextStyle(
// fontSize:
// getProportionateScreenHeight(
// 10),
// fontWeight:
// FontWeight
//     .bold),
// ),
// Icon(
// FontAwesomeIcons
//     .arrowsRotate,
// size:
// getProportionateScreenHeight(
// 7),
// ),
// ],
// ),
// )
//     : Text(''),
// ],
// ),
// )
// ],
// ),
// ),
// trailing: Text(
// '${orders[index].total.toStringAsFixed(2)} جم',
// style: TextStyle(
// fontWeight: FontWeight.bold,
// ),
// ),
//
// ),

  void dialog(String message) {
    AppDialog.infoDialog(
      context: context,
      title: 'تنبيه',
      message: message,
      btnTxt: 'إغلاق',
    );
  }

  void deleteDialog(BuildContext context) {
    AppDialog.confirmDialog(
      context: context,
      title: 'لديك طلب من مطعم اخر',
      message: 'هل تريد حذف السلة؟',
      confirmBtnTxt: 'حذف',
      cancelBtnTxt: 'رجوع',
      onConfirm: () async {
        Get.back();
        Provider.of<CartProvider>(context, listen: false).clearCart();
      },
    );
  }
}
