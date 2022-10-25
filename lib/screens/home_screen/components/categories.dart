import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/models/Category.dart';
import 'package:menu_egypt/providers/restaurants_provider.dart';
import 'package:menu_egypt/screens/category_screen/category_screen.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';

class Categories extends StatelessWidget {
  const Categories({
    Key key,
    @required this.categories,
  }) : super(key: key);

  final List<CategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((BuildContext context, index) {
        final CategoryModel category = categories[index];
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {
                  Provider.of<RestaurantsProvider>(context, listen: false)
                      .categoryRestaurantsFilter(category.id);
                  Get.toNamed(CategoryScreen.routeName);
                },
                child: Stack(
                  children: [
                    Container(
                      width: (SizeConfig.screenWidth - kDefaultPadding * 4) / 2,
                      height: 300.0,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(kDefaultPadding),
                          child: FadeInImage.assetNetwork(
                              fit: BoxFit.cover,
                              placeholder: "assets/images/01-Splash-Screen.png",
                              image: '${category.image}')),
                    ),
                    Positioned(
                        bottom: 5.0,
                        right: 10.0,
                        child: Text(
                          category.nameAr,
                        ))
                  ],
                ))
          ],
        );
      }, childCount: categories.length),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.8,
          crossAxisCount: 2,
          crossAxisSpacing: kDefaultPadding / 2,
          mainAxisSpacing: kDefaultPadding / 2),
    );
  }
}
