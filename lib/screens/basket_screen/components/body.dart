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
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  String? orderName ;
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
          return cart == null || cart.cartItems!.isEmpty
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
                            SizedBox(
                              height: 14,
                            ),
                            //resturant info
                            //resturant
                           Padding(padding: EdgeInsets.symmetric(horizontal: 16) ,
                           child:  GestureDetector(
                             child:Row(
                               children: [
                                 Row(
                                   children: [
                                     Container(
                                       height: 64,
                                       width: 64,
                                       alignment: Alignment.center,
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(12.0),
                                         image: DecorationImage(
                                           fit: BoxFit.fill,
                                           image: NetworkImage(cart.resturantLogo.toString()),
                                         ),
                                       ),
                                     ),
                                   ],
                                 ) ,
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
                                     ) ,
                                     SizedBox(
                                       height: 6,
                                     ),
                                     Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text(
                                           cart.resturantName.toString(),
                                           style: TextStyle(
                                               color: Colors.black,
                                               fontWeight: FontWeight.bold,
                                               fontSize:
                                               getProportionateScreenHeight(16)),
                                         ),
                                         SizedBox(
                                           height: 6,
                                         ),
                                         Row(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             SizedBox(
                                               width: 4,
                                             ),
                                             Icon(
                                               FontAwesomeIcons.motorcycle,
                                               color: Colors.black,
                                               size:
                                               getProportionateScreenHeight(11),
                                             ),
                                             SizedBox(
                                                 width:
                                                 getProportionateScreenWidth(5)),
                                             Text(
                                               "التوصيل خلال ${cart.deliveryTime} دقيقة",
                                               style: TextStyle(
                                                   color: Colors.black,
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
                             onTap: () {
                               Provider.of<RestaurantsProvider>(context,
                                   listen: false)
                                   .fetchRestaurant(cart.resturantId!);
                               Get.offNamed(NewRestaurantScreen.routeName);
                             },
                           ),
                           ),

                            SizedBox(
                              height: 24,
                            ),

                            //cart info
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
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [

                                          Text('تفاصيل الطلب' , style: TextStyle(color: Colors.black , fontSize: 16 , fontWeight: FontWeight.bold),),
                                          //clear cart
                                          MaterialButton(
                                            height: 30,
                                            minWidth: 50,
                                            onPressed: () {
                                              clearCartDialog(context);
                                            },
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              side: BorderSide(
                                                color: Color(0xffB90101),
                                                width:
                                                    getProportionateScreenWidth(
                                                        1),
                                                style: BorderStyle.solid,
                                              ),
                                            ),
                                            child: Text('حذف' , style: TextStyle(
                                              color: Color(0xffB90101) ,
                                              height: 2.0 ,
                                              fontWeight: FontWeight.bold
                                            ),),
                                          )
                                        ],
                                      ),
                                      // SizedBox(
                                      //   height: 8,
                                      // ) ,
                                      //cart items
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Container(
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 16,
                                                ),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          width: getProportionateScreenWidth(200),
                                                          child: Row(
                                                            children: [

                                                              SizedBox(
                                                                width: getProportionateScreenWidth(200),
                                                                child: Text(
                                                                  cart.cartItems![index]
                                                                      .name.toString()
                                                                    ,
                                                                  style: TextStyle(
                                                                      color: Colors.black,
                                                                      fontWeight:
                                                                      FontWeight.bold,
                                                                      fontSize: getProportionateScreenHeight(18)
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        cart.cartItems![index]
                                                            .weight != null?
                                                            SizedBox(
                                                              height: 4,
                                                            )  : SizedBox(),
                                                        cart.cartItems![index]
                                                            .weight  != "" ? SizedBox(
                                                          width: getProportionateScreenWidth(200),
                                                          child:Text( cart.cartItems![index]
                                                              .weight! , style: TextStyle(
                                                              color: Color(0xff222222).withOpacity(0.6),
                                                              fontWeight:
                                                              FontWeight.w600,
                                                              fontSize: getProportionateScreenHeight(16)
                                                          ),) ,
                                                        ) : SizedBox(),
                                                        cart.cartItems![index]
                                                            .weight != null ?SizedBox(
                                                          height: 8,
                                                        ) : SizedBox(),
                                                        Row(
                                                          children: [
                                                            Text(cart.cartItems![index].quantity.toString(),style: TextStyle(
                                                              fontSize:
                                                              getProportionateScreenHeight(
                                                                  18),
                                                              color: Colors.black,
                                                            )) ,

                                                            Text(" X ", style: TextStyle(
                                                              fontSize:
                                                              getProportionateScreenHeight(
                                                                  18),
                                                              color: Colors.black,
                                                            )) ,
                                                            Text(cart.cartItems![index].price!.toStringAsFixed(0).toString(),style: TextStyle(
                                                              fontSize:
                                                              getProportionateScreenHeight(
                                                                  18),
                                                              color: Colors.black,
                                                            )) ,


                                                          ],
                                                        ),


                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width:
                                                      getProportionateScreenWidth(
                                                          110),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                        children: [
                                                          SizedBox(
                                                            height: 4,
                                                          ),
                                                          SizedBox(
                                                            child: Text(
                                                              "${(cart.cartItems![index].price! *
                                                                  cart.cartItems![index].quantity!).toStringAsFixed(0)
                                                                  +
                                                                  ' جم'}",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight.bold,
                                                                  fontSize: 18,
                                                                  color: Colors.black
                                                              ),
                                                            ),
                                                          ),

                                                          //edit-delete-buttons

                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ) ,
                                                cart.cartItems![index].firstAddonName != "" || cart.cartItems![index].secondAddonName != "" ?  SizedBox(
                                                  height: 8,
                                                ) : SizedBox(),
                                                cart.cartItems![index].firstAddonName != "" || cart.cartItems![index].secondAddonName != "" ?
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    cart.cartItems![index]
                                                        .firstAddonName !=
                                                        null
                                                        ?Text(
                                                      cart.cartItems![index]
                                                          .firstAddonName ==
                                                          null
                                                          ? ''
                                                          : cart.cartItems![index]
                                                          .firstAddonName!,
                                                      style: TextStyle(
                                                          color: Colors.black ,  fontSize: 16),
                                                    ) : SizedBox(),
                                                    cart.cartItems![index]
                                                        .secondAddonName !=
                                                        ""
                                                        ? Text(' - ',style: TextStyle(color: Colors.black , fontSize: 16),) : SizedBox(),
                                                    cart.cartItems![index]
                                                        .secondAddonName !=
                                                        ""
                                                        ?Text(
                                                      cart.cartItems![index]
                                                          .secondAddonName ==
                                                          null
                                                          ? ''
                                                          : cart.cartItems![index]
                                                          .secondAddonName!,
                                                      style: TextStyle(
                                                          color: Colors.black , fontSize: 16),
                                                    ) : SizedBox(),

                                                  ],
                                                ) :SizedBox() ,
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        cart.cartItems![index].comment != null ? Text("طلب خاص: " , style: TextStyle(color: Colors.black , fontSize: 16 , height: 2.0),) : SizedBox() ,
                                                        cart.cartItems![index].comment != null ? SizedBox(
                                                          width: getProportionateScreenWidth(180),
                                                          child: Text(
                                                            "${cart.cartItems![index].comment}" ,
                                                            style: TextStyle(
                                                                // fontSize: getProportionateScreenHeight(12) ,
                                                                color: Colors.black ,
                                                              fontSize: 16 ,
                                                              height: 2.0
                                                            ),
                                                          ),
                                                        ) : SizedBox(

                                                        )
                                                      ],
                                                    ) ,
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        SizedBox(
                                                          child: Container(
                                                            height : getProportionateScreenHeight(32),
                                                            width: getProportionateScreenHeight(32),
                                                            decoration:
                                                            BoxDecoration(

                                                                border: Border
                                                                    .all(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                color: Colors.white,
                                                                shape: BoxShape.circle,
                                                                ),
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
                                                                    cart.cartItems![
                                                                    index],
                                                                    index);
                                                              },
                                                              child: Image.asset("assets/icons/edit-2.png" , height: 20,scale: 4,),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                          getProportionateScreenWidth(
                                                              5),
                                                        ),
                                                        SizedBox(
                                                          child: Container(
                                                            height : getProportionateScreenHeight(32),
                                                            width: getProportionateScreenHeight(32),
                                                            decoration:
                                                            BoxDecoration(
                                                              color :Colors.white ,
                                                              border: Border.all(
                                                                color:
                                                                Colors.white,
                                                              ),

                                                              shape: BoxShape.circle
                                                            ),
                                                            child:
                                                            GestureDetector(
//delete cart item
                                                              onTap: () {
                                                                deleteDialog(
                                                                    context,
                                                                    index);
                                                              },
                                                              child: Image.asset("assets/icons/Group 1000000840.png" , scale: 4 ,height: 20,),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                  ],
                                                ),
                                                Divider(
                                                  thickness: 1,
                                                  color: Colors.black.withOpacity(0.1),

                                                ),

                                              ],
                                            ),
                                          );
                                        },


                                        itemCount: cart.cartItems!.length,
                                      ),
                                      SizedBox(
                                        height: getProportionateScreenHeight(10),
                                      ),
                                      Form(
                                          child: TextFormField(
                                            initialValue: cart.orderName,
                                            onChanged: (String value){
                                              orderName = value ;
                                            },
                                            onSaved: (String? value){
                                              orderName = value ;
                                            },
                                            style: TextStyle(
                                              color : Colors.black ,
                                            ),
                                            decoration: InputDecoration(

                                              hintText: "اسم الطلب",
                                              hintStyle: TextStyle(
                                                color: Colors.black
                                              ),
                                              contentPadding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10) , vertical: getProportionateScreenHeight(10)) ,
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(getProportionateScreenHeight(15)) , borderSide: BorderSide(
                                                color: Color(0xffE4E4E5) ,
                                              ) ,

                                              ) ,
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(getProportionateScreenHeight(15)) , borderSide: BorderSide(
                                                color: Color(0xffE4E4E5) ,
                                              ) ,
                                              )
                                            ),
                                            maxLines: 1,

                                          )
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ) ,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            //payment info
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(16.0)),
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
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                        height: 8,
                                      ) ,
                                      Text('تفاصيل الدفع' , style: TextStyle(
                                        color: Colors.black ,
                                        fontWeight: FontWeight.bold ,
                                        fontSize: 16
                                      ),),
                                      SizedBox(
                                        height: 8,
                                      ) ,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'مجموع الطلب',
                                            style: TextStyle(
                                              color: Colors.black ,
                                              fontSize: 16
                                            ),
                                          ),
                                          Text(
                                            cart.subTotalPrice!
                                                    .toStringAsFixed(1) +
                                                ' جم',
                                            style: TextStyle(
                                              color: Colors.black ,
                                              fontSize: 16
                                            ),
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
                                                TextStyle(color: Colors.black , fontSize: 16),
                                          ),
                                          Text(
                                            cart.deliveryPrice
                                                    !.toStringAsFixed(1) +
                                                ' جم',
                                            style:
                                                TextStyle(color: Colors.black , fontSize: 16),
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
                                            'الإجمالى',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold ,
                                                color: Colors.black ,
                                              fontSize: 16
                                            ),
                                          ),
                                          Text(
                                            cart.totalPrice!.toStringAsFixed(1) +
                                                ' جم',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold , color: Colors.black , fontSize: 16),
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
                        onPressed: () async {
                          final cartProvider = Provider.of<CartProvider>(context , listen:  false) ;
                          await  cartProvider.addOrderName(orderName??"");
                          await cartProvider.initCart() ;
                          if (user == null) {
                            Get.toNamed(SignInScreen.routeName);
                          } else {
                            Navigator.push(context, MaterialPageRoute(builder: (_)=> PlacementOrder(orderName: orderName??'',))) ;

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
                              cart.totalPrice !.toStringAsFixed(1) + ' جم',
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




//sub







//trilling




/*                        leading: Container(
                                  height: 64,
                                  width: 64,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(cart.resturantLogo),
                                    ),
                                  ),
                                ),
                                title: ,
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cart.resturantName,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              getProportionateScreenHeight(20)),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.motorcycle,
                                          color: Colors.black,
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
                                              fontSize:
                                                  getProportionateScreenHeight(
                                                      10)),
                                        )
                                      ],
                                    ),
                                  ],
                                ),*/