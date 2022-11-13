import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/providers/restaurants_provider.dart';
import 'package:menu_egypt/screens/new_restaurant_screen/new_restaurant_screen.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';

class SearchWidgetBar extends StatelessWidget {
  const SearchWidgetBar({Key key, @required this.restaurantProvider})
      : super(key: key);

  final RestaurantsProvider restaurantProvider;

  List<String> getSuggestions(String query) {
    List<String> matches = [];
    restaurantProvider.restaurants.forEach((restaurant) {
      if (query != "") {
        String resturantEn =
            restaurant.nameEn.toLowerCase().removeAllWhitespace;

        if (resturantEn.contains(query.toLowerCase().removeAllWhitespace)) {
          matches.add(restaurant.nameEn);
        } else if (restaurant.nameAr.removeAllWhitespace
            .contains(query.removeAllWhitespace)) {
          matches.add(restaurant.nameAr);
        }
      }
    });
    return matches;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(36),
      child: TypeAheadField(
        suggestionsBoxController: SuggestionsBoxController(),
        hideOnLoading: false,
        hideOnEmpty: false,
        hideSuggestionsOnKeyboardHide: false,
        keepSuggestionsOnSuggestionSelected: false,
        textFieldConfiguration: TextFieldConfiguration(
          autofocus: false,
          style: DefaultTextStyle.of(context).style.copyWith(color: kTextColor),
          decoration: InputDecoration(
            fillColor: Colors.white.withOpacity(0.25),
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kDefaultPadding / 1.5),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.25)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kDefaultPadding / 1.5),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.25)),
            ),
            hintText: "ابحث هنا...",
            prefixIcon: Icon(
              Icons.search,
              color: kTextColor,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(
              left: 16,
              right: 20,
            ),
          ),
        ),
        suggestionsCallback: (pattern) async {
          return getSuggestions(pattern);
        },
        itemBuilder: (context, suggestion) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(suggestion),
          );
        },
        onSuggestionSelected: (suggestion) async {
          int index = restaurantProvider.restaurants.indexWhere(
              (res) => (res.nameAr == suggestion || res.nameEn == suggestion));
          // await restaurantProvider
          //     .restaurantImages(restaurantProvider.restaurants[index]);
          // await restaurantProvider
          //     .addOneView(restaurantProvider.restaurants[index].id);
          // if (restaurantProvider.restaurants[index].nameEn == suggestion) {
          //   Get.toNamed(RestaurantScreen.routeName + '/$index/0/1');
          // } else {
          //   Get.toNamed(RestaurantScreen.routeName + '/$index/0/0');
          // }
          print(suggestion +
              ' ' +
              restaurantProvider.restaurants[index].id.toString());
          Provider.of<RestaurantsProvider>(context, listen: false)
              .fetchRestaurant(restaurantProvider.restaurants[index].id);
          Get.toNamed(NewRestaurantScreen.routeName);
        },
      ),
    );
  }
}
