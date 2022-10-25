import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/providers/restaurants_provider.dart';

import 'package:flutter_typeahead/flutter_typeahead.dart';

class SearchTestBar extends StatelessWidget {
  const SearchTestBar({Key key, @required this.restaurantProvider})
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
        height: 36.0,
        child: TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
              autofocus: true,
              style: DefaultTextStyle.of(context)
                  .style
                  .copyWith(fontStyle: FontStyle.italic),
              decoration: InputDecoration(border: OutlineInputBorder())),
          suggestionsCallback: (pattern) async {
            return getSuggestions(pattern);
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              title: Text(suggestion),
            );
          },
          onSuggestionSelected: (suggestion) {
            print('hi');
          },
        ));
  }
}
