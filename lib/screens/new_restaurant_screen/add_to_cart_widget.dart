import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/models/cart_item.dart';
import 'package:menu_egypt/providers/cart_provider.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:provider/provider.dart';

void addToCartBottomSheet(BuildContext context, CartItemModel cartItem) {
  cartItem.quantity = 1;
  cartItem.weight = 'نصف كيلو';
  cartItem.firstAddonName = 'اضافة 1';
  cartItem.secondAddonName = 'اضافة 2';
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (builder) {
        return StatefulBuilder(
          builder: (context, setBottomSheetState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.90,
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.10,
                      child: ListTile(
                        leading: SizedBox(
                          width: 50,
                          height: 50,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Image.asset(
                                'assets/images/menuegypt_sandwitches.png'),
                          ),
                        ),
                        title: Row(
                          children: [
                            Text(
                              cartItem.name + "    ",
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              cartItem.price.toString() + ' جم',
                              style: TextStyle(color: kAppBarColor),
                            )
                          ],
                        ),
                        subtitle: Text(
                          cartItem.description,
                          style: TextStyle(color: Colors.black),
                        ),
                        //incr , decr quantity
                        trailing: SizedBox(
                          width: 110.0,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setBottomSheetState(() {
                                    cartItem.quantity++;
                                  });
                                },
                                icon: Icon(Icons.add_circle_outline),
                                color: Colors.red,
                              ),
                              Text(
                                cartItem.quantity.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (cartItem.quantity != 1) {
                                    setBottomSheetState(() {
                                      cartItem.quantity--;
                                    });
                                  }
                                },
                                icon: Icon(Icons.remove_circle_outline),
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //weight
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'الوزن',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: MaterialButton(
                                  onPressed: () {},
                                  color: kAppBarColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: IgnorePointer(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'إضافة كوبون خصم',
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Expanded(
                                child: MaterialButton(
                                  onPressed: () {},
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: kAppBarColor,
                                      width: 1,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: IgnorePointer(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'إضافة كوبون خصم',
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: MaterialButton(
                                  onPressed: () {},
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: kAppBarColor,
                                      width: 1,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: IgnorePointer(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'إضافة كوبون خصم',
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Expanded(
                                child: MaterialButton(
                                    onPressed: () {},
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: kAppBarColor,
                                        width: 1,
                                        style: BorderStyle.solid,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: IgnorePointer(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: 'إضافة كوبون خصم',
                                          hintStyle:
                                              TextStyle(color: Colors.black),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    //first addon
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'الوزن',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: MaterialButton(
                                  onPressed: () {},
                                  color: kAppBarColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: IgnorePointer(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'إضافة كوبون خصم',
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Expanded(
                                child: MaterialButton(
                                  onPressed: () {},
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: kAppBarColor,
                                      width: 1,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: IgnorePointer(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'إضافة كوبون خصم',
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: MaterialButton(
                                  onPressed: () {},
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: kAppBarColor,
                                      width: 1,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: IgnorePointer(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'إضافة كوبون خصم',
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Expanded(
                                child: MaterialButton(
                                    onPressed: () {},
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: kAppBarColor,
                                        width: 1,
                                        style: BorderStyle.solid,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: IgnorePointer(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: 'إضافة كوبون خصم',
                                          hintStyle:
                                              TextStyle(color: Colors.black),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    //second addon
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'الوزن',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: MaterialButton(
                                  onPressed: () {},
                                  color: kAppBarColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: IgnorePointer(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'إضافة كوبون خصم',
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Expanded(
                                child: MaterialButton(
                                  onPressed: () {},
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: kAppBarColor,
                                      width: 1,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: IgnorePointer(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'إضافة كوبون خصم',
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: MaterialButton(
                                  onPressed: () {},
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: kAppBarColor,
                                      width: 1,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: IgnorePointer(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'إضافة كوبون خصم',
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Expanded(
                                child: MaterialButton(
                                    onPressed: () {},
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: kAppBarColor,
                                        width: 1,
                                        style: BorderStyle.solid,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: IgnorePointer(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: 'إضافة كوبون خصم',
                                          hintStyle:
                                              TextStyle(color: Colors.black),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    //total
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'المبلغ الإجمالى',
                            style:
                                TextStyle(color: Colors.black, fontSize: 20.0),
                          ),
                          Text(
                            (cartItem.price * cartItem.quantity).toString() +
                                ' جم',
                            style:
                                TextStyle(color: Colors.black, fontSize: 20.0),
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
                          Provider.of<CartProvider>(context, listen: false)
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
