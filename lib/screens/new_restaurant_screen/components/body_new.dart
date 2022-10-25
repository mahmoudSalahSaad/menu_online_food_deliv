import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/models/cart_item.dart';
import 'package:menu_egypt/models/resturant_item.dart';
import 'package:menu_egypt/providers/cart_provider.dart';
import 'package:menu_egypt/providers/resturant_items_provider.dart';
import 'package:menu_egypt/screens/new_restaurant_screen/components/branches_tab_widget.dart';
import 'package:menu_egypt/screens/new_restaurant_screen/components/comments_tab_widget.dart';
import 'package:menu_egypt/screens/new_restaurant_screen/components/menu_tab_widget.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_list_tabview/scrollable_list_tabview.dart';
import '../../../models/Restaurant.dart';
import '../../../providers/city_provider.dart';
import '../../../providers/region_provider.dart';
import '../../../providers/restaurants_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../utilities/constants.dart';
import '../../../utilities/size_config.dart';
import 'top_header_widget.dart';

class BodyNew extends StatefulWidget {
  @override
  State<BodyNew> createState() => _BodyState();
}

class _BodyState extends State<BodyNew> with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> images = [];
  bool isFav = false;
  int _currentIndex = 0;
  List<String> tabs = ['القائمة', 'التقييم', 'الفروع'];
  List<Widget> tabsWidget;
  RestaurantModel restaurant;
  List<String> areas = [];

  @override
  void initState() {
    Provider.of<ResturantItemsProvider>(context, listen: false)
        .initResturantItems();
    Provider.of<CartProvider>(context, listen: false);
    final restaurantProvider =
        Provider.of<RestaurantsProvider>(context, listen: false);
    _tabController = TabController(
        length: tabs.length,
        animationDuration: Duration(milliseconds: 10),
        vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
    restaurant = restaurantProvider.restaurant;
    if (Provider.of<UserProvider>(context, listen: false).user != null) {
      if (Provider.of<UserProvider>(context, listen: false)
          .user
          .favorites
          .contains(restaurant.id)) {
        isFav = true;
      }
    }
    if (restaurant.images.length >= 1) {
      images = restaurant.images;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final resturantItems =
        Provider.of<ResturantItemsProvider>(context, listen: false)
            .resturantItems;
    tabsWidget = [
      MenuTabWidget(
        date: restaurant.date,
        images: images,
      ),
      CommentsTabWidget(
        id: restaurant.id,
      ),
      BranchesTabWidget(resturant: restaurant, areas: areas)
    ];
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: getProportionateScreenHeight(2),
          ),
          TopHeaderWidget(
            isFav: isFav,
            onTap: () => favFunction(userProvider),
            image: restaurant.logoSmall,
            name: restaurant.nameAr,
            viewTime: restaurant.viewTimes,
            review: restaurant.review.toString(),
            phone1: restaurant.phoneNumber1,
            phone2: restaurant.phoneNumber2,
            phone3: restaurant.phoneNumber3,
            userProvider: userProvider,
          ),
          Expanded(
            child: ScrollableListTabView(
              tabHeight: 50,
              bodyAnimationDuration: const Duration(milliseconds: 500),
              tabAnimationCurve: Curves.easeOut,
              tabAnimationDuration: const Duration(milliseconds: 500),
              tabs: restruantItemsTaps(resturantItems),
            ),
          ),
        ],
      ),
    );
  }

  //resturant items ScrollableListTab
  List<ScrollableListTab> restruantItemsTaps(
      List<ResturantItemModel> resturantItems) {
    List<ScrollableListTab> taps = [];

    for (int i = 0; i < resturantItems.length; i++) {
      taps.add(
        ScrollableListTab(
          tab: ListTab(
            label: Text(
              resturantItems[i].categoryName,
              locale: const Locale("ar"),
              style: TextStyle(color: Colors.white),
            ),
            showIconOnList: false,
            activeBackgroundColor: kPrimaryColor,
          ),
          body: ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: SizedBox(
                  width: 50,
                  height: 50,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child:
                        Image.asset('assets/images/menuegypt_sandwitches.png'),
                  ),
                ),
                title: Text(
                  resturantItems[i].items[index].name,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  resturantItems[i].items[index].description,
                  style: TextStyle(color: Colors.grey[300]),
                ),
                trailing: Column(
                  children: [
                    Expanded(
                      child: Text(
                        resturantItems[i].items[index].price.toString() + ' جم',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          addToCartBottomSheet(
                              context, resturantItems[i].items[index]);
                        },
                        icon: Icon(Icons.add_circle_outline),
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(
              height: 1,
              color: Colors.white,
            ),
            itemCount: resturantItems[i].items.length,
          ),
        ),
      );
    }
    return taps;
  }

  //addToCartBottomSheet
  void addToCartBottomSheet(BuildContext context, CartItemModel cartItem) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (builder) {
          return new Container(
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
                      trailing: SizedBox(
                        width: 110.0,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.add_circle_outline),
                              color: Colors.red,
                            ),
                            Text(
                              '1',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.remove_circle_outline),
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
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
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'ربع',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      '50 جم',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'تلت',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      '70 جم',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'نص',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      '100 جم',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'كيلو',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      '180 جم',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'إضافة أولى',
                          style: TextStyle(color: Colors.black),
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
                                color: kAppBarColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'ربع',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      '80 جم',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'تلت',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      '120 جم',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'نص',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      '160 جم',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'كيلو',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      '200 جم',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'إضافة ثانية',
                          style: TextStyle(color: Colors.black),
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
                                color: kAppBarColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'ربع',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      '80 جم',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'تلت',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      '120 جم',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'نص',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      '160 جم',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'كيلو',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      '200 جم',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'المبلغ الإجمالى',
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                        ),
                        Text(
                          '200 جم',
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      //add to cart
                      onPressed: () {
                        cartItem.quantity = 2;
                        cartItem.weight = 'نصف كيلو';
                        cartItem.firstAddonName = 'اضافة 1';
                        cartItem.secondAddonName = 'اضافة 2';
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
        });
  }

  void favFunction(UserProvider userProvider) async {
    if (!userProvider.isLoading) {
      if (isFav) {
        if (userProvider.user.favorites.contains(restaurant.id)) {
          var result = await userProvider.removeFavorite(restaurant.id);
          if (result['success']) {
            userProvider.user.favorites.remove(restaurant.id);
            setState(() {
              isFav = !isFav;
            });
          } else {
            dialog('حدث خطأ ما حاول مرة اخرى');
          }
        }
      } else {
        if (!userProvider.user.favorites.contains(restaurant.id)) {
          var result = await userProvider.addFavorite(restaurant.id);
          if (result['success']) {
            userProvider.user.favorites.add(restaurant.id);
            setState(() {
              isFav = !isFav;
            });
          }
        } else {
          dialog('حدث خطأ ما حاول مرة اخرى');
        }
      }
    }
  }

  List<String> filterRestaurantAreas(context, List<int> regionsIds) {
    var cities = Provider.of<CityProvider>(context, listen: false).cities;
    var regions = Provider.of<RegionProvider>(context, listen: false).regions;
    List<String> restaurantAreas = [];
    regions.forEach((region) {
      if (regionsIds.contains(region.regionId)) {
        var city = cities.firstWhere((city) {
          return city.cityId == region.cityId;
        });

        String regionCity = city.nameAr + " - " + region.nameAr;
        restaurantAreas.add(regionCity);
      }
    });
    return restaurantAreas;
  }

  void dialog(String message) {
    Get.defaultDialog(
        content: Text(message),
        textCancel: 'إغلاق',
        title: 'تحذير',
        buttonColor: kPrimaryColor,
        cancelTextColor: kTextColor);
  }
}
