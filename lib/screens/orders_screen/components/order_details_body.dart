import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:menu_egypt/components/app_bar.dart';
import 'package:menu_egypt/models/order_details.dart';
import 'package:menu_egypt/providers/orders_provider.dart';
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
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
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
                              title: Text('جار المراجعة'),
                              content: Container(),
                              isActive: currentStep == 0,
                            ),
                            Step(
                              title: Text('جار التحضير'),
                              content: Container(),
                              isActive: currentStep == 1,
                            ),
                            Step(
                              title: Text('جار التوصيل'),
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
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('عنوان التوصيل'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          orderDetailsModel.orderDetails.address
                                                  .cityIName +
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
                          borderRadius: BorderRadius.all(Radius.circular(20))),
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
                                      style: TextStyle(color: Colors.grey[300]),
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
                                itemCount: orderDetailsModel.itemDetails.length)
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
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('تفاصيل الدفع'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'الإجمالى',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${orderDetailsModel.orderDetails.total.toString()} جم',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Center(
                child: Text('لا يوجد تفاصيل لهذا الطلب'),
              ),
      ),
    );
  }
}
