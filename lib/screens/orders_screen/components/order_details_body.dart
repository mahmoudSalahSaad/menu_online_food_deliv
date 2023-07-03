import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:menu_egypt/components/app_bar.dart';

import 'package:menu_egypt/models/order_details.dart';

import 'package:menu_egypt/providers/orders_provider.dart';
import 'package:menu_egypt/screens/orders_screen/canel_order_screen.dart';
import 'package:menu_egypt/screens/orders_screen/my_orders.dart';
import 'package:menu_egypt/utilities/constants.dart';

import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsBody extends StatefulWidget {
  const OrderDetailsBody({Key? key}) : super(key: key);

  @override
  State<OrderDetailsBody> createState() => _OrderDetailsBodyState();
}

class _OrderDetailsBodyState extends State<OrderDetailsBody> {
  OrderDetailsModel? orderDetailsModel;
  int currentStep = 0;
  bool cancelled = false;
  @override
  void initState() {
    orderDetailsModel =
        Provider.of<OrderProvider>(context, listen: false).orderDetailsModel;
    if (orderDetailsModel!.orderDetails!.orderStatus == 'hold') {
      currentStep = 0;
    } else if (orderDetailsModel!.orderDetails!.orderStatus == 'in-progress') {
      currentStep = 1;
    } else if (orderDetailsModel!.orderDetails!.orderStatus == 'shipping') {
      currentStep = 2;
    } else if (orderDetailsModel!.orderDetails!.orderStatus == 'delivered') {
      currentStep = 3;
    } else if (orderDetailsModel!.orderDetails!.orderStatus == 'canceled') {
      cancelled = true;
      currentStep = 3;
    }
    super.initState();
  }

  _launchCaller(String number) async {
    if (await canLaunch("tel:// $number")) {
      await launch("tel:// $number");
    } else {
      throw 'Could not launch $number';
    }
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Provider.of<OrderProvider>(context, listen: false)
            .getOrderDetails(orderDetailsModel!.orderDetails!.serialNumber!);
      },
      child: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: orderDetailsModel!.itemDetails!.isNotEmpty
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
                    orderDetailsModel!.orderDetails!.orderStatus == "hold" ?
                        Container(
                          width: getProportionateScreenWidth(330),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(getProportionateScreenHeight(15))
                          ),
                          child: MaterialButton(
                            onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> CancelOrderScreen(orderNumber: orderDetailsModel!.orderDetails!.serialNumber!,))),

                            color: kAppBarColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("الغاء الطلب" , style: TextStyle(
                                  color: Colors.white
                                ),)
                              ],
                            ),
                          ),
                        ) : SizedBox() ,

                    //order status
                    !cancelled
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [


                        Container(
                          width: 350,
                          height: 76,
                          padding: EdgeInsets.only(left: 10),
                          child: Timeline.tileBuilder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                           dragStartBehavior: DragStartBehavior.down,
                            physics: NeverScrollableScrollPhysics(),
                            builder: TimelineTileBuilder.connected(

                              connectionDirection:
                              ConnectionDirection.before,


                              contentsAlign: ContentsAlign.basic,
                              contentsBuilder: (context, index) => SizedBox(
                                  width: 90,
                                  child: Container(
                                    margin: EdgeInsets.only(right: 20,top: 10),
                                    child: index == 0
                                        ? Text('مراجعة')
                                        : index == 1
                                        ? Text('تجهيز')
                                        : index == 2
                                        ? Text('فى الطريق')
                                        : index == 3 && cancelled
                                        ? Text('ملغى')
                                        : Text('وصل'),
                                  )
                              ),
                              connectorBuilder:
                                  (context, index, connectorType) {
                                return index <= currentStep
                                    ? SolidLineConnector(
                                  color: Colors.red,
                                )
                                    : SolidLineConnector(
                                    color: Colors.grey);
                              },
                              indicatorBuilder: (context, index) {
                                return index <= currentStep
                                    ? DotIndicator(
                                  color: Colors.red,
                                )
                                    : DotIndicator(color: Colors.grey);
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

                      ],
                    )
                        : Text('تم الغاء الطلب'),
                    //oreder address
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color(0xffF7F7F9),
                            border: Border.all(
                              color: Color(0xffE4E4E5),
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [

                              Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Text('عنوان الطلب' , style: TextStyle(
                                   fontWeight: FontWeight.bold ,
                                   fontSize: 16
                                 ),),
                               ],
                             ),
                              SizedBox(
                                height: 22,
                              ) ,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Image.asset("assets/icons/location.png" ,scale: 3.6,) ,
                                        SizedBox(
                                            width:
                                                getProportionateScreenWidth(5)),

                                        Text("${orderDetailsModel!.orderDetails!.address!.cityIName!}, ${orderDetailsModel!.orderDetails!.address!.regionName!}, ${orderDetailsModel!.orderDetails!.address!.neighborhood.toString() != 'null'?orderDetailsModel!.orderDetails!.address!.neighborhood! : '' }") ,

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ) ,
                              Row(
                                children: [
                                  Image.asset("assets/icons/street.png" , scale: 3.2,) ,
                                  SizedBox(
                                      width: getProportionateScreenWidth(5)),
                                  Text(
                                      'شارع: ${orderDetailsModel!.orderDetails!.address!.street!}', style: TextStyle(fontSize: 16),)
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ) ,
                              Row(
                                children: [
                                  Image.asset("assets/icons/Group 1000000793.png" , scale: 3.6,) ,
                                  SizedBox(
                                      width: getProportionateScreenWidth(5)),
                                  Text(
                                      'عمارة: ${orderDetailsModel!.orderDetails!.address!.building} شقة: ${orderDetailsModel!.orderDetails!.address!.apartmentNumber}',
                                  style: TextStyle(fontSize: 16),
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
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color(0xffF7F7F9),
                            border: Border.all(
                              color: Color(0xffE4E4E5),
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [

                                  Text('تفاصيل الطلب' , style: TextStyle(
                                     fontWeight: FontWeight.bold ,
                                     fontSize: 18
                                  ),),
                                ],
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      minLeadingWidth: 0,
                                      contentPadding: EdgeInsets.zero,
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 22,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,

                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: getProportionateScreenWidth(198),
                                                        child: Text(
                                                          "${orderDetailsModel!.itemDetails![index].product}",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 16
                                                          ),
                                                        ),
                                                      ) ,
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      orderDetailsModel!.itemDetails![index].size!.isNotEmpty?  SizedBox(
                                                        width: 198,
                                                        child: Text(" ${orderDetailsModel!.itemDetails![index]. size}",
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 16
                                                          ),),
                                                      ) : SizedBox()
                                                    ],
                                                  )

                                                ],
                                              ),

                                              Column(
                                                children: [
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    '${(orderDetailsModel!.itemDetails![index].subTotal! * orderDetailsModel!.itemDetails![index].quantity!).toStringAsFixed(0) } جم',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16 ,
                                                    ),
                                                    textAlign: TextAlign.end,
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          orderDetailsModel!.itemDetails![index].size != "" ?SizedBox(
                                            height: 8,
                                          ) : SizedBox(),
                                          Row(
                                            children: [
                                              Text(orderDetailsModel
                                                  !.itemDetails![index].quantity
                                                  .toString(), style: TextStyle(
                                                  fontSize: 16
                                              ),),

                                              Text(" X ", style: TextStyle(
                                                  fontSize: 16
                                              ),) ,
                                              Text(orderDetailsModel
                                                  !.itemDetails![index].subTotal
                                                  !.toStringAsFixed(0) , style: TextStyle(
                                                  fontSize: 16
                                              ),) ,


                                            ],
                                          )




                                        ],
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                orderDetailsModel!.itemDetails![index]
                                                            .addition1.toString() ==
                                                        "null"
                                                    ? ''
                                                    : orderDetailsModel
                                                        !.itemDetails![index]
                                                        .addition1!,
                                                style: TextStyle(
                                                    color: Colors.grey[900] ,  fontSize: 16),
                                              ),
                                              Text('-'),
                                              Text(
                                                orderDetailsModel!.itemDetails![index]
                                                            .addition2.toString() ==
                                                        "null"
                                                    ? ''
                                                    : orderDetailsModel
                                                        !.itemDetails![index]
                                                        .addition2!,
                                                style: TextStyle(
                                                    color: Colors.grey[900]  , fontSize: 16),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              orderDetailsModel!.itemDetails![index].comment != null ? Text("طلب خاص: " , style: TextStyle(color: Colors.black , fontSize: 16),) : SizedBox() ,
                                              orderDetailsModel!.itemDetails![index].comment != null ? SizedBox(
                                                width: getProportionateScreenWidth(152),
                                                child: Text(
                                                  "${orderDetailsModel!.itemDetails![index].comment}" ,
                                                  style: TextStyle(
                                                      fontSize: getProportionateScreenHeight(16),
                                                      color: Colors.black
                                                  ),
                                                ),
                                              ) : SizedBox(

                                              )
                                            ],
                                          )
                                        ],
                                      ),

                                    );
                                  },

                                  itemCount:
                                      orderDetailsModel!.itemDetails!.length)
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
                          color: Color(0xffF7F7F9),
                            border: Border.all(
                              color: Color(0xffE4E4E5),
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('تفاصيل الدفع' , style: TextStyle(
                                    fontWeight: FontWeight.bold ,
                                    fontSize: 18 ,
                                  ),),
                                ],
                              ),
                              SizedBox(
                                height: 22,
                              ) ,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'مجموع الطلب',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    '${orderDetailsModel!.orderDetails!.subTotal!.toStringAsFixed(1)} جم',
                                      style: TextStyle(fontSize: 16)
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ) ,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'التوصيل',
                                    style: TextStyle(color: Colors.black , fontSize: 16),
                                  ),
                                  Text(
                                    '${orderDetailsModel!.orderDetails!.deliveryFee!.toStringAsFixed(1)} جم',
                                    style: TextStyle(color: Colors.black , fontSize: 16),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ) ,
                              Divider(
                                color: Color(0xff222222).withOpacity(0.3),
                                height: 3,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'الإجمالى',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold , fontSize: 16),
                                  ),
                                  Text(
                                    '${orderDetailsModel!.orderDetails!.total!.toStringAsFixed(1)} جم',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ) ,

                            ],
                          ),
                        ),
                      ),
                    ),
                    orderDetailsModel!.orderDetails!.orderStatus! == "in-progress"
                        ||  orderDetailsModel!.orderDetails!.orderStatus == "shipping" ?
                    Container(
                      width: getProportionateScreenWidth(340),
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Color(0xffF7F7F9),
                        border: Border.all(color: Color(0xffE4E4E5)),
                        borderRadius: BorderRadius.circular(getProportionateScreenHeight(15)) ,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          orderDetailsModel!.orderDetails!.orderStatus == "in-progress"
                              ||  orderDetailsModel!.orderDetails!.orderStatus == "shipping" ?
                          Text("ملحوظة"  ,  style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),): SizedBox() ,
                          SizedBox(
                            height: 8,
                          ),
                          orderDetailsModel!.orderDetails!.orderStatus == "in-progress"
                              ||  orderDetailsModel!.orderDetails!.orderStatus == "shipping" ?
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("لألغاء الطلب برجاء الأتصال ب" , style: TextStyle(
                                  color: Colors.black,
                                  fontSize: getProportionateScreenHeight(14)
                              ),) ,
                              GestureDetector(
                                onTap: ()=> _launchCaller(orderDetailsModel!.restDetails!.mobile!),
                                child: Text(orderDetailsModel!.restDetails!.mobile! , style: TextStyle(
                                    color: Colors.red ,
                                    fontSize: 14
                                ),),
                              )
                            ],
                          ) : SizedBox(),
                        ],
                      ),
                    )
                        : SizedBox(),
                    orderDetailsModel!.orderDetails!.notes!.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Color(0xffF7F7F9),
                                  border: Border.all(
                                    color: Color(0xffE4E4E5),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('ملاحظات: ' +
                                    orderDetailsModel!.orderDetails!.notes.toString() , style: TextStyle(color: Colors.grey),),
                              ),
                            ),
                          )
                        : SizedBox(),

                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    )
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
