import 'package:flutter/material.dart';
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
                              child: AppBarWidget(title: 'طلباتى'),
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
                                        Text(
                                          "${orders[index].countItems} منتج - ${orders[index].orderStatus} ",
                                          style: TextStyle(
                                              color: Colors.grey[300]),
                                        ),
                                        Text(
                                          orders[index].operationDate,
                                          style: TextStyle(
                                              color: Colors.grey[300]),
                                        ),
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
                                              child: Text('تفاصيل الطلب'),
                                            ),
                                            //re-order btn
                                            MaterialButton(
                                              onPressed: () async {
                                                Map<String, dynamic> result =
                                                    await Provider.of<
                                                                OrderProvider>(
                                                            context,
                                                            listen: false)
                                                        .getOrderDetails(
                                                            orders[index]
                                                                .serialNumber);

                                                for (int i = 0;
                                                    i <
                                                        result['data']
                                                            .itemDetails
                                                            .length;
                                                    i++) {
                                                  CartItemModel cartItem =
                                                      CartItemModel(
                                                    //fixed params
                                                    id: result['data']
                                                        .itemDetails[i]
                                                        .id,
                                                    name: result['data']
                                                        .itemDetails[i]
                                                        .product,
                                                    description: '',
                                                    photoUrl: '',
                                                    //selected params
                                                    price: result['data']
                                                        .itemDetails[i]
                                                        .subTotal
                                                        .toDouble(),
                                                    quantity: result['data']
                                                        .itemDetails[i]
                                                        .quantity,
                                                    weight: result['data']
                                                        .itemDetails[i]
                                                        .size,
                                                    firstAddonName:
                                                        result['data']
                                                            .itemDetails[i]
                                                            .addition1,
                                                    secondAddonName:
                                                        result['data']
                                                            .itemDetails[i]
                                                            .addition2,
                                                    firstAddonPrice: 0.0,
                                                    secondAddonPrice: 0.0,
                                                    weightId: result['data']
                                                        .itemDetails[i]
                                                        .sizeId,
                                                    firstAddId: result['data']
                                                        .itemDetails[i]
                                                        .addition1Id,
                                                    secondAddId: result['data']
                                                        .itemDetails[i]
                                                        .addition2Id,
                                                  );
                                                  print(cartItem.name);
                                                  print(cartItem.quantity);
                                                  print(result['data']
                                                      .restDetails
                                                      .logo);
                                                  cartProvider.addItemToCart(
                                                    cartItem,
                                                    result['data']
                                                        .restDetails
                                                        .id,
                                                    result['data']
                                                        .orderDetails
                                                        .deliveryFee,
                                                    result['data']
                                                        .orderDetails
                                                        .deliveryTime,
                                                    result['data']
                                                        .restDetails
                                                        .name,
                                                    "https://menuegypt.com//" +
                                                        result['data']
                                                            .restDetails
                                                            .logo,
                                                  );
                                                }
                                                Get.toNamed(MyBasket.routeName);
                                              },
                                              color: kAppBarColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                              child: Text('اعادة الطلب'),
                                            ),
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
}
