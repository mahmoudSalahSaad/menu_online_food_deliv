import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/providers/restaurants_provider.dart';
import 'package:menu_egypt/screens/new_restaurant_screen/new_restaurant_screen.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';

class SearchWidgetBar extends StatelessWidget {
  const SearchWidgetBar({Key? key,  this.restaurantProvider})
      : super(key: key);

  final RestaurantsProvider? restaurantProvider;

  List<String> getSuggestions(String query) {
    List<String> matches = [];
    restaurantProvider!.restaurants.forEach((restaurant) {
      if (query != "") {
        String resturantEn =
            restaurant.nameEn!.toLowerCase().removeAllWhitespace;

        if (resturantEn.contains(query.toLowerCase().removeAllWhitespace)) {
          matches.add(restaurant.nameEn!);
        } else if (restaurant.nameAr!.removeAllWhitespace
            .contains(query.removeAllWhitespace)) {
          matches.add(restaurant.nameAr!);
        }
      }
    });
    return matches;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(48),
      child: TypeAheadField(
        suggestionsBoxController: SuggestionsBoxController(),
        hideOnLoading: false,
        hideOnEmpty: false,
        hideSuggestionsOnKeyboardHide: false,
        keepSuggestionsOnSuggestionSelected: false,
        textFieldConfiguration: TextFieldConfiguration(
          autofocus: false,
          style: DefaultTextStyle.of(context).style.copyWith(color: Colors.black , fontSize: 20 , height: 2.0),
          decoration: InputDecoration(
            fillColor: Color(0xffF7F7F9),
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kDefaultPadding / 1.5),
              borderSide: BorderSide(color: Color(0xffE4E4E5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kDefaultPadding / 1.5),
              borderSide: BorderSide(color: Color(0xffE4E4E5
              )),
            ),
            hintText: "ابحث باسم المطعم",
            hintStyle: TextStyle(
              color: Color(0xff7D848D) ,
              fontSize: 16 ,
              height: 2.0
            ),
            prefixIcon: Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/icons/Search.png") , scale: 3.2)
              ),
              height: 1,
              width: 1,

            ),
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kDefaultPadding / 1.5),
              borderSide: BorderSide(color: Color(0xffE4E4E5
              )),
            ),
            // contentPadding: const EdgeInsets.only(
            //   top: 20,
            //   bottom: 14,
            //   left: 16,
            //   right: 20,
            // ),
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
          int index = restaurantProvider!.restaurants.indexWhere(
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
              restaurantProvider!.restaurants[index].id.toString());
          Provider.of<RestaurantsProvider>(context, listen: false)
              .fetchRestaurant(restaurantProvider!.restaurants[index].id!);
          Get.toNamed(NewRestaurantScreen.routeName);
        },
      ),
    );
  }
}
