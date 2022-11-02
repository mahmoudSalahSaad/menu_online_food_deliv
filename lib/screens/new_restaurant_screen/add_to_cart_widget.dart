import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/components/loading_circle.dart';
import 'package:menu_egypt/models/cart_item.dart';
import 'package:menu_egypt/models/resturant_product.dart';
import 'package:menu_egypt/providers/cart_provider.dart';
import 'package:menu_egypt/providers/resturant_items_provider.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:provider/provider.dart';

void addToCartBottomSheet(BuildContext context) {
  CartItemModel cartItem;

  int quantity = 1;
  String weight = 'نصف كيلو';
  String firstAddonName = 'اضافة 1';
  String secondAddonName = 'اضافة 2';
  //selections
  List<bool> isSelectedWeight = List.generate(2, (_) => false);
  List<Sizes> buttonsListWeight = [];
  List<bool> isSelectedFirstAddon = List.generate(2, (_) => false);
  List<FirstAdditionsData> buttonsListFirstAddon = [];
  List<bool> isSelectedSecondAddon = List.generate(2, (_) => false);
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
              //weight selections
              buttonsListWeight =
                  restaurantItemsProvider.resturantProductModel.sizes != null
                      ? restaurantItemsProvider.resturantProductModel.sizes
                      : [];
              //first add selections
              buttonsListFirstAddon = restaurantItemsProvider
                          .resturantProductModel.firstAdditionsData !=
                      null
                  ? restaurantItemsProvider
                      .resturantProductModel.firstAdditionsData
                  : [];
              //second add selections
              buttonsListSeccondAddon = restaurantItemsProvider
                          .resturantProductModel.secondAdditionsData !=
                      null
                  ? restaurantItemsProvider
                      .resturantProductModel.secondAdditionsData
                  : [];

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
                price: restaurantItemsProvider
                    .resturantProductModel.product.price
                    .toDouble(),
                quantity: quantity,
                weight: weight,
                firstAddonName: firstAddonName,
                secondAddonName: secondAddonName,
                firstAddonPrice: 0.0,
                secondAddonPrice: 0.0,
              );
            }
            //UI
            return Container(
              height: MediaQuery.of(context).size.height * 0.90,
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0))),
                child: restaurantItemsProvider.isLoading
                    ? LoadingCircle()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.10,
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
                                    image: NetworkImage(
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
                                    restaurantItemsProvider
                                            .resturantProductModel.product.price
                                            .toString() +
                                        ' جم',
                                    style: TextStyle(color: kAppBarColor),
                                  )
                                ],
                              ),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //description
                                  Text(
                                    restaurantItemsProvider
                                        .resturantProductModel
                                        .product
                                        .shortDescription,
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
                                          fontSize: 13.0,
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
                                        icon: Icon(Icons.remove_circle_outline),
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
                              : Padding(padding: const EdgeInsets.all(0.0)),
                          buttonsListWeight.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.12,
                                    color: Colors.white,
                                    child: GridView.count(
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
                                                child: Text(
                                                  buttonsListWeight[index]
                                                      .title,
                                                  style: TextStyle(
                                                    color:
                                                        isSelectedWeight[index]
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
                              : Padding(padding: const EdgeInsets.all(0.0)),
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
                              : Padding(padding: const EdgeInsets.all(0.0)),
                          buttonsListFirstAddon.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.12,
                                    color: Colors.white,
                                    child: GridView.count(
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
                                                color:
                                                    isSelectedFirstAddon[index]
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
                                                    color: isSelectedFirstAddon[
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
                              : Padding(padding: const EdgeInsets.all(0.0)),
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
                              : Padding(padding: const EdgeInsets.all(0.0)),
                          buttonsListSeccondAddon.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.12,
                                    color: Colors.white,
                                    child: GridView.count(
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
                                                color:
                                                    isSelectedSecondAddon[index]
                                                        ? kAppBarColor
                                                        : Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    color: kAppBarColor),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  buttonsListSeccondAddon[index]
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
                              : Padding(padding: const EdgeInsets.all(0.0)),
                          //total
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'المبلغ الإجمالى',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20.0),
                                ),
                                Text(
                                  (cartItem.price * quantity).toString() +
                                      ' جم',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20.0),
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
                                    .addItemToCart(cartItem);
                                Get.back();
                              },
                              color: kAppBarColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'اضف الى السلة',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            );
          },
        );
      });
}
