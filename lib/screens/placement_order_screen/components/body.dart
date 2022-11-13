import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/providers/address_provider.dart';
import 'package:menu_egypt/providers/cart_provider.dart';
//import 'package:menu_egypt/providers/orders_provider.dart';
import 'package:menu_egypt/screens/address_screen/add_new_address.dart';
import 'package:menu_egypt/components/app_bar.dart';
import 'package:menu_egypt/screens/orders_screen/my_orders.dart';
//import 'package:menu_egypt/screens/orders_screen/order_details_screen.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';

enum PaymentMethode { cash, visa }

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  PaymentMethode _methode = PaymentMethode.cash;
  int addressId = 0;
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false).cart;
    final addresses =
        Provider.of<AddressProvider>(context, listen: false).addresses;
    return SafeArea(
      child: Consumer<CartProvider>(
        builder: (context, value, child) {
          return cart == null || cart.cartItems.isEmpty
              ? Center(child: Text('لا يوجد منتجات فى السلة'))
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
                              child: AppBarWidget(title: 'الدفع'),
                            ),
                            //resturant
                            ListTile(
                              leading: Container(
                                height: getProportionateScreenHeight(50),
                                width: getProportionateScreenWidth(50),
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
                                    fontSize: getProportionateScreenHeight(10)),
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
                                        size: getProportionateScreenHeight(10),
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
                            //address
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
                                    children: [
                                      ExpansionTile(
                                        title: Text(
                                          'عنوان التوصيل',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        children: [
                                          addresses.isNotEmpty
                                              ? ListView.separated(
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return RadioListTile(
                                                      title: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                      FontAwesomeIcons
                                                                          .house,
                                                                      size: getProportionateScreenHeight(
                                                                          10),
                                                                    ),
                                                                    SizedBox(
                                                                        width: getProportionateScreenWidth(
                                                                            5)),
                                                                    Text(addresses[index]
                                                                            .cityName +
                                                                        ',' +
                                                                        addresses[index]
                                                                            .regionName)
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                FontAwesomeIcons
                                                                    .locationPin,
                                                                size:
                                                                    getProportionateScreenHeight(
                                                                        10),
                                                              ),
                                                              SizedBox(
                                                                  width:
                                                                      getProportionateScreenWidth(
                                                                          5)),
                                                              Text(
                                                                  'شارع ${addresses[index].street} عمارة ${addresses[index].building} شقة ${addresses[index].apartment}'),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      groupValue: addressId,
                                                      value:
                                                          addresses[index].id,
                                                      activeColor: Colors.red,
                                                      onChanged: (index) {
                                                        setState(() {
                                                          addressId = index;
                                                        });
                                                        print(addressId);
                                                      },
                                                    );
                                                  },
                                                  separatorBuilder:
                                                      (context, index) {
                                                    return Container(
                                                      height:
                                                          getProportionateScreenHeight(
                                                              2),
                                                      width: double.infinity,
                                                      color: Colors.grey,
                                                    );
                                                  },
                                                  itemCount: addresses.length,
                                                )
                                              : Text('لا يوجد لديك عناوين'),
                                        ],
                                      ),
                                      MaterialButton(
                                        onPressed: () {
                                          addNewAddressBottomSheet(context);
                                        },
                                        minWidth:
                                            MediaQuery.of(context).size.width,
                                        color: kAppBarColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: BorderSide(
                                            color: Colors.white,
                                            width:
                                                getProportionateScreenWidth(1),
                                            style: BorderStyle.solid,
                                          ),
                                        ),
                                        child: Text('اضف عنوان جديد'),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            //payment
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: RadioListTile(
                                              title: Text('الدفع عند الإستلام'),
                                              groupValue: _methode,
                                              value: PaymentMethode.cash,
                                              activeColor: Colors.red,
                                              onChanged:
                                                  (PaymentMethode value) {
                                                setState(() {
                                                  _methode = value;
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                              width:
                                                  getProportionateScreenWidth(
                                                      5)),
                                          Expanded(
                                              flex: 1,
                                              child: Icon(
                                                  FontAwesomeIcons.sackDollar)),
                                        ],
                                      ),
                                      Container(
                                        height: getProportionateScreenHeight(2),
                                        width: double.infinity,
                                        color: Colors.grey,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: IgnorePointer(
                                              child: RadioListTile(
                                                title: Text(
                                                  'الدفع بالبطاقة (قريباً)',
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                groupValue: _methode,
                                                value: PaymentMethode.visa,
                                                activeColor: Colors.red,
                                                onChanged:
                                                    (PaymentMethode value) {
                                                  setState(() {
                                                    _methode = value;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              width:
                                                  getProportionateScreenWidth(
                                                      5)),
                                          Expanded(
                                              flex: 1,
                                              child: Icon(
                                                FontAwesomeIcons.creditCard,
                                                color: Colors.grey,
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            //order
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
                                      Text('تفاصيل الطلب'),
                                      //cart items
                                      ListView.separated(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return ListTile(
                                            title: Text(
                                              'x' +
                                                  cart.cartItems[index].quantity
                                                      .toString() +
                                                  ' ' +
                                                  cart.cartItems[index].name +
                                                  ' ' +
                                                  cart.cartItems[index].weight,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            subtitle: Text(
                                              cart.cartItems[index]
                                                      .firstAddonName +
                                                  ' - ' +
                                                  cart.cartItems[index]
                                                      .secondAddonName,
                                              style: TextStyle(
                                                  color: Colors.grey[300]),
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
                                                      cart.cartItems[index]
                                                              .price
                                                              .toString() +
                                                          ' جم',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
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
                            //copon
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: IgnorePointer(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(FontAwesomeIcons.percent,
                                          color: Colors.grey),
                                      hintText: 'إضافة كوبون خصم',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
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
                                            cart.subTotalPrice.toString() +
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
                                            cart.deliveryPrice.toString() +
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
                                            cart.totalPrice.toString() + ' جم',
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
                    //checkout button
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: MaterialButton(
                        height: getProportionateScreenHeight(50),
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () async {
                          if (addressId == 0) {
                            dialog('برجاء اختيار عنوان التوصيل');
                          } else {
                            final result = await Provider.of<CartProvider>(
                                    context,
                                    listen: false)
                                .checkOut(addressId);
                            if (result['success'] &&
                                !result['error']
                                    .toString()
                                    .contains('عضويتك')) {
                              successDialog(context, 'تم الدفع بنجاح',
                                  result['orderSerialNumber']);
                            } else {
                              dialog(result['error'] +
                                  ' قم بتسجيل الخروج و الدخول مرة اخرى');
                            }
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
                              cart.totalPrice.toString() + ' جم',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              'تأكيد الدفع',
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
}

//go to order details
void successDialog(
    BuildContext context, String message, String orderSerialNumber) {
  Get.defaultDialog(
      content: Text(message),
      textConfirm: 'تفاصيل الطلب',
      title: 'عملية ناجحة',
      buttonColor: Colors.green,
      onConfirm: () async {
        print(orderSerialNumber);
        //await Provider.of<OrderProvider>(context, listen: false)
        // .getOrderDetails(orderSerialNumber);
        Get.toNamed(MyOrders.routeName);
      },
      confirmTextColor: kTextColor);
}
