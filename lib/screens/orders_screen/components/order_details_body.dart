import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:menu_egypt/components/app_bar.dart';
//import 'package:menu_egypt/models/cart_item.dart';
import 'package:menu_egypt/models/order_details.dart';
//import 'package:menu_egypt/providers/cart_provider.dart';
import 'package:menu_egypt/providers/orders_provider.dart';
import 'package:menu_egypt/screens/orders_screen/my_orders.dart';
//import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';

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
    if (orderDetailsModel.orderDetails.orderStatus == 'hold') {
      currentStep = 0;
    } else if (orderDetailsModel.orderDetails.orderStatus == 'in-progress') {
      currentStep = 1;
    } else if (orderDetailsModel.orderDetails.orderStatus == 'shipping') {
      currentStep = 2;
    } else if (orderDetailsModel.orderDetails.orderStatus == 'delivered') {
      currentStep = 3;
    } else if (orderDetailsModel.orderDetails.orderStatus == 'canceled') {
      cancelled = true;
      currentStep = 3;
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
                      child: AppBarWidget(
                        title: 'تفاصيل الطلب',
                        withBack: true,
                        navigationPage: MyOrders.routeName,
                      ),
                    ),
                    //order status
                    !cancelled
                        ? SizedBox(
                            height: getProportionateScreenHeight(200),
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Timeline.tileBuilder(
                                scrollDirection: Axis.horizontal,
                                builder: TimelineTileBuilder.connected(
                                  connectionDirection:
                                      ConnectionDirection.before,
                                  contentsAlign: ContentsAlign.alternating,
                                  contentsBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.all(24.0),
                                    child: index == 0
                                        ? Text('مراجعة')
                                        : index == 1
                                            ? Text('تجهيز')
                                            : index == 2
                                                ? Text('فى الطريق')
                                                : index == 3 && cancelled
                                                    ? Text('ملغى')
                                                    : Text('وصل'),
                                  ),
                                  connectorBuilder:
                                      (context, index, connectorType) {
                                    return index <= currentStep
                                        ? SolidLineConnector(
                                            color: Colors.red,
                                          )
                                        : SolidLineConnector(
                                            color: Colors.white);
                                  },
                                  indicatorBuilder: (context, index) {
                                    return index <= currentStep
                                        ? DotIndicator(
                                            color: Colors.red,
                                          )
                                        : DotIndicator(color: Colors.white);
                                  },
                                  itemCount: 4,
                                ),
                              ),
                              /*
                        child: Theme(
                          data: ThemeData(
                            canvasColor: kAppBarColor,
                            primarySwatch: Colors.red,
                            fontFamily: 'DroidArabic',
                          ),
                          child: Stepper(
                            type: StepperType.horizontal,
                            currentStep: currentStep,
                            steps: [
                              Step(
                                title: Text(
                                  'مراجعة',
                                  style: TextStyle(color: Colors.white),
                                ),
                                content: Container(),
                                isActive: currentStep == 0,
                              ),
                              Step(
                                title: Text(
                                  'تجهيز',
                                  style: TextStyle(color: Colors.white),
                                ),
                                content: Container(),
                                isActive: currentStep == 1,
                              ),
                              Step(
                                title: Text(
                                  'فى الطريق',
                                  style: TextStyle(color: Colors.white),
                                ),
                                content: Container(),
                                isActive: currentStep == 2,
                              ),
                              Step(
                                title: cancelled
                                    ? Text(
                                        'ملغى',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    : Text(
                                        'وصل',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                content: Container(),
                                isActive: currentStep == 3,
                              ),
                            ],
                          ),
                        ),
                        */
                            ),
                          )
                        : Text('تم الغاء الطلب'),
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('عنوان الطلب'),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.locationPin,
                                          size:
                                              getProportionateScreenHeight(15),
                                        ),
                                        SizedBox(
                                            width:
                                                getProportionateScreenWidth(5)),
                                        Text(orderDetailsModel.orderDetails
                                                .address.cityIName +
                                            ',' +
                                            orderDetailsModel.orderDetails
                                                .address.regionName)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.streetView,
                                    size: getProportionateScreenHeight(15),
                                  ),
                                  SizedBox(
                                      width: getProportionateScreenWidth(5)),
                                  Text(
                                      'شارع: ${orderDetailsModel.orderDetails.address.street}')
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.building,
                                    size: getProportionateScreenHeight(15),
                                  ),
                                  SizedBox(
                                      width: getProportionateScreenWidth(5)),
                                  Text(
                                      'عمارة: ${orderDetailsModel.orderDetails.address.building} شقة: ${orderDetailsModel.orderDetails.address.apartmentNumber}')
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
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "${orderDetailsModel.itemDetails[index].quantity}",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                'x ',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                "${orderDetailsModel.itemDetails[index].product}" +
                                                    " ${orderDetailsModel.itemDetails[index].size}",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
                                          ),
                                          Text(
                                            orderDetailsModel
                                                    .itemDetails[index].subTotal
                                                    .toString() +
                                                'X' +
                                                orderDetailsModel
                                                    .itemDetails[index].quantity
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
                                            orderDetailsModel.itemDetails[index]
                                                        .addition1 ==
                                                    null
                                                ? ''
                                                : orderDetailsModel
                                                    .itemDetails[index]
                                                    .addition1,
                                            style: TextStyle(
                                                color: Colors.grey[300]),
                                          ),
                                          Text('-'),
                                          Text(
                                            orderDetailsModel.itemDetails[index]
                                                        .addition2 ==
                                                    null
                                                ? ''
                                                : orderDetailsModel
                                                    .itemDetails[index]
                                                    .addition2,
                                            style: TextStyle(
                                                color: Colors.grey[300]),
                                          ),
                                        ],
                                      ),
                                      trailing: Text(
                                        '${orderDetailsModel.itemDetails[index].subTotal * orderDetailsModel.itemDetails[index].quantity} جم',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return Container(
                                      height: getProportionateScreenHeight(2),
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
                    orderDetailsModel.orderDetails.notes.isNotEmpty
                        ? Padding(
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
                                child: Text('ملاحظات: ' +
                                    orderDetailsModel.orderDetails.notes),
                              ),
                            ),
                          )
                        : SizedBox(),
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
