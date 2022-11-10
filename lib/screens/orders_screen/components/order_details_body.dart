import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:menu_egypt/components/app_bar.dart';
//import 'package:menu_egypt/models/cart_item.dart';
import 'package:menu_egypt/models/order_details.dart';
//import 'package:menu_egypt/providers/cart_provider.dart';
import 'package:menu_egypt/providers/orders_provider.dart';
//import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';

class OrderDetailsBody extends StatefulWidget {
  const OrderDetailsBody({Key key}) : super(key: key);

  @override
  State<OrderDetailsBody> createState() => _OrderDetailsBodyState();
}

class _OrderDetailsBodyState extends State<OrderDetailsBody> {
  OrderDetailsModel orderDetailsModel;
  int currentStep = 0;
  bool cancelled = false;
  @override
  void initState() {
    orderDetailsModel =
        Provider.of<OrderProvider>(context, listen: false).orderDetailsModel;
    if (orderDetailsModel.orderDetails.orderStatus == 'in-progress') {
      currentStep = 0;
    } else if (orderDetailsModel.orderDetails.orderStatus == 'shipping') {
      currentStep = 1;
    } else if (orderDetailsModel.orderDetails.orderStatus == 'delivered') {
      currentStep = 2;
    } else if (orderDetailsModel.orderDetails.orderStatus == 'cancelled') {
      cancelled = true;
      currentStep = 2;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Provider.of<OrderProvider>(context, listen: false)
            .getOrderDetails(orderDetailsModel.orderDetails.serialNumber);
      },
      child: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: orderDetailsModel.itemDetails.isNotEmpty
              ? Column(
                  children: [
                    SizedBox(
                      height: getProportionateScreenHeight(2),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: AppBarWidget(title: 'تفاصيل الطلب'),
                    ),
                    //order status
                    SizedBox(
                      height: 110,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Theme(
                          data: ThemeData(
                            primarySwatch: Colors.red,
                            fontFamily: 'DroidArabic',
                          ),
                          child: Stepper(
                            type: StepperType.horizontal,
                            currentStep: currentStep,
                            steps: [
                              Step(
                                title: Text('جار التحضير'),
                                content: Container(),
                                isActive: currentStep == 0,
                              ),
                              Step(
                                title: Text('جار التوصيل'),
                                content: Container(),
                                isActive: currentStep == 1,
                              ),
                              Step(
                                title: cancelled
                                    ? Text('تم الإلغاء')
                                    : Text('تم التوصيل'),
                                content: Container(),
                                isActive: currentStep == 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //oreder address
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('عنوان التوصيل'),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.house,
                                          size: 10.0,
                                        ),
                                        SizedBox(width: 5.0),
                                        Text(
                                            orderDetailsModel.orderDetails
                                                    .address.cityIName +
                                                ',' +
                                                orderDetailsModel.orderDetails
                                                    .address.regionName +
                                                ',' +
                                                orderDetailsModel.orderDetails
                                                    .address.neighborhood)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.locationPin,
                                    size: 10.0,
                                  ),
                                  SizedBox(width: 5.0),
                                  Expanded(
                                    child: Text(
                                      'شارع ${orderDetailsModel.orderDetails.address.street} عمارة رقم ${orderDetailsModel.orderDetails.address.building} شقة رقم ${orderDetailsModel.orderDetails.address.apartmentNumber}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //order items
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('تفاصيل الطلب'),
                              ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(
                                        " x${orderDetailsModel.itemDetails[index].quantity} ${orderDetailsModel.itemDetails[index].product}" +
                                            " ${orderDetailsModel.itemDetails[index].size}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        orderDetailsModel
                                                .itemDetails[index].addition1 +
                                            ' ' +
                                            orderDetailsModel
                                                .itemDetails[index].addition2,
                                        style:
                                            TextStyle(color: Colors.grey[300]),
                                      ),
                                      trailing: Text(
                                        '${orderDetailsModel.itemDetails[index].subTotal} جم',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return Container(
                                      height: 2.0,
                                      width: double.infinity,
                                      color: Colors.grey,
                                    );
                                  },
                                  itemCount:
                                      orderDetailsModel.itemDetails.length)
                            ],
                          ),
                        ),
                      ),
                    ),
                    //prices
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                    '${orderDetailsModel.orderDetails.subTotal.toString()} جم',
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'التوصيل',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    '${orderDetailsModel.orderDetails.deliveryFee.toString()} جم',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'الإجمالى',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${orderDetailsModel.orderDetails.total.toString()} جم',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    /*
                    //re order
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: MaterialButton(
                        onPressed: () {
                          for (int i = 0;
                              i < orderDetailsModel.itemDetails.length;
                              i++) {
                            CartItemModel cartItem = CartItemModel(
                              //fixed params
                              id: orderDetailsModel.itemDetails[i].id,
                              name: orderDetailsModel.itemDetails[i].product,
                              description: '',
                              photoUrl: '',
                              //selected params
                              price: orderDetailsModel.itemDetails[i].subTotal
                                  .toDouble(),
                              quantity:
                                  orderDetailsModel.itemDetails[i].quantity,
                              weight: orderDetailsModel.itemDetails[i].size,
                              firstAddonName:
                                  orderDetailsModel.itemDetails[i].addition1,
                              secondAddonName:
                                  orderDetailsModel.itemDetails[i].addition2,
                              firstAddonPrice: 0.0,
                              secondAddonPrice: 0.0,
                              weightId: 1,
                              firstAddId: 2,
                              secondAddId: 0,
                            );

                            Provider.of<CartProvider>(context, listen: false)
                                .addItemToCart(
                              cartItem,
                              orderDetailsModel.restDetails.id,
                              orderDetailsModel.orderDetails.deliveryFee,
                              orderDetailsModel.orderDetails.deliveryTime,
                              orderDetailsModel.restDetails.name,
                              orderDetailsModel.restDetails.logo,
                            );
                          }
                        },
                        color: kAppBarColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Text('اعادة الطلب'),
                      ),
                    ),
                    */
                  ],
                )
              : Center(
                  child: Text('لا يوجد تفاصيل لهذا الطلب'),
                ),
        ),
      ),
    );
  }
}
