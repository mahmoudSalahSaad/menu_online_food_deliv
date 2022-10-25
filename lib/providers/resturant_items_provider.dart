import 'package:flutter/material.dart';
import 'package:menu_egypt/models/cart_item.dart';
import 'package:menu_egypt/models/resturant_item.dart';

class ResturantItemsProvider extends ChangeNotifier {
  bool isLoading = false;
  List<ResturantItemModel> _resturantItems;

  List<ResturantItemModel> get resturantItems {
    return _resturantItems;
  }

  initResturantItems() {
    List<ResturantItemModel> resturantItems = [
      ResturantItemModel(
        categoryId: 1,
        categoryName: 'الأطباق',
        items: [
          CartItemModel(
            id: 1,
            price: 50.0,
            name: 'ريزو باربكيو',
            description: "ارز بسمتى + صدور دجاج",
          ),
          CartItemModel(
            id: 2,
            price: 100.0,
            name: 'فتة شاورما',
            description: "ارز بسمتى + شاورما ",
          ),
          CartItemModel(
            id: 3,
            price: 50.0,
            name: 'ريزو باربكيو',
            description: "ارز بسمتى + صدور دجاج",
          ),
          CartItemModel(
            id: 4,
            price: 100.0,
            name: 'فتة شاورما',
            description: "ارز بسمتى + شاورما ",
          ),
        ],
      ),
      ResturantItemModel(
        categoryId: 2,
        categoryName: 'الوجبات',
        items: [
          CartItemModel(
            id: 5,
            price: 50.0,
            name: 'وجبة دجاج',
            description: "ارز بسمتى + دجاج مقلى",
          ),
          CartItemModel(
            id: 6,
            price: 100.0,
            name: 'وجبة كفتة',
            description: "ارز بسمتى + كفتة",
          ),
          CartItemModel(
            id: 7,
            price: 50.0,
            name: 'وجبة دجاج',
            description: "ارز بسمتى + دجاج مقلى",
          ),
          CartItemModel(
            id: 8,
            price: 100.0,
            name: 'وجبة كفتة',
            description: "ارز بسمتى + كفتة",
          ),
        ],
      ),
      ResturantItemModel(
        categoryId: 3,
        categoryName: 'سندوتشات',
        items: [
          CartItemModel(
            id: 9,
            price: 50.0,
            name: 'شاورما فراخ',
            description: "سندوتش + صدور دجاج",
          ),
          CartItemModel(
            id: 10,
            price: 100.0,
            name: 'شاورما لحمة',
            description: "سندوتش  + لحم مشوى",
          ),
          CartItemModel(
            id: 11,
            price: 50.0,
            name: 'شاورما فراخ',
            description: "سندوتش + صدور دجاج",
          ),
          CartItemModel(
            id: 12,
            price: 100.0,
            name: 'شاورما لحمة',
            description: "سندوتش  + لحم مشوى",
          ),
        ],
      ),
      ResturantItemModel(
        categoryId: 4,
        categoryName: 'بيتزا',
        items: [
          CartItemModel(
            id: 13,
            price: 50.0,
            name: 'بيتزا جبن',
            description: "موتزريلا + رانش صوص",
          ),
          CartItemModel(
            id: 14,
            price: 100.0,
            name: 'بيتزا سيفود',
            description: "جمبرى + تونة",
          ),
          CartItemModel(
            id: 15,
            price: 50.0,
            name: 'بيتزا جبن',
            description: "موتزريلا + رانش صوص",
          ),
          CartItemModel(
            id: 16,
            price: 100.0,
            name: 'بيتزا سيفود',
            description: "جمبرى + تونة",
          ),
        ],
      ),
      ResturantItemModel(
        categoryId: 5,
        categoryName: 'فطائر',
        items: [
          CartItemModel(
            id: 17,
            price: 50.0,
            name: 'فطيرة جبن',
            description: "شيدر + رومى",
          ),
          CartItemModel(
            id: 18,
            price: 100.0,
            name: 'فطيرة سدق',
            description: "سدق + كاتشب",
          ),
          CartItemModel(
            id: 19,
            price: 50.0,
            name: 'فطيرة جبن',
            description: "شيدر + رومى",
          ),
          CartItemModel(
            id: 20,
            price: 100.0,
            name: 'فطيرة سدق',
            description: "سدق + كاتشب",
          ),
          CartItemModel(
            id: 21,
            price: 50.0,
            name: 'فطيرة جبن',
            description: "شيدر + رومى",
          ),
          CartItemModel(
            id: 22,
            price: 100.0,
            name: 'فطيرة سدق',
            description: "سدق + كاتشب",
          ),
          CartItemModel(
            id: 23,
            price: 50.0,
            name: 'فطيرة جبن',
            description: "شيدر + رومى",
          ),
          CartItemModel(
            id: 24,
            price: 100.0,
            name: 'فطيرة سدق',
            description: "سدق + كاتشب",
          ),
        ],
      ),
    ];

    _resturantItems = resturantItems;
  }

  startLoading() {
    isLoading = true;
    notifyListeners();
  }

  endLoading() {
    isLoading = false;
    notifyListeners();
  }
}
