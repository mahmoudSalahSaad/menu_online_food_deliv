import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/components/app_bar.dart';
import 'package:menu_egypt/models/cart_item.dart';
import 'package:menu_egypt/models/order.dart';
import 'package:menu_egypt/providers/cart_provider.dart';
import 'package:menu_egypt/providers/orders_provider.dart';
import 'package:menu_egypt/screens/basket_screen/basket_screen.dart';
import 'package:menu_egypt/screens/orders_screen/order_details_screen.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

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
          initialData: null,
          create: (_) =>
              Provider.of<OrderProvider>(context, listen: true).getOrders(),
          child: Consumer<Map<String, dynamic>>(
            builder: (_, value, __) {
              if (value != null) {
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
                                    await Provider.of<OrderProvider>(context,
                                            listen: false)
                                        .getOrderDetails(
                                            orders[index].serialNumber);
                                    Get.toNamed(OrderDetails.routeName);
                                  },
                                  child: ListTile(
                                    leading: Container(
                                      height: getProportionateScreenHeight(50),
                                      width: getProportionateScreenWidth(50),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              'https://menuegypt.com/' +
                                                  orders[index].restLogo),
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      orders[index].restName,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "${orders[index].countItems} منتج ",
                                              style: TextStyle(
                                                  color: Colors.grey[300]),
                                            ),
                                            Text(' - '),
                                            Text(
                                              orders[index].operationDate,
                                              style: TextStyle(
                                                  color: Colors.grey[300]),
                                            ),
                                          ],
                                        ),
                                        //status
                                        orders[index].orderStatus == 'hold'
                                            ? Text(
                                                "مراجعة",
                                                style: TextStyle(
                                                    color: Colors.grey[300]),
                                              )
                                            : orders[index].orderStatus ==
                                                    'in-progress'
                                                ? Text(
                                                    "تجهيز",
                                                    style: TextStyle(
                                                        color:
                                                            Colors.grey[300]),
                                                  )
                                                : orders[index].orderStatus ==
                                                        'shipping'
                                                    ? Text(
                                                        "فى الطريق",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[300]),
                                                      )
                                                    : orders[index]
                                                                .orderStatus ==
                                                            'delivered'
                                                        ? Text(
                                                            "وصل",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey[300]),
                                                          )
                                                        : orders[index]
                                                                    .orderStatus ==
                                                                'canceled'
                                                            ? Text(
                                                                "ملغى",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .grey[
                                                                        300]),
                                                              )
                                                            : Text(''),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            //order details btn
                                            MaterialButton(
                                              onPressed: () async {
                                                await Provider.of<
                                                            OrderProvider>(
                                                        context,
                                                        listen: false)
                                                    .getOrderDetails(
                                                        orders[index]
                                                            .serialNumber);
                                                Get.toNamed(
                                                    OrderDetails.routeName);
                                              },
                                              color: kAppBarColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'تفاصيل الطلب ',
                                                    style: TextStyle(
                                                        fontSize:
                                                            getProportionateScreenHeight(
                                                                10),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Icon(
                                                    FontAwesomeIcons.list,
                                                    size:
                                                        getProportionateScreenHeight(
                                                            6),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            //re-order btn
                                            orders[index].orderStatus ==
                                                        'delivered' ||
                                                    orders[index].orderStatus ==
                                                        'canceled'
                                                ? MaterialButton(
                                                    onPressed: () async {
                                                      if (cartProvider.cart
                                                                  .resturantId ==
                                                              orders[index]
                                                                  .restId ||
                                                          cartProvider.cart
                                                                  .resturantId ==
                                                              0) {
                                                        Map<String, dynamic>
                                                            result =
                                                            await Provider.of<
                                                                        OrderProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .reOrder(orders[
                                                                        index]
                                                                    .serialNumber);

                                                        if (result['success']) {
                                                          for (int i = 0;
                                                              i <
                                                                  result['data']
                                                                      .length;
                                                              i++) {
                                                            CartItemModel
                                                                cartItem =
                                                                CartItemModel(
                                                              //fixed params
                                                              id: result['data']
                                                                      [i]
                                                                  .id,
                                                              name:
                                                                  result['data']
                                                                          [i]
                                                                      .product,
                                                              description: '',
                                                              photoUrl: '',
                                                              //selected params
                                                              price: result[
                                                                      'data'][i]
                                                                  .subTotal
                                                                  .toDouble(),
                                                              quantity:
                                                                  result['data']
                                                                          [i]
                                                                      .quantity,
                                                              weight:
                                                                  result['data']
                                                                          [i]
                                                                      .size,
                                                              firstAddonName:
                                                                  result['data']
                                                                          [i]
                                                                      .addition1,
                                                              secondAddonName:
                                                                  result['data']
                                                                          [i]
                                                                      .addition2,
                                                              firstAddonPrice:
                                                                  0.0,
                                                              secondAddonPrice:
                                                                  0.0,
                                                              weightId:
                                                                  result['data']
                                                                          [i]
                                                                      .sizeId,
                                                              firstAddId: result[
                                                                      'data'][i]
                                                                  .addition1Id,
                                                              secondAddId: result[
                                                                      'data'][i]
                                                                  .addition2Id,
                                                            );

                                                            cartProvider
                                                                .addItemToCart(
                                                              cartItem,
                                                              result['restId'],
                                                              result[
                                                                  'deliveryFee'],
                                                              result[
                                                                  'deliveryTime'],
                                                              result[
                                                                  'restName'],
                                                              "https://menuegypt.com//" +
                                                                  result[
                                                                      'restLogo'],
                                                            );
                                                          }
                                                          Get.toNamed(MyBasket
                                                              .routeName);
                                                        } else {
                                                          dialog(
                                                              result['error']);
                                                        }
                                                      } else {
                                                        dialog(
                                                            'لديك طلب من مطعم اخر من فضلك قم بإتمام الطلب لتتمكن من عمل طلب جديد.');
                                                      }
                                                    },
                                                    color: kAppBarColor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0)),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'إعادة الطلب ',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  getProportionateScreenHeight(
                                                                      10),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Icon(
                                                          FontAwesomeIcons
                                                              .arrowsRotate,
                                                          size:
                                                              getProportionateScreenHeight(
                                                                  6),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : Text(''),
                                          ],
                                        ),
                                      ],
                                    ),
                                    trailing: Text(
                                      '${orders[index].total} جم',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => Divider(
                                height: getProportionateScreenHeight(1),
                                color: Colors.white,
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
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  void dialog(String message) {
    Get.defaultDialog(
        content: Text(message),
        textCancel: 'إغلاق',
        title: 'تنبيه',
        buttonColor: kPrimaryColor,
        cancelTextColor: kTextColor);
  }
}
