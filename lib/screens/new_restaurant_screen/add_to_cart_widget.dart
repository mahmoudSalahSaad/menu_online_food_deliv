import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/components/loading_circle.dart';
import 'package:menu_egypt/models/cart_item.dart';
import 'package:menu_egypt/models/resturan_categories_and_products.dart';
import 'package:menu_egypt/providers/cart_provider.dart';
import 'package:menu_egypt/providers/resturant_items_provider.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';

void addToCartBottomSheet(BuildContext context, String resturantName,
    String resturantLogo, CatgeoryProduct product) {
  CartItemModel? cartItem;

  int quantity = 1;
  num price = 0.0;
  String weight = '';
  String firstAddonName = '';
  String secondAddonName = '';
  String? comment ;
  int weightId = 0, firstAddId = 0, secondAddId = 0;
  //selections

  List<bool> isSelectedWeight = [];
  List<Sizes> buttonsListWeight = [];
  int selectedWeightIndex = 0;
  List<bool> isSelectedFirstAddon = [];
  List<FirstAdditionsData> buttonsListFirstAddon = [];
  int selectedFirstAddIndex = -1;
  List<bool> isSelectedSecondAddon = [];
  List<SecondAdditionsData> buttonsListSeccondAddon = [];
  int selectedSecondAddIndex = -1;
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(getProportionateScreenHeight(24))
      ),
      builder: (builder) {
        return StatefulBuilder(
          builder: (context, setBottomSheetState) {
            //restaurantItemsProvider
            final restaurantItemsProvider =
                Provider.of<ResturantItemsProvider>(context, listen: true);
            if (!restaurantItemsProvider.isLoading) {
              //main product price
              if (price == 0.0) {
                price = product.product!.price!.toDouble();
              }
              //weight selections
              buttonsListWeight = product.sizes ?? [];
              isSelectedWeight = product.sizes != null
                  ? List.generate(product.sizes!.length, (index) {
                      if (index == selectedWeightIndex) {
                        return true;
                      }
                      return false;
                    })
                  : List.generate(0, (_) => false);
              //first add selections
              buttonsListFirstAddon = product.firstAdditionsData != null
                  ? product.firstAdditionsData!
                  : [];

              isSelectedFirstAddon = product.firstAdditionsData != null
                  ? List.generate(product.firstAdditionsData!.length, (index) {
                      if (index == selectedFirstAddIndex) {
                        return true;
                      }
                      return false;
                    })
                  : List.generate(0, (_) => false);
              //second add selections
              buttonsListSeccondAddon = product.secondAdditionsData != null
                  ? product.secondAdditionsData!
                  : [];
              isSelectedSecondAddon = product.secondAdditionsData != null
                  ? List.generate(product.secondAdditionsData!.length, (index) {
                      if (index == selectedSecondAddIndex) {
                        return true;
                      }
                      return false;
                    })
                  : List.generate(0, (_) => false);
              //force selected weight
              if (buttonsListWeight.isNotEmpty && price == 0) {
                isSelectedWeight[0] = true;
                weightId = buttonsListWeight[0].id!;
                price = buttonsListWeight[0].price!.toDouble();
                weight = buttonsListWeight[0].title!;
              }
              //cart model
              cartItem = CartItemModel(
                //fixed params
                id: product.product!.id,
                name: product.product!.title,
                description: product.product!.shortDescription,
                photoUrl: product.product!.image,
                //selected params
                price: price,
                quantity: quantity,
                weight: weight,
                firstAddonName: firstAddonName,
                secondAddonName: secondAddonName,
                firstAddonPrice: 0.0,
                secondAddonPrice: 0.0,
                weightId: weightId,
                firstAddId: firstAddId,
                secondAddId: secondAddId,
                //the product itself
                product: product,
                comment: comment
              );
            }
            //UI
            return SafeArea(child: Container(

              height: MediaQuery.of(context).size.height*0.8,

              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.0),
                      topRight: Radius.circular(24.0))),
              // color: Colors.transparent,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 1.2,

                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0))),
                            child: restaurantItemsProvider.isLoading
                                ? LoadingCircle()
                                : SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.01,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding:
                                        const EdgeInsets.symmetric(horizontal: 16.0 , vertical: 16),
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child:Image.asset("assets/icons/cancel.png" , scale: 4.0,),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10.0),
                                            topRight: Radius.circular(10.0))),

                                    child:Column(
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                            children: [
                                            Container(
                                            height: 72,
                                            width: 72,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.0),
                                            image: DecorationImage(

                                            fit: BoxFit.fill,
                                            image: NetworkImage(
                                                'https://menuegypt.com/order_online/product_images/' +
                                                    product.product!.image.toString()),
                                            ),
                                            ),
                                            )
                                            ],
                                            ),
                                            SizedBox(
                                              width: getProportionateScreenWidth(10),
                                            ) ,
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start ,
                                              children: [
                                                SizedBox(
                                                  width: getProportionateScreenWidth(270) ,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: getProportionateScreenWidth(210),
                                                        child: Text(
                                                          product.product!.title.toString() ,
                                                          style: TextStyle(color: Colors.black, fontSize: 16 , fontWeight: FontWeight.bold),
                                                        ),
                                                      ),
                                                      Text(
                                                        price.toStringAsFixed(0) + ' جم',
                                                        style: TextStyle(color: Colors.black , fontSize: 16 , fontWeight: FontWeight.bold),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                SizedBox(
                                                  width: getProportionateScreenWidth(270),

                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: getProportionateScreenWidth(180),
                                                        height: 70,
                                                        child: Text(
                                                          product.product!.shortDescription ?? '',
                                                          style: TextStyle(color: Colors.grey.shade500),
                                                        ),
                                                      ),
                                                     SizedBox(

                                                       child:  Row(
                                                         crossAxisAlignment: CrossAxisAlignment.center,
                                                         children: [
                                                           GestureDetector(
                                                             onTap: () {
                                                               setBottomSheetState(() {
                                                                 quantity++;
                                                               });
                                                             },
                                                             child:  Image.asset("assets/icons/Plus.png" , scale: 4.2,),
                                                           ),
                                                           SizedBox(
                                                             width: 12,
                                                           ),
                                                           Text(
                                                             quantity.toString(),
                                                             style: TextStyle(
                                                                 color: Colors.black,
                                                                 fontSize:
                                                                 getProportionateScreenHeight(
                                                                     18),
                                                                 fontWeight: FontWeight.bold,
                                                                 height: 2.2
                                                             ),
                                                           ),
                                                           SizedBox(
                                                             width: 12,
                                                           ),
                                                           GestureDetector(
                                                             onTap: () {
                                                               if (quantity != 1) {
                                                                 setBottomSheetState(() {
                                                                   quantity--;
                                                                 });
                                                               }
                                                             },
                                                             child:
                                                             Image.asset("assets/icons/minus.png" , scale: 4.2,),

                                                           ),
                                                         ],
                                                       ),
                                                     )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ) ,

                                      ],
                                    ),
                                  ),
                                  //weight
                                  SizedBox(
                                    height: 10,
                                  ),
                                  buttonsListWeight.isNotEmpty
                                      ? Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0 , vertical: 10),
                                    child: Text(
                                      'مقاسات',
                                      style: TextStyle(color: Colors.black , fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                  )
                                      : Padding(
                                    padding: const EdgeInsets.all(0.0),
                                  ),
                                  buttonsListWeight.isNotEmpty
                                      ? Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Column(
                                      children: [
                                        GridView.count(
                                          physics: NeverScrollableScrollPhysics(),
                                          primary: true,
                                          shrinkWrap: true,
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 5,
                                          padding: EdgeInsets.symmetric(horizontal: 8),

                                          mainAxisSpacing: 5,

                                          children: List.generate(
                                            isSelectedWeight.length,
                                                (index) {
                                              return Column(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      setBottomSheetState(
                                                            () {
                                                          selectedWeightIndex = index;
                                                          weightId =
                                                              buttonsListWeight[index]
                                                                  .id!;
                                                          weight =
                                                              buttonsListWeight[index]
                                                                  .title!;
                                                          price =
                                                              buttonsListWeight[index]
                                                                  .price!
                                                                  .toDouble();
                                                          for (int indexBtn = 0;
                                                          indexBtn <
                                                              isSelectedWeight
                                                                  .length;
                                                          indexBtn++) {
                                                            if (indexBtn == index) {
                                                              isSelectedWeight[
                                                              indexBtn] = true;
                                                            } else {
                                                              isSelectedWeight[
                                                              indexBtn] = false;
                                                            }
                                                          }
                                                        },
                                                      );
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.symmetric(vertical:4.6),
                                                      decoration: BoxDecoration(
                                                        color: isSelectedWeight[index]
                                                            ? kAppBarColor
                                                            : Color(0xffF8FAFC),
                                                        borderRadius:
                                                        BorderRadius.circular(8),

                                                      ),
                                                      child: Center(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                          children: [
                                                            Text(
                                                              buttonsListWeight[index]
                                                                  .title.toString(),
                                                              style: TextStyle(
                                                                  color:
                                                                  isSelectedWeight[
                                                                  index]
                                                                      ? Colors.white
                                                                      : Colors
                                                                      .black,
                                                                  fontSize: 14 ,
                                                                  height: 2.0
                                                              ),
                                                            ),
                                                            Text(
                                                              buttonsListWeight[index]
                                                                  .price!
                                                                  .toStringAsFixed(
                                                                  0) +
                                                                  ' جم',
                                                              style: TextStyle(
                                                                  color:
                                                                  isSelectedWeight[
                                                                  index]
                                                                      ? Colors.white
                                                                      : Colors
                                                                      .black,
                                                                  height: 2.0
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                      : Padding(
                                    padding: const EdgeInsets.all(0.0),
                                  ),
                                  //first addon
                                  buttonsListFirstAddon.isNotEmpty
                                      ? Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Text(
                                      product.firstAdditionTitle.toString(),
                                      style: TextStyle(color: Colors.black , fontSize: 16 ,fontWeight: FontWeight.bold),
                                    ),
                                  )
                                      : Padding(
                                    padding: const EdgeInsets.all(0.0),
                                  ),
                                  buttonsListFirstAddon.isNotEmpty
                                      ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        GridView.count(
                                          physics: NeverScrollableScrollPhysics(),
                                          primary: true,
                                          crossAxisCount: 3,
                                          shrinkWrap: true,
                                          padding: EdgeInsets.symmetric(horizontal: 8),
                                          crossAxisSpacing: 5,
                                          mainAxisSpacing: 5,
                                          childAspectRatio: 4,

                                          children: List.generate(
                                            isSelectedFirstAddon.length,
                                                (index) {
                                              return InkWell(
                                                onTap: () {
                                                  setBottomSheetState(
                                                        () {
                                                      selectedFirstAddIndex =
                                                          index;
                                                      firstAddId =
                                                          buttonsListFirstAddon[
                                                          index]
                                                              .id!;
                                                      firstAddonName =
                                                          buttonsListFirstAddon[
                                                          index]
                                                              .title!;
                                                      for (int indexBtn = 0;
                                                      indexBtn <
                                                          isSelectedFirstAddon
                                                              .length;
                                                      indexBtn++) {
                                                        if (indexBtn == index) {
                                                          isSelectedFirstAddon[
                                                          indexBtn] = true;
                                                        } else {
                                                          isSelectedFirstAddon[
                                                          indexBtn] = false;
                                                        }
                                                      }
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(vertical: 4.6),
                                                  decoration: BoxDecoration(
                                                    color: isSelectedFirstAddon[
                                                    index]
                                                        ? kAppBarColor
                                                        : Color(0xffF8FAFC),
                                                    borderRadius:
                                                    BorderRadius.circular(8),

                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      buttonsListFirstAddon[index]
                                                          .title!,
                                                      style: TextStyle(
                                                        color:
                                                        isSelectedFirstAddon[
                                                        index]
                                                            ? Colors.white
                                                            : Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                      : Padding(
                                    padding: const EdgeInsets.all(0.0),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  //second addon
                                  buttonsListSeccondAddon.isNotEmpty
                                      ? Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Text(
                                      product.secondAdditionTitle!,
                                      style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold , fontSize: 16),
                                    ),
                                  )
                                      : Padding(
                                    padding: const EdgeInsets.all(0.0),
                                  ),
                                  buttonsListSeccondAddon.isNotEmpty
                                      ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        GridView.count(
                                          physics: NeverScrollableScrollPhysics(),
                                          primary: true,
                                          crossAxisCount: 3,
                                          shrinkWrap: true,
                                          padding: EdgeInsets.symmetric(horizontal: 8),

                                          crossAxisSpacing: 5,
                                          mainAxisSpacing: 5,
                                          childAspectRatio: 4,
                                          children: List.generate(
                                            isSelectedSecondAddon.length,
                                                (index) {
                                              return InkWell(
                                                onTap: () {
                                                  setBottomSheetState(
                                                        () {
                                                      selectedSecondAddIndex =
                                                          index;
                                                      secondAddId =
                                                          buttonsListSeccondAddon[
                                                          index]
                                                              .id!;
                                                      secondAddonName =
                                                          buttonsListSeccondAddon[
                                                          index]
                                                              .title!;
                                                      for (int indexBtn = 0;
                                                      indexBtn <
                                                          isSelectedSecondAddon
                                                              .length;
                                                      indexBtn++) {
                                                        if (indexBtn == index) {
                                                          isSelectedSecondAddon[
                                                          indexBtn] = true;
                                                        } else {
                                                          isSelectedSecondAddon[
                                                          indexBtn] = false;
                                                        }
                                                      }
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(vertical: 4.6),
                                                  decoration: BoxDecoration(
                                                    color: isSelectedSecondAddon[
                                                    index]
                                                        ? kAppBarColor
                                                        : Color(0xffF8FAFC),
                                                    borderRadius:
                                                    BorderRadius.circular(8),

                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      buttonsListSeccondAddon[
                                                      index]
                                                          .title!,
                                                      style: TextStyle(
                                                        color:
                                                        isSelectedSecondAddon[
                                                        index]
                                                            ? Colors.white
                                                            : Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                      : Padding(
                                    padding: const EdgeInsets.all(0.0),
                                  ),


                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Form(
                                          child: SizedBox(
                                            width: getProportionateScreenWidth(355),
                                            child: TextFormField(

                                              onChanged: (String value){
                                                comment = value ;
                                              },
                                              onSaved: (String? value){
                                                comment = value ;
                                              },
                                              style: TextStyle(
                                                  color: Colors.black
                                              ),
                                              decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Color(0xffF7F7F9),
                                                  hintStyle: TextStyle(color: Colors.black),
                                                  focusColor: Colors.white,
                                                  enabledBorder:OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                                                      borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)) ,
                                                  disabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                                                      borderSide: BorderSide(color: Color(0xffE4E4E5)  , width: 1)),

                                                  focusedBorder:  OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                                                      borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
                                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                                                      borderSide: BorderSide(color: Color(0xffE4E4E5)  , width: 1)),
                                                contentPadding: EdgeInsets.symmetric(vertical: 8 , horizontal: getProportionateScreenWidth(10)) ,
                                                hintText: "ملاحظات"  ,

                                              ),
                                              maxLines: 5,

                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ) ,


                                  //total



                                  // SizedBox(
                                  //   height: getProportionateScreenHeight(180),
                                  // )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )  ,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.18,
                      decoration: BoxDecoration(
                        color: Colors.white
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'المبلغ الإجمالى',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                      getProportionateScreenHeight(20)),
                                ),
                                Text(
                                  (price * quantity).toStringAsFixed(0) +
                                      ' جم',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                      getProportionateScreenHeight(20)),
                                ),
                              ],
                            ),
                          ),
                          //add to cart
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MaterialButton(
                              minWidth: MediaQuery.of(context).size.width,
                              onPressed: () {
                                Provider.of<CartProvider>(context,
                                    listen: false)
                                    .addItemToCart(
                                    cartItem!,
                                    restaurantItemsProvider
                                        .resturantCategoriesAndProducts
                                        !.resturantData
                                        !.restId!,
                                    restaurantItemsProvider
                                        .resturantCategoriesAndProducts
                                        !.resturantData
                                        !.deliveryFee!
                                        .toDouble(),
                                    restaurantItemsProvider
                                        .resturantCategoriesAndProducts
                                        !.resturantData
                                        !.deliveryTime!,
                                    resturantName,
                                    resturantLogo);
                                Get.back();
                              },
                              color: Color(0xffB90101),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'اضف الى السلة',
                                style: TextStyle(color: Colors.white ,fontSize: 16 , fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ));
          },
        );
      });
}

// //img
// leading: Column(
// children: [
// Container(
// height: 72,
// width: 72,
// alignment: Alignment.center,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(10.0),
// image: DecorationImage(
//
// fit: BoxFit.fill,
// image: product.product.image == null
// ? AssetImage('assets/icons/menu.png')
//     : NetworkImage(
// 'https://menuegypt.com/order_online/product_images/' +
// product.product.image),
// ),
// ),
// )
// ],
// ),
// //name , price
// title:
// Row(
// mainAxisAlignment:
// MainAxisAlignment.spaceBetween,
// children: [
// SizedBox(
// width: getProportionateScreenWidth(180),
// child: Text(
// product.product.title ,
// style: TextStyle(color: Colors.black),
// ),
// ),
// Text(
// price.toStringAsFixed(1) + ' جم',
// style: TextStyle(color: kAppBarColor),
// )
// ],
// ),
// subtitle:
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// //description
// Text(
// product.product.shortDescription ?? '',
// style: TextStyle(color: Colors.black),
// ),
// // incr , decr quantity
// Row(
// children: [
// IconButton(
// onPressed: () {
// setBottomSheetState(() {
// quantity++;
// });
// },
// icon: Icon(Icons.add_circle_outline),
// color: Colors.red,
// ),
// Text(
// quantity.toString(),
// style: TextStyle(
// color: Colors.black,
// fontSize:
// getProportionateScreenHeight(
// 15),
// fontWeight: FontWeight.bold,
// ),
// ),
// IconButton(
// onPressed: () {
// if (quantity != 1) {
// setBottomSheetState(() {
// quantity--;
// });
// }
// },
// icon:
// Icon(Icons.remove_circle_outline),
// color: Colors.red,
// ),
// ],
// )
// ],
// ),