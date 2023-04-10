import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:menu_egypt/components/dialog.dart';
import 'package:menu_egypt/components/loading_circle.dart';
import 'package:menu_egypt/models/address.dart';
import 'package:menu_egypt/providers/address_provider.dart';
import 'package:menu_egypt/providers/cart_provider.dart';
import 'package:menu_egypt/providers/orders_provider.dart';
import 'package:menu_egypt/providers/restaurants_provider.dart';
import 'package:menu_egypt/screens/address_screen/add_new_address.dart';
import 'package:menu_egypt/components/app_bar.dart';
import 'package:menu_egypt/screens/basket_screen/basket_screen.dart';
import 'package:menu_egypt/screens/new_restaurant_screen/new_restaurant_screen.dart';
import 'package:menu_egypt/screens/orders_screen/order_details_screen.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:provider/provider.dart';

enum PaymentMethode { cash, visa }

class Body extends StatefulWidget {
  final String? orderNumber ;
  const Body({Key? key, this.orderNumber}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  PaymentMethode _methode = PaymentMethode.cash;
   NavigatorState? _navigator;

  int addressId = 0;
  List<AddressModel> addresses = [];
  OrderProvider orderProvider = OrderProvider();

  @override
  void initState() {
    // addresses.clear() ;
    // addresses = Provider.of<AddressProvider>(context, listen: false).addresses;
    super.initState();
  }
  @override
  void didChangeDependencies() {
    _navigator = Navigator.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController notesController = TextEditingController();
    final cart = Provider.of<CartProvider>(context, listen: false).cart;
    orderProvider = Provider.of<OrderProvider>(context, listen: false);
    final addressProvider  = Provider.of<AddressProvider>(context , listen: false) ;
    return SafeArea(
      child: Consumer<CartProvider>(
        builder: (context1, cartProvider, child) {
          return cart == null || cart.cartItems!.isEmpty
              ? Center(child: Text('لا يوجد منتجات فى السلة'))
              : Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                   Container(
                     color: Colors.white,
                     child:  Padding(
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
                                 title: 'الدفع',
                                 withBack: true,
                                 navigationPage: MyBasket.routeName,
                               ),
                             ),
                             //resturant
                             Padding(
                               padding: EdgeInsets.symmetric(horizontal: 16),
                               child: GestureDetector(
                                 child:Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,

                                   children: [
                                     Row(
                                       children: [
                                         Container(
                                           height: 64,
                                           width: 64,
                                           alignment: Alignment.center,
                                           decoration: BoxDecoration(
                                             borderRadius: BorderRadius.circular(8.0),
                                             image: DecorationImage(
                                               fit: BoxFit.fill,
                                               image: NetworkImage(cart.resturantLogo!),
                                             ),
                                           ),
                                         ),
                                         SizedBox(
                                           width: getProportionateScreenWidth(10),
                                         ),
                                         Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             Text(
                                               "طلبك من مطعم",
                                               style: TextStyle(
                                                   color: Colors.black,
                                                   fontSize:
                                                   getProportionateScreenHeight(14)),
                                             ),
                                             SizedBox(
                                               height: 4,
                                             ),
                                             Column(
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               children: [
                                                 Text(
                                                   cart.resturantName!,
                                                   style: TextStyle(
                                                       color: Colors.black,
                                                       fontWeight: FontWeight.bold,
                                                       fontSize:
                                                       getProportionateScreenHeight(16)),

                                                 ),
                                                 SizedBox(
                                                   height: 4,
                                                 ),
                                                 Row(
                                                   mainAxisAlignment: MainAxisAlignment.end,
                                                   crossAxisAlignment: CrossAxisAlignment.center,
                                                   children: [
                                                     SizedBox(
                                                       width: 4,
                                                     ),
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
                                                           color: Colors.black,
                                                           height: 1.8,
                                                           fontSize:
                                                           getProportionateScreenHeight(
                                                               12)),
                                                     )
                                                   ],
                                                 ),
                                               ],
                                             ),
                                           ],
                                         )

                                       ],
                                     ),
                                   ],
                                 ),
                                 onTap: () {
                                   Provider.of<RestaurantsProvider>(context,
                                       listen: false)
                                       .fetchRestaurant(cart.resturantId!);
                                   Get.offNamed(NewRestaurantScreen.routeName);
                                 },
                               ),
                             ),
                             //address
                             FutureProvider(
                               create: (_) => Provider.of<AddressProvider>(
                                   context,
                                   listen: true)
                                   .getAddresses(),
                               initialData: null,
                               child: Consumer<Map<String, dynamic>>(
                                 builder: (_, value, __) {
                                   if (value != null) {
                                     return addressProvider.addresses.isNotEmpty
                                         ? Padding(
                                       padding: const EdgeInsets.all(16.0),
                                       child: Container(
                                         width: MediaQuery.of(context)
                                             .size
                                             .width,
                                         decoration: BoxDecoration(
                                             color: const Color(0xffF7F7F9),
                                             border: Border.all(
                                               color: Color(0xffE4E4E5),
                                             ),
                                             borderRadius:
                                             BorderRadius.all(
                                                 Radius.circular(20))),
                                         child: Padding(
                                           padding:
                                           const EdgeInsets.all(8.0),
                                           child: Column(
                                             crossAxisAlignment:
                                             CrossAxisAlignment.start,
                                             children: [
                                               ListView.builder(
                                                 shrinkWrap: true,
                                                 physics:
                                                 NeverScrollableScrollPhysics(),
                                                 scrollDirection:
                                                 Axis.vertical,
                                                 itemBuilder:
                                                     (context, index) {
                                                   return Container(
                                                     margin: EdgeInsets.only(bottom: 8),
                                                     decoration: BoxDecoration(
                                                       color: Colors.white ,
                                                       border: Border.all(color: Color(0xffE4E4E5)),
                                                       borderRadius: BorderRadius.circular(12),
                                                     ),
                                                     child: RadioListTile(
                                                       title: Column(
                                                         children: [
                                                           SizedBox(
                                                             height: 8,
                                                           ) ,
                                                           Row(
                                                             mainAxisAlignment:
                                                             MainAxisAlignment
                                                                 .spaceBetween,
                                                             children: [
                                                               Container(
                                                                 child: Row(
                                                                   children: [
                                                                     Image.asset("assets/icons/location.png" ,scale: 3.6,) ,
                                                                     SizedBox(
                                                                         width:
                                                                         getProportionateScreenWidth(5)),
                                                                     Text(addressProvider.addresses[index].cityName! +
                                                                         ',' +
                                                                         addressProvider.addresses[index].regionName! +
                                                                         ',' +
                                                                       addressProvider.addresses[index].neighborhood.toString() != "null" ?addressProvider.addresses[index].neighborhood.toString() : "" )
                                                                   ],
                                                                 ),
                                                               ),
                                                             ],
                                                           ),
                                                           SizedBox(
                                                             height: 8,
                                                           ) ,
                                                           SizedBox(
                                                             width: getProportionateScreenWidth(280),
                                                             child:  Row(
                                                               crossAxisAlignment: CrossAxisAlignment.start,
                                                               children: [
                                                                 Image.asset("assets/icons/street.png" , scale: 3.6,) ,

                                                                 SizedBox(
                                                                     width:
                                                                     getProportionateScreenWidth(
                                                                         5)),
                                                                 SizedBox(
                                                                   width: getProportionateScreenWidth(225),
                                                                   child: Text(
                                                                       'شارع: ${addressProvider.addresses[index].street}'),
                                                                 )
                                                               ],
                                                             ),
                                                           ),
                                                           SizedBox(
                                                             height: 8,
                                                           ) ,
                                                           Row(
                                                             children: [
                                                               Image.asset("assets/icons/Group 1000000793.png" , scale: 3.6,) ,

                                                               SizedBox(
                                                                   width:
                                                                   getProportionateScreenWidth(
                                                                       5)),
                                                               Text(
                                                                   'عمارة: ${addressProvider.addresses[index].building} شقة: ${addressProvider.addresses[index].apartment}')
                                                             ],
                                                           ),
                                                           SizedBox(
                                                             height: 8,
                                                           ) ,
                                                         ],
                                                       ),
                                                       groupValue: addressId,
                                                       value:
                                                       addressProvider.addresses[index]
                                                           .id,
                                                       activeColor:
                                                       Colors.red,
                                                       onChanged: (index) {
                                                         setState(() {
                                                           addressId = index!;
                                                         });
                                                         print(addressId);
                                                       },
                                                       contentPadding: EdgeInsets.zero,
                                                     ),
                                                   );
                                                 },
                                                 // separatorBuilder:
                                                 //     (context, index) {
                                                 //   return Container(
                                                 //     height:
                                                 //         getProportionateScreenHeight(
                                                 //             2),
                                                 //     width:
                                                 //         double.infinity,
                                                 //     color: Colors.grey,
                                                 //   );
                                                 // },
                                                 itemCount:
                                                 addressProvider.addresses.length,
                                               ),
                                               Divider(

                                               ),
                                               MaterialButton(
                                                 minWidth:
                                                 MediaQuery.of(context)
                                                     .size
                                                     .width,
                                                 height: 40,
                                                 onPressed: () {
                                                   Navigator.push(context, MaterialPageRoute(builder: (_)=> AddNewAddress())) ;
                                                 },
                                                 color: kAppBarColor,
                                                 padding: EdgeInsets.symmetric(vertical: 8),
                                                 shape:
                                                 RoundedRectangleBorder(
                                                   borderRadius:
                                                   BorderRadius
                                                       .circular(10),

                                                 ),
                                                 child: Text(
                                                   'اضف عنوان جديد' , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 16),),
                                               )
                                             ],
                                           ),
                                         ),
                                       ),
                                     )
                                         : Center(
                                       child: Center(
                                         child: Column(
                                           children: [
                                             Text('لا يوجد لديك عناوين'),
                                             Padding(
                                               padding:
                                               const EdgeInsets.all(
                                                   16.0),
                                               child: MaterialButton(
                                                 onPressed: () {
                                                   Navigator.push(context, MaterialPageRoute(builder: (_)=> AddNewAddress())) ;
                                                 },
                                                 minWidth:
                                                 MediaQuery.of(context)
                                                     .size
                                                     .width,
                                                 color: kAppBarColor,
                                                 shape:
                                                 RoundedRectangleBorder(
                                                   borderRadius:
                                                   BorderRadius
                                                       .circular(10),
                                                   side: BorderSide(
                                                     color: Colors.white,
                                                     width:
                                                     getProportionateScreenWidth(
                                                         1),
                                                     style:
                                                     BorderStyle.solid,
                                                   ),
                                                 ),
                                                 child: Text(
                                                     'اضف عنوان جديد'),
                                               ),
                                             ),
                                           ],
                                         ),
                                       ),
                                     );
                                   } else {
                                     return Center(child: LoadingCircle());
                                   }
                                 },
                               ),
                             ),
                             //payment
                             Padding(
                               padding: const EdgeInsets.all(16.0),
                               child: Container(
                                 width: MediaQuery.of(context).size.width,
                                 decoration: BoxDecoration(
                                     border: Border.all(
                                       color: Color(0xffE4E4E5),
                                     ),
                                     color: Color(0xffF7F7F9),
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
                                             flex: 4,
                                             child: RadioListTile(
                                               title: Text('الدفع عند الإستلام' , style: TextStyle(fontSize: 18 ,color: Colors.black54 ,height: 1.8  ,fontWeight: FontWeight.w100),),
                                               groupValue: _methode,
                                               value: PaymentMethode.cash,
                                               activeColor: Colors.red,
                                               
                                               onChanged:
                                                   (PaymentMethode? value) {
                                                 setState(() {
                                                   _methode = value!;
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
                                               child: Image.asset("assets/icons/bills.png" , height: 20,)),
                                         ],
                                       ),
                                       Container(
                                         height: getProportionateScreenHeight(1),
                                         width: getProportionateScreenWidth(300),
                                         color: Colors.grey,
                                       ),
                                       Row(
                                         mainAxisAlignment:
                                         MainAxisAlignment.spaceBetween,
                                         children: [
                                           Expanded(
                                             flex: 4,
                                             child: IgnorePointer(
                                               child: RadioListTile(
                                                 title: Text(
                                                   'بطاقة الائتمان عند التوصيل',
                                                   style: TextStyle(
                                                       color: Colors.grey , fontSize: 16 , height: 1.8,fontWeight: FontWeight.w100),
                                                 ),
                                                 groupValue: _methode,
                                                 value: PaymentMethode.visa,
                                                 activeColor: Colors.red,
                                                 onChanged:
                                                     (PaymentMethode? value) {
                                                   setState(() {
                                                     _methode = value!;
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
                                               child: Image.asset("assets/icons/card.png" , height: 20,)),
                                         ],
                                       ),
                                       Container(
                                         height: getProportionateScreenHeight(1),
                                         width: getProportionateScreenWidth(300),
                                         color: Colors.grey,
                                       ),
                                       Row(
                                         mainAxisAlignment:
                                         MainAxisAlignment.spaceBetween,
                                         children: [
                                           Expanded(
                                             flex: 4,
                                             child: IgnorePointer(
                                               child: RadioListTile(
                                                 title: Text(
                                                   'الدفع بالبطاقة (قريبا)',
                                                   style: TextStyle(
                                                       color: Colors.grey , fontSize: 18 , height: 1.8,fontWeight: FontWeight.w200),
                                                 ),
                                                 groupValue: _methode,
                                                 value: PaymentMethode.visa,
                                                 activeColor: Colors.red,
                                                 onChanged:
                                                     (PaymentMethode? value) {
                                                   setState(() {
                                                     _methode = value!;
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
                                               child: Image.asset("assets/icons/card.png" , height: 20,)),
                                         ],
                                       ),
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
                                   color: Color(0xffF7F7F9),
                                     border: Border.all(
                                       color: Color(0xffE4E4E5),
                                     ),
                                     borderRadius:
                                     BorderRadius.all(Radius.circular(20))),
                                 child: Padding(
                                   padding: const EdgeInsets.all(16.0),
                                   child: Column(
                                     mainAxisAlignment:
                                     MainAxisAlignment.spaceAround,
                                     children: [
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.start,
                                         children: [

                                           Text('تفاصيل الطلب' , style: TextStyle(
                                               fontWeight: FontWeight.bold ,
                                               fontSize: 16
                                           ),),
                                         ],
                                       ),
                                       //cart items
                                       ListView.separated(
                                         shrinkWrap: true,
                                         physics: NeverScrollableScrollPhysics(),
                                         itemBuilder:
                                             (BuildContext context, int index) {
                                           return Column(
                                             children: [
                                               SizedBox(
                                                 height: 22,
                                               ),
                                               Row(
                                                 children: [
                                                   Column(
                                                     crossAxisAlignment:
                                                     CrossAxisAlignment.start,
                                                     children: [
                                                       SizedBox(
                                                         width: getProportionateScreenWidth(310),
                                                         child:  Row(
                                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                                           crossAxisAlignment: CrossAxisAlignment.start,


                                                           children: [

                                                            Column(
                                                              children: [
                                                                SizedBox(
                                                                  width :getProportionateScreenWidth(200) ,
                                                                  child: Text(
                                                                    cart.cartItems![index]
                                                                        .name!,
                                                                    style: TextStyle(
                                                                        color: Colors.black,
                                                                        fontWeight:
                                                                        FontWeight.bold,
                                                                        fontSize: getProportionateScreenHeight(16)
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 4,
                                                                ) ,
                                                                cart.cartItems![index].weight != "" ? SizedBox(
                                                                  width: getProportionateScreenWidth(200),
                                                                  child: Text( cart.cartItems![index].weight !, style: TextStyle( color: Colors.black,
                                                                      fontWeight:
                                                                      FontWeight.bold,
                                                                      fontSize: getProportionateScreenHeight(16)),),
                                                                ) : SizedBox(),
                                                              ],
                                                            ),

                                                             SizedBox(

                                                               child: Column(
                                                                 crossAxisAlignment:
                                                                 CrossAxisAlignment.end,
                                                                 mainAxisAlignment: MainAxisAlignment.start,
                                                                 children: [

                                                                   Text(
                                                                     "${
                                                                         (cart.cartItems![index]
                                                                             .price! *
                                                                             cart
                                                                                 .cartItems![
                                                                             index]
                                                                                 .quantity!).toStringAsFixed(0)}"
                                                                         +
                                                                         ' جم',
                                                                     style: TextStyle(
                                                                         fontWeight:
                                                                         FontWeight.bold,
                                                                         fontSize: 16
                                                                     ),
                                                                   ),
                                                                 ],
                                                               ),
                                                             ),
                                                           ],
                                                         ),
                                                       ),
                                                       cart.cartItems![index].weight  != "" ? SizedBox(
                                                         height: 8,
                                                       ) : SizedBox(),
                                                       Row(
                                                         children: [
                                                           Text( cart.cartItems![index]
                                                               .quantity
                                                               .toString(),
                                                               style: TextStyle(
                                                                 fontSize:
                                                                 getProportionateScreenHeight(
                                                                     16),
                                                                 color: Colors.black,
                                                               )) ,

                                                           Text(" X ",
                                                               style: TextStyle(
                                                                 fontSize:
                                                                 getProportionateScreenHeight(
                                                                     16),
                                                                 color: Colors.black,
                                                               )) ,
                                                           Text(cart.cartItems![index].price
                                                               !.toStringAsFixed(0),
                                                               style: TextStyle(
                                                                 fontSize:
                                                                 getProportionateScreenHeight(
                                                                     16),
                                                                 color: Colors.black,
                                                               )) ,


                                                         ],
                                                       ) ,

                                                       Column(
                                                         crossAxisAlignment: CrossAxisAlignment.start,
                                                         children: [
                                                           cart.cartItems![index].comment != null ? Text("طلب خاص: " , style: TextStyle(color: Colors.white),) : SizedBox() ,
                                                           cart.cartItems![index].comment != null ? SizedBox(
                                                             width: getProportionateScreenWidth(310),
                                                             child: Text(
                                                               "${cart.cartItems![index].comment}" ,
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
                                                   )
                                                 ],
                                               ),
                                               SizedBox(
                                                 height: 5,
                                               )
                                             ],
                                           );
                                         },
                                         separatorBuilder: (context, index) =>
                                             Divider(
                                               thickness: 1,
                                               height:
                                               getProportionateScreenHeight(1),
                                               color: Colors.grey.withOpacity(0.1),
                                             ),
                                         itemCount: cart.cartItems!.length,
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
                                       color: Colors.transparent,
                                     ),
                                     borderRadius:
                                     BorderRadius.all(Radius.circular(20))),
                                 child: IgnorePointer(
                                   child: TextField(
                                     decoration: InputDecoration(
                                       filled: true,
                                       fillColor: Color(0xffF7F7F9),
                                       prefixIcon: Image.asset("assets/icons/coupon.png"),
                                       hintText: 'إضافة كوبون خصم',
                                       contentPadding: EdgeInsets.zero,
                                       hintStyle: TextStyle(color: Colors.grey , height: 2.0),
                                       enabledBorder:OutlineInputBorder(
                                           borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                                           borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)) ,
                                       disabledBorder: OutlineInputBorder(
                                           borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                                           borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),

                                       focusedBorder:  OutlineInputBorder(
                                           borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                                           borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
                                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                                           borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
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
                                       color: Color(0xffE4E4E5),
                                     ),
                                     color: Color(0xffF7F7F9),
                                     borderRadius:
                                     BorderRadius.all(Radius.circular(20))),
                                 child: Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Column(
                                     mainAxisAlignment:
                                     MainAxisAlignment.spaceAround,
                                     children: [
                                       SizedBox(
                                         height: 8,
                                       ) ,
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.start,
                                         children: [
                                           Text('تفاصيل الدفع' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
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
                                             'مجموع الطلب',
                                           ),
                                           Text(
                                             cart.subTotalPrice
                                                 !.toStringAsFixed(0) +
                                                 ' جم',
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
                                             style:
                                             TextStyle(color: Colors.black),
                                           ),
                                           Text(
                                             cart.deliveryPrice
                                                 !.toStringAsFixed(0) +
                                                 ' جم',
                                             style:
                                             TextStyle(color: Colors.black),
                                           ),
                                         ],
                                       ),
                                       SizedBox(
                                         height: 8,
                                       ) ,
                                       Padding(padding: EdgeInsets.symmetric(horizontal: 10),

                                           child: Divider(color: Color(0xffD9E2EB),thickness: 1,)),
                                       SizedBox(
                                         height: 8,
                                       ) ,
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
                                             cart.totalPrice!.toStringAsFixed(0) +
                                                 ' جم',
                                             style: TextStyle(
                                                 fontWeight: FontWeight.bold),
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
                                 child: TextFormField(
                                   controller: notesController,
                                   style: TextStyle(color: Colors.black),
                                   maxLines: 4,
                                   decoration: InputDecoration(
                                       contentPadding: EdgeInsets.all(8),
                                       hintText: 'ملاحظات',
                                       hintStyle: TextStyle(color: Colors.black),
                                       filled: true,

                                       fillColor: Color(0xffF7F7F9),

                                       enabledBorder:OutlineInputBorder(
                                           borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                                           borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)) ,
                                       disabledBorder: OutlineInputBorder(
                                           borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                                           borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),

                                       focusedBorder:  OutlineInputBorder(
                                           borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                                           borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
                                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                                           borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1))
                                   ),
                                 ),
                               ),
                             ),
                           ],
                         ),
                       ),
                     ),
                   ),
                    //checkout button
                   cartProvider.isLoading == false ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: MaterialButton(
                        height: getProportionateScreenHeight(50),
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () async {
                          if (addressId == 0) {
                            AppDialog.infoDialog(
                              context: context,
                              title: 'تنبيه',
                              message: 'برجاء اختيار عنوان التوصيل',
                              btnTxt: 'إغلاق',
                            );
                          } else {
                            final result = await cartProvider.checkOut(
                                addressId, notesController.text);
                            if (result['success'] &&
                                !result['error']
                                    .toString()
                                    .contains('عضويتك')) {
                              print("USER IS VERIFIED");

                              await orderProvider.getOrderDetails(result['orderSerialNumber']);
                              Get.toNamed(OrderDetails.routeName);

                              cartProvider.clearCart();
                            } else {
                              print("USER IS NOT VERIFIED");
                              await AppDialog.infoDialog(
                                context: context,
                                title: 'تنبيه',
                                message: result['error'],
                                btnTxt: 'إغلاق',
                              );

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
                              cart.totalPrice!.toStringAsFixed(0) + ' جم',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              'تأكيد الطلب',
                              style: TextStyle(color: Colors.white),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.black12,
                              child: Text(
                                cart.cartItems!.length.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ) :LoadingAnimationWidget.stretchedDots(
                     color: kPrimaryColor,
                     size: 50,
                   ),
                  ],
                );
        },
      ),
    );
  }

  //go to order details
  // void successDialog(
  //     BuildContext context, String message, String orderSerialNumber) {
  //   Get.defaultDialog(
  //       content: Text(message),
  //       textConfirm: 'تفاصيل الطلب',
  //       title: 'عملية ناجحة',
  //       buttonColor: Colors.red,
  //       onConfirm: () async {
  //         print(orderSerialNumber);
  //         await orderProvider.getOrderDetails(orderSerialNumber);
  //         Get.toNamed(OrderDetails.routeName);
  //       },
  //       confirmTextColor: kTextColor);
  // }

  Widget successDialog({String? message , BuildContext? context , String? orderNumber}){
    return PanaraConfirmDialog.showAnimatedGrow(context!,
        message: message!,
        color: kPrimaryColor,
        title: 'عملية ناجحة',
        confirmButtonText: 'تفاصيل الطلب',
        cancelButtonText: "أغلاق",
        onTapConfirm: ()async{
        await orderProvider.getOrderDetails(orderNumber!);
        Get.toNamed(OrderDetails.routeName);
        },
        onTapCancel: ()=> Get.back(),
        panaraDialogType: PanaraDialogType.custom) ;
  }
}


/*                                            title: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                               SizedBox(
                                                 width: getProportionateScreenWidth(320),
                                                 child:  Row(
                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                                   children: [
                                                     Text(
                                                       cart.cartItems[index]
                                                           .quantity
                                                           .toString(),
                                                       style: TextStyle(
                                                           color: Colors.black,
                                                           fontWeight:
                                                           FontWeight.bold,
                                                           fontSize: getProportionateScreenHeight(12)
                                                       ),
                                                     ),
                                                     Text(
                                                       'x ',
                                                       style: TextStyle(
                                                           color: Colors.black,
                                                           fontSize: getProportionateScreenHeight(12)
                                                       ),
                                                     ),
                                                     SizedBox(
                                                       width :getProportionateScreenWidth(154) ,
                                                       child: Text(
                                                         cart.cartItems[index]
                                                             .name +
                                                             ' ' +
                                                             cart.cartItems[index]
                                                                 .weight,
                                                         style: TextStyle(
                                                             color: Colors.black,
                                                             fontWeight:
                                                             FontWeight.bold,
                                                             fontSize: getProportionateScreenHeight(12)
                                                         ),
                                                       ),
                                                     ),
                                                     SizedBox(
                                                       width: 64,
                                                     ),
                                                     SizedBox(

                                                       child: Column(
                                                         crossAxisAlignment:
                                                         CrossAxisAlignment.end,
                                                         mainAxisAlignment: MainAxisAlignment.start,
                                                         children: [
                                                           Text(
                                                             "${
                                                                 (cart.cartItems[index]
                                                                     .price *
                                                                     cart
                                                                         .cartItems[
                                                                     index]
                                                                         .quantity).toStringAsFixed(1)}"
                                                                 +
                                                                 ' جم',
                                                             style: TextStyle(
                                                               fontWeight:
                                                               FontWeight.bold,
                                                             ),
                                                           ),
                                                         ],
                                                       ),
                                                     ),
                                                   ],
                                                 ),
                                               ),
                                                Text(
                                                  cart.cartItems[index].price
                                                          .toStringAsFixed(1) +
                                                      'X' +
                                                      cart.cartItems[index]
                                                          .quantity
                                                          .toString(),
                                                  style: TextStyle(
                                                    fontSize:
                                                        getProportionateScreenHeight(
                                                            10),
                                                    color: Colors.grey[900],
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    cart.cartItems[index].comment != null ? Text("طلب خاص: " , style: TextStyle(color: Colors.white),) : SizedBox() ,
                                                    cart.cartItems[index].comment != null ? SizedBox(
                                                      width: getProportionateScreenWidth(152),
                                                      child: Text(
                                                        "${cart.cartItems[index].comment}" ,
                                                        style: TextStyle(

                                                            fontSize: getProportionateScreenHeight(10),
                                                          color: Colors.black
                                                        ),
                                                      ),
                                                    ) : SizedBox(

                                                    )
                                                  ],
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
                                                      color: Colors.grey[900]),
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
                                                      color: Colors.grey[900]),
                                                ),
                                              ],
                                            ),*/

