import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:menu_egypt/models/resturan_categories_and_products.dart';
import 'package:menu_egypt/providers/cart_provider.dart';
import 'package:menu_egypt/providers/resturant_items_provider.dart';
import 'package:menu_egypt/screens/new_restaurant_screen/add_to_cart_widget.dart';
import 'package:menu_egypt/screens/new_restaurant_screen/components/branches_tab_widget.dart';
import 'package:menu_egypt/screens/new_restaurant_screen/components/comments_tab_widget.dart';
import 'package:menu_egypt/screens/new_restaurant_screen/components/menu_tab_widget.dart';
import 'package:menu_egypt/screens/new_restaurant_screen/components/menu_tap/image_slider_dialog.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_list_tabview/scrollable_list_tabview.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  ResturantCategoriesAndProducts resturantCategoriesAndProducts;
  ResturantItemsProvider resturantItemsProvider;

  @override
  void initState() {
    resturantItemsProvider =
        Provider.of<ResturantItemsProvider>(context, listen: false);

    resturantCategoriesAndProducts =
        resturantItemsProvider.resturantCategoriesAndProducts;

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

    tabsWidget = [
      MenuTabWidget(
        date: restaurant.date,
        isOnline: restaurant.isOnline,
        isOutOfTime: restaurant.isOutOfTime,
        restId: restaurant.id,
        images: images,
        sliderImages: Provider.of<RestaurantsProvider>(context, listen: false)
            .sliderimages,
        sliderImagesLink:
            Provider.of<RestaurantsProvider>(context, listen: false)
                .sliderImagesLink,
      ),
      CommentsTabWidget(
        id: restaurant.id,
      ),
      BranchesTabWidget(resturant: restaurant, areas: areas)
    ];
    return SafeArea(
      child: resturantCategoriesAndProducts != null
          ? Column(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(2),
                ),
                TopHeaderWidget(
                  restId: restaurant.id,
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
                  pathFrom: 'products',
                ),
                Expanded(
                  child: ScrollableListTabView(
                    tabHeight: getProportionateScreenHeight(40),
                    bodyAnimationDuration: const Duration(milliseconds: 500),
                    tabAnimationCurve: Curves.easeOut,
                    tabAnimationDuration: const Duration(milliseconds: 500),
                    tabs: restruantItemsTaps(
                        resturantCategoriesAndProducts.resturantData),
                  ),
                ),
              ],
            )
          : Center(
              child: Text(
                  'عفوا هذا المطعم غير متوفر الآن لتلقي الطلب عبر الإنترنت'),
            ),
    );
  }

  //resturant items ScrollableListTab
  List<ScrollableListTab> restruantItemsTaps(ResturantData resturantData) {
    List<ScrollableListTab> taps = [];
    for (int i = 0; i < resturantData.catgeoriesList.length; i++) {
      if (resturantData.catgeoriesList[i].catgeoryProducts.isEmpty) {
        continue;
      }
      taps.add(
        ScrollableListTab(
          tab: ListTab(
            label: Text(
              resturantData.catgeoriesList[i].catgeoryTitle,
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
              print(resturantData
                  .catgeoriesList[i].catgeoryProducts[index].product.image);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: InstaImageViewer(
                              child: Image(
                                image: resturantData
                                            .catgeoriesList[i]
                                            .catgeoryProducts[index]
                                            .product
                                            .image ==
                                        null
                                    ? AssetImage('assets/icons/menu.png')
                                    : Image.network(
                                            'https://menuegypt.com/order_online/product_images/' +
                                                resturantData
                                                    .catgeoriesList[i]
                                                    .catgeoryProducts[index]
                                                    .product
                                                    .image)
                                        .image,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          flex: 8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    resturantData.catgeoriesList[i]
                                        .catgeoryProducts[index].product.title,
                                    style: TextStyle(
                                        height: 1.2,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: resturantData
                                                        .catgeoriesList[i]
                                                        .catgeoryProducts[index]
                                                        .product
                                                        .price !=
                                                    0
                                                ? resturantData
                                                    .catgeoriesList[i]
                                                    .catgeoryProducts[index]
                                                    .product
                                                    .price
                                                    .toStringAsFixed(2)
                                                : resturantData
                                                        .catgeoriesList[i]
                                                        .catgeoryProducts[index]
                                                        .product
                                                        .min
                                                        .toStringAsFixed(2) +
                                                    ' - ' +
                                                    resturantData
                                                        .catgeoriesList[i]
                                                        .catgeoryProducts[index]
                                                        .product
                                                        .max
                                                        .toStringAsFixed(2),
                                            style: TextStyle(
                                                height: 1.2,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    getProportionateScreenHeight(
                                                        12))),
                                        TextSpan(
                                          text: ' جم',
                                          style: TextStyle(
                                              height: 1.2,
                                              fontFamily: 'DroidArabic'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: Text(
                                      resturantData
                                              .catgeoriesList[i]
                                              .catgeoryProducts[index]
                                              .product
                                              .shortDescription ??
                                          '',
                                      style: TextStyle(color: Colors.grey[300]),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: IconButton(
                                      onPressed: () {
                                        print(resturantData.restId);
                                        print(Provider.of<CartProvider>(context,
                                                listen: false)
                                            .cart
                                            .resturantId);
                                        if (resturantData.restId ==
                                                Provider.of<CartProvider>(
                                                        context,
                                                        listen: false)
                                                    .cart
                                                    .resturantId ||
                                            Provider.of<CartProvider>(context,
                                                        listen: false)
                                                    .cart
                                                    .resturantId ==
                                                0) {
                                          /*
                                                                  resturantItemsProvider.getResturantProduct(
                                    resturantData.catgeoriesList[i]
                                        .catgeoryProducts[index].id);
                                                                  */
                                          addToCartBottomSheet(
                                              context,
                                              restaurant.nameAr,
                                              restaurant.logoSmall,
                                              resturantData.catgeoriesList[i]
                                                  .catgeoryProducts[index]);
                                        } else {
                                          deleteDialog(context);
                                        }
                                      },
                                      icon: Icon(Icons.add_box_outlined),
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    print(resturantData.restId);
                    print(Provider.of<CartProvider>(context, listen: false)
                        .cart
                        .resturantId);
                    if (resturantData.restId ==
                            Provider.of<CartProvider>(context, listen: false)
                                .cart
                                .resturantId ||
                        Provider.of<CartProvider>(context, listen: false)
                                .cart
                                .resturantId ==
                            0) {
                      /*
                      resturantItemsProvider.getResturantProduct(
                          resturantData
                              .catgeoriesList[i].catgeoryProducts[index].id);
                      */
                      addToCartBottomSheet(
                          context,
                          restaurant.nameAr,
                          restaurant.logoSmall,
                          resturantData
                              .catgeoriesList[i].catgeoryProducts[index]);
                    } else {
                      deleteDialog(context);
                    }
                  },
                ),
              );
            },
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                height: getProportionateScreenHeight(1),
                color: Colors.white,
              ),
            ),
            itemCount: resturantData.catgeoriesList[i].catgeoryProducts.length,
          ),
        ),
      );
    }
    return taps;
  }

  void favFunction(UserProvider userProvider) async {
    if (!userProvider.isLoading) {
      if (isFav) {
        if (userProvider.user.favorites.contains(restaurant.id)) {
          var result = await userProvider.removeFavorite(restaurant.id);
          if (result['success']) {
            userProvider.user.favorites.remove(restaurant.id);
            List<String> favList =
                userProvider.user.favorites.map((i) => i.toString()).toList();
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setStringList("favList", favList);
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
            List<String> favList =
                userProvider.user.favorites.map((i) => i.toString()).toList();
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setStringList("favList", favList);
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
        title: 'تنبيه',
        buttonColor: kPrimaryColor,
        cancelTextColor: kTextColor);
  }

  void deleteDialog(BuildContext context) {
    Get.defaultDialog(
      content: Text('هل تريد حذف السلة؟'),
      textConfirm: 'حذف',
      title: 'لديك طلب من مطعم اخر',
      buttonColor: Colors.red,
      onConfirm: () async {
        Get.back();
        Provider.of<CartProvider>(context, listen: false).clearCart();
      },
      confirmTextColor: kTextColor,
      onCancel: () async {},
      textCancel: 'رجوع',
      cancelTextColor: kTextColor,
    );
  }

  void imageDialog(List<String> menus, index, context) {
    showGeneralDialog(
        context: context, // background color
        barrierDismissible: false,
        transitionDuration: Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) {
          // your widget implementation
          return ImageDialog(images: menus, index: index);
        });
  }
}

/*

ListTile(
                  leading: Container(
                    height: 70,
                    width: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: resturantData.catgeoriesList[i]
                                    .catgeoryProducts[index].product.image ==
                                null
                            ? AssetImage('assets/icons/menu.png')
                            : NetworkImage(
                                'https://menuegypt.com/order_online/product_images/' +
                                    resturantData.catgeoriesList[i]
                                        .catgeoryProducts[index].product.image),
                      ),
                    ),
                    child: InstaImageViewer(
                      child: Image(
                        image: resturantData.catgeoriesList[i]
                                    .catgeoryProducts[index].product.image ==
                                null
                            ? AssetImage('assets/icons/menu.png')
                            : Image.network(
                                    'https://menuegypt.com/order_online/product_images/' +
                                        resturantData
                                            .catgeoriesList[i]
                                            .catgeoryProducts[index]
                                            .product
                                            .image)
                                .image,
                      ),
                    ),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        resturantData.catgeoriesList[i].catgeoryProducts[index]
                            .product.title,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: resturantData
                                            .catgeoriesList[i]
                                            .catgeoryProducts[index]
                                            .product
                                            .price !=
                                        0
                                    ? resturantData.catgeoriesList[i]
                                        .catgeoryProducts[index].product.price
                                        .toString()
                                    : resturantData.catgeoriesList[i]
                                            .catgeoryProducts[index].product.min
                                            .toString() +
                                        ' - ' +
                                        resturantData.catgeoriesList[i]
                                            .catgeoryProducts[index].product.max
                                            .toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        getProportionateScreenHeight(12))),
                            TextSpan(
                              text: ' جم',
                              style: TextStyle(fontFamily: 'DroidArabic'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 8,
                        child: Text(
                          resturantData
                                  .catgeoriesList[i]
                                  .catgeoryProducts[index]
                                  .product
                                  .shortDescription ??
                              '',
                          style: TextStyle(color: Colors.grey[300]),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: IconButton(
                          onPressed: () {
                            print(resturantData.restId);
                            print(Provider.of<CartProvider>(context,
                                    listen: false)
                                .cart
                                .resturantId);
                            if (resturantData.restId ==
                                    Provider.of<CartProvider>(context,
                                            listen: false)
                                        .cart
                                        .resturantId ||
                                Provider.of<CartProvider>(context,
                                            listen: false)
                                        .cart
                                        .resturantId ==
                                    0) {
                              /*
                              resturantItemsProvider.getResturantProduct(
                                  resturantData.catgeoriesList[i]
                                      .catgeoryProducts[index].id);
                              */
                              addToCartBottomSheet(
                                  context,
                                  restaurant.nameAr,
                                  restaurant.logoSmall,
                                  resturantData.catgeoriesList[i]
                                      .catgeoryProducts[index]);
                            } else {
                              deleteDialog(context);
                            }
                          },
                          icon: Icon(Icons.add_box_outlined),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
 */