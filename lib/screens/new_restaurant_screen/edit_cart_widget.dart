import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/components/loading_circle.dart';
import 'package:menu_egypt/models/cart_item.dart';
import 'package:menu_egypt/models/resturant_product.dart';
import 'package:menu_egypt/providers/cart_provider.dart';
import 'package:menu_egypt/providers/resturant_items_provider.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';

void editCartBottomSheet(
    BuildContext context, CartItemModel itemToEdit, int itemIndex) {
  CartItemModel cartItem;

  int quantity = itemToEdit.quantity;
  num price = itemToEdit.price;
  String weight = itemToEdit.weight;
  String firstAddonName = itemToEdit.firstAddonName;
  String secondAddonName = itemToEdit.secondAddonName;
  int weightId = itemToEdit.weightId,
      firstAddId = itemToEdit.firstAddId,
      secondAddId = itemToEdit.secondAddId;
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
      builder: (builder) {
        return StatefulBuilder(
          builder: (context, setBottomSheetState) {
            //restaurantItemsProvider
            final restaurantItemsProvider =
                Provider.of<ResturantItemsProvider>(context, listen: true);
            if (!restaurantItemsProvider.isLoading) {
              //main product price
              if (price == 0.0) {
                price = restaurantItemsProvider
                    .resturantProductModel.product.price
                    .toDouble();
              }
              //weight selections
              buttonsListWeight =
                  restaurantItemsProvider.resturantProductModel.sizes != null
                      ? restaurantItemsProvider.resturantProductModel.sizes
                      : [];
              isSelectedWeight =
                  restaurantItemsProvider.resturantProductModel.sizes != null
                      ? List.generate(
                          restaurantItemsProvider
                              .resturantProductModel.sizes.length,
                          (_) => false)
                      : List.generate(0, (_) => false);
              //first add selections
              buttonsListFirstAddon = restaurantItemsProvider
                          .resturantProductModel.firstAdditionsData !=
                      null
                  ? restaurantItemsProvider
                      .resturantProductModel.firstAdditionsData
                  : [];
              isSelectedFirstAddon = restaurantItemsProvider
                          .resturantProductModel.firstAdditionsData !=
                      null
                  ? List.generate(
                      restaurantItemsProvider
                          .resturantProductModel.firstAdditionsData.length,
                      (_) => false)
                  : List.generate(0, (_) => false);
              //second add selections
              buttonsListSeccondAddon = restaurantItemsProvider
                          .resturantProductModel.secondAdditionsData !=
                      null
                  ? restaurantItemsProvider
                      .resturantProductModel.secondAdditionsData
                  : [];
              isSelectedSecondAddon = restaurantItemsProvider
                          .resturantProductModel.secondAdditionsData !=
                      null
                  ? List.generate(
                      restaurantItemsProvider
                          .resturantProductModel.secondAdditionsData.length,
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
                id: restaurantItemsProvider.resturantProductModel.product.id,
                name:
                    restaurantItemsProvider.resturantProductModel.product.title,
                description: restaurantItemsProvider
                    .resturantProductModel.product.shortDescription,
                photoUrl:
                    restaurantItemsProvider.resturantProductModel.product.image,
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
              );
            }
            //UI
            return Container(
              color: Colors.transparent,
              child: Container(
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(
                                  Icons.cancel_outlined,
                                  color: kAppBarColor,
                                  size: getProportionateScreenHeight(25),
                                ),
                              ),
                            ),
                            Container(
                              child: ListTile(
                                //img
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: restaurantItemsProvider
                                                  .resturantProductModel
                                                  .product
                                                  .image ==
                                              null
                                          ? AssetImage('assets/icons/menu.png')
                                          : NetworkImage(
                                              'https://menuegypt.com/order_online/product_images/' +
                                                  restaurantItemsProvider
                                                      .resturantProductModel
                                                      .product
                                                      .image),
                                    ),
                                  ),
                                ),
                                //name , price
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      restaurantItemsProvider
                                              .resturantProductModel
                                              .product
                                              .title +
                                          "    ",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      price.toString() + ' جم',
                                      style: TextStyle(color: kAppBarColor),
                                    )
                                  ],
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //description
                                    Text(
                                      restaurantItemsProvider
                                              .resturantProductModel
                                              .product
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
                                                    13),
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
                                ),
                              ),
                            ),
                            //weight
                            buttonsListWeight.isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'مقاسات',
                                      style: TextStyle(color: Colors.black),
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
                                              0.15,
                                      color: Colors.white,
                                      child: GridView.count(
                                        physics: NeverScrollableScrollPhysics(),
                                        primary: true,
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 5,
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
                                                            .price
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
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color: kAppBarColor),
                                                ),
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(
                                                        buttonsListWeight[index]
                                                            .title,
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
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      restaurantItemsProvider
                                          .resturantProductModel
                                          .firstAdditionTitle,
                                      style: TextStyle(color: Colors.black),
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
                                              0.15,
                                      color: Colors.white,
                                      child: GridView.count(
                                        physics: NeverScrollableScrollPhysics(),
                                        primary: true,
                                        crossAxisCount: 2,
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
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color: kAppBarColor),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    buttonsListFirstAddon[index]
                                                        .title,
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
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      restaurantItemsProvider
                                          .resturantProductModel
                                          .secondAdditionTitle,
                                      style: TextStyle(color: Colors.black),
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
                                              0.15,
                                      color: Colors.white,
                                      child: GridView.count(
                                        physics: NeverScrollableScrollPhysics(),
                                        primary: true,
                                        crossAxisCount: 2,
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
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color: kAppBarColor),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    buttonsListSeccondAddon[
                                                            index]
                                                        .title,
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
                                    (price * quantity).toString() + ' جم',
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
                                      .editCartItem(cartItem, itemIndex);
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
              ),
            );
          },
        );
      });
}
