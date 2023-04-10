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

void editCartBottomSheet(
    BuildContext context, CartItemModel itemToEdit, int itemIndex) {
  CartItemModel? cartItem;

  int? quantity = itemToEdit.quantity;
  num? price = itemToEdit.price;
  String? weight = itemToEdit.weight;
  String? firstAddonName = itemToEdit.firstAddonName;
  String? secondAddonName = itemToEdit.secondAddonName;
  int? weightId = itemToEdit.weightId,
      firstAddId = itemToEdit.firstAddId,
      secondAddId = itemToEdit.secondAddId;
  String? comment = itemToEdit.comment ;
  //selections
  List<bool> isSelectedWeight = [];
  List<Sizes> buttonsListWeight = [];
  List<bool> isSelectedFirstAddon = [];
  List<FirstAdditionsData> buttonsListFirstAddon = [];
  List<bool> isSelectedSecondAddon = [];
  List<SecondAdditionsData> buttonsListSeccondAddon = [];

  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24)
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
                price = itemToEdit.product!.product!.price!.toDouble();
              }
              //weight selections
              buttonsListWeight = itemToEdit.product!.sizes != null
                  ? itemToEdit.product!.sizes!
                  : [];
              isSelectedWeight = itemToEdit.product!.sizes != null
                  ? List.generate(itemToEdit.product!.sizes!.length, (_) => false)
                  : List.generate(0, (_) => false);
              //first add selections
              buttonsListFirstAddon =
                  itemToEdit.product!.firstAdditionsData != null
                      ? itemToEdit.product!.firstAdditionsData!
                      : [];
              isSelectedFirstAddon =
                  itemToEdit.product!.firstAdditionsData != null
                      ? List.generate(
                          itemToEdit.product!.firstAdditionsData!.length,
                          (_) => false)
                      : List.generate(0, (_) => false);
              //second add selections
              buttonsListSeccondAddon =
                  itemToEdit.product!.secondAdditionsData != null
                      ? itemToEdit.product!.secondAdditionsData!
                      : [];
              isSelectedSecondAddon =
                  itemToEdit.product!.secondAdditionsData != null
                      ? List.generate(
                          itemToEdit.product!.secondAdditionsData!.length,
                          (_) => false)
                      : List.generate(0, (_) => false);

              //mark selected weight

              if (buttonsListWeight.isNotEmpty &&
                  weightId != 0 &&
                  weightId != null) {
                isSelectedWeight[buttonsListWeight
                    .indexWhere((element) => element.id == weightId)] = true;
              }
              //mark selected firstAdd

              if (buttonsListFirstAddon.isNotEmpty &&
                  firstAddId != 0 &&
                  firstAddId != null) {
                isSelectedFirstAddon[buttonsListFirstAddon
                    .indexWhere((element) => element.id == firstAddId)] = true;
              }
              //mark selected secondAdd

              if (buttonsListSeccondAddon.isNotEmpty &&
                  secondAddId != 0 &&
                  secondAddId != null) {
                isSelectedSecondAddon[buttonsListSeccondAddon
                    .indexWhere((element) => element.id == secondAddId)] = true;
              }
              //cart model
              cartItem = CartItemModel(
                //fixed params
                id: itemToEdit.product!.product!.id,
                name: itemToEdit.product!.product!.title,
                description: itemToEdit.product!.product!.shortDescription,
                photoUrl: itemToEdit.product!.product!.image,
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
                product: itemToEdit.product,
                comment: comment
              );
            }

            //UI
            return Container(
              height: MediaQuery.of(context).size.height*0.8,
              color: Colors.transparent,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height*1.2,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0))),
                            child: restaurantItemsProvider.isLoading
                                ? LoadingCircle()
                                : SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                        const EdgeInsets.symmetric(horizontal: 4.0),
                                        child: IconButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          icon: Icon(
                                            Icons.cancel_outlined,
                                            color: Colors.black,
                                            size: getProportionateScreenHeight(25),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    child: Column(
                                       children: [
                                         Row(
                                           children: [
                                             Container(
                                               height: 72,
                                               width: 72,
                                               alignment: Alignment.center,
                                               decoration: BoxDecoration(
                                                 borderRadius: BorderRadius.circular(5.0),
                                                 image: DecorationImage(
                                                   fit: BoxFit.fill,
                                                   image: NetworkImage(
                                                       'https://menuegypt.com/order_online/product_images/' +
                                                           itemToEdit
                                                               .product!.product!.image.toString()) ,
                                                 ),
                                               ),
                                             ),
                                             SizedBox(
                                               width: getProportionateScreenWidth(10),
                                             ),
                                             SizedBox(
                                               width: getProportionateScreenWidth(262),
                                               child: Column(
                                                 children: [
                                                   Row(
                                                     mainAxisAlignment:
                                                     MainAxisAlignment.spaceBetween,
                                                     children: [
                                                       Text(
                                                         itemToEdit.product!.product!.title! + "    ",
                                                         style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),
                                                       ),
                                                       Text(
                                                         price!.toStringAsFixed(1) + ' جم',
                                                         style: TextStyle(color: Colors.black),
                                                       )
                                                     ],
                                                   ),
                                                   Row(
                                                     crossAxisAlignment: CrossAxisAlignment.start,
                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                     children: [
                                                       //description
                                                       SizedBox(
                                                         width: 170,
                                                         child: Text(
                                                           itemToEdit.product!.product
                                                               !.shortDescription ??
                                                               '',
                                                           style: TextStyle(color: Colors.black),
                                                         ),
                                                       ),
                                                       // incr , decr quantity
                                                       Row(
                                                         mainAxisAlignment: MainAxisAlignment.center,
                                                         children: [
                                                           GestureDetector(
                                                             onTap: () {
                                                               setBottomSheetState(() {
                                                                 quantity =quantity! + 1;
                                                               });
                                                             },
                                                             child: Icon(Icons.add_circle_rounded , color: Color(0xffB90101),),
                                                            
                                                           ),
                                                           SizedBox(
                                                             width: 16,
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
                                                             width: 16,
                                                           ),
                                                           GestureDetector(
                                                             onTap: () {
                                                               if (quantity != 1) {
                                                                 setBottomSheetState(() {
                                                                   quantity  = quantity! -1 ;
                                                                 });
                                                               }
                                                             },
                                                             child:
                                                             Icon(Icons.remove_circle_outline,color: Colors.black,),

                                                           ),
                                                         ],
                                                       )
                                                     ],
                                                   ),
                                                 ],
                                               ),
                                             )
                                           ],
                                         )
                                       ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ) ,
                                  //weight
                                  buttonsListWeight.isNotEmpty
                                      ? Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0 , vertical: 8),
                                    child: Text(
                                      'مقاسات',
                                      style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold ,fontSize: 16),
                                    ),
                                  )
                                      : Padding(
                                    padding: const EdgeInsets.all(0.0),
                                  ),
                                  buttonsListWeight.isNotEmpty
                                      ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height:
                                      MediaQuery.of(context).size.height *
                                          0.09,
                                      color: Colors.white,
                                      child: GridView.count(
                                        physics: NeverScrollableScrollPhysics(),
                                        primary: true,
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 5,
                                        padding: EdgeInsets.symmetric(horizontal: 8),
                                        mainAxisSpacing: 5,
                                        childAspectRatio: 4,
                                        children: List.generate(
                                          isSelectedWeight.length,
                                              (index) {
                                            return InkWell(
                                              onTap: () {
                                                setBottomSheetState(
                                                      () {
                                                    weightId =
                                                        buttonsListWeight[index]
                                                            .id;
                                                    weight =
                                                        buttonsListWeight[index]
                                                            .title;
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
                                                        ),
                                                      ),
                                                      Text(
                                                        buttonsListWeight[index]
                                                            .price
                                                            .toString() +
                                                            ' جم',
                                                        style: TextStyle(
                                                          color:
                                                          isSelectedWeight[
                                                          index]
                                                              ? Colors.white
                                                              : Colors
                                                              .black,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  )
                                      : Padding(
                                    padding: const EdgeInsets.all(0.0),
                                  ),
                                  //first addon
                                  buttonsListFirstAddon.isNotEmpty
                                      ? Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0 , vertical: 8),
                                    child: Text(
                                      itemToEdit.product!.firstAdditionTitle.toString(),
                                      style: TextStyle(color: Colors.black  , fontSize: 16 , fontWeight: FontWeight.bold),
                                    ),
                                  )
                                      : Padding(
                                    padding: const EdgeInsets.all(0.0),
                                  ),
                                  buttonsListFirstAddon.isNotEmpty
                                      ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height:
                                      MediaQuery.of(context).size.height *
                                          0.09,
                                      color: Colors.white,
                                      child: GridView.count(
                                        physics: NeverScrollableScrollPhysics(),
                                        primary: true,
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 5,
                                        mainAxisSpacing: 5,
                                        padding: EdgeInsets.symmetric(horizontal: 8),
                                        childAspectRatio: 4,
                                        children: List.generate(
                                          isSelectedFirstAddon.length,
                                              (index) {
                                            return InkWell(
                                              onTap: () {
                                                setBottomSheetState(
                                                      () {
                                                    firstAddId =
                                                        buttonsListFirstAddon[
                                                        index]
                                                            .id;
                                                    firstAddonName =
                                                        buttonsListFirstAddon[
                                                        index]
                                                            .title;
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
                                                        .title.toString(),
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
                                      ),
                                    ),
                                  )
                                      : Padding(
                                    padding: const EdgeInsets.all(0.0),
                                  ),
                                  //second addon
                                  buttonsListSeccondAddon.isNotEmpty
                                      ? Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0 , vertical: 8),
                                    child: Text(
                                      itemToEdit.product!.secondAdditionTitle.toString(),
                                      style: TextStyle(color: Colors.black ,fontSize: 16 , fontWeight: FontWeight.bold),
                                    ),
                                  )
                                      : Padding(
                                    padding: const EdgeInsets.all(0.0),
                                  ),
                                  buttonsListSeccondAddon.isNotEmpty
                                      ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height:
                                      MediaQuery.of(context).size.height *
                                          0.09,
                                      color: Colors.white,
                                      child: GridView.count(
                                        physics: NeverScrollableScrollPhysics(),
                                        primary: true,
                                        crossAxisCount: 3,
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
                                                    secondAddId =
                                                        buttonsListSeccondAddon[
                                                        index]
                                                            .id;
                                                    secondAddonName =
                                                        buttonsListSeccondAddon[
                                                        index]
                                                            .title;
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
                                                        .title.toString(),
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
                                      ),
                                    ),
                                  )
                                      : Padding(
                                    padding: const EdgeInsets.all(0.0),
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
                                              initialValue: comment,

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

                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(getProportionateScreenHeight(10)) ,
                                                  borderSide: BorderSide(color: kPrimaryColor , width: 1) ,
                                                ) ,
                                                enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(getProportionateScreenHeight(10)) ,
                                                  borderSide: BorderSide(color: kPrimaryColor , width: 1) ,
                                                ) ,
                                                contentPadding: EdgeInsets.symmetric(vertical: 8 , horizontal: getProportionateScreenWidth(10)) ,
                                                hintText: "طلب خاص"  ,
                                                hintStyle: TextStyle(
                                                    color: Colors.black
                                                ) ,
                                              ),
                                              maxLines: 3,

                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ) ,

                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ) ,
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.18,
                      decoration: BoxDecoration(
                        color: Colors.white
                      ),
                      child: Column(
                        children: [
                          //total
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
                                  (price! * quantity!).toStringAsFixed(1) +
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
                                    .editCartItem(cartItem!, itemIndex , "");
                                Get.back();
                              },
                              color: kAppBarColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'تعديل السلة',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      });
}
/*
       //img
                                      leading: Container(
                                        height: 50,
                                        width: 50,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5.0),
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: itemToEdit.product.product.image ==
                                                null
                                                ? AssetImage('assets/icons/menu.png')
                                                : NetworkImage(
                                                'https://menuegypt.com/order_online/product_images/' +
                                                    itemToEdit
                                                        .product.product.image),
                                          ),
                                        ),
                                      ),
                                      //name , price
                                      title: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            itemToEdit.product.product.title + "    ",
                                            style: TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            price.toStringAsFixed(1) + ' جم',
                                            style: TextStyle(color: kAppBarColor),
                                          )
                                        ],
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          //description
                                          Text(
                                            itemToEdit.product.product
                                                .shortDescription ??
                                                '',
                                            style: TextStyle(color: Colors.black),
                                          ),
                                          // incr , decr quantity
                                          Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  setBottomSheetState(() {
                                                    quantity++;
                                                  });
                                                },
                                                icon: Icon(Icons.add_circle_outline),
                                                color: Colors.red,
                                              ),
                                              Text(
                                                quantity.toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize:
                                                  getProportionateScreenHeight(
                                                      15),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  if (quantity != 1) {
                                                    setBottomSheetState(() {
                                                      quantity--;
                                                    });
                                                  }
                                                },
                                                icon:
                                                Icon(Icons.remove_circle_outline),
                                                color: Colors.red,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),*/