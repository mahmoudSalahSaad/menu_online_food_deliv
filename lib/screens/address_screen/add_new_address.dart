import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:menu_egypt/utilities/constants.dart';

void addNewAddressBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (builder) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.60,
        color: Colors.transparent, //could change this to Color(0xFF737373),
        //so you don't have to change MaterialApp canvasColor
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'عنوان جديد',
                  style: TextStyle(
                    color: kAppBarColor,
                    fontSize: 20,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: kAppBarColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        FontAwesomeIcons.house,
                        color: kAppBarColor,
                        size: 15.0,
                      ),
                      hintText: 'المحافظة',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: kAppBarColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        FontAwesomeIcons.house,
                        color: kAppBarColor,
                        size: 15.0,
                      ),
                      hintText: 'الحى',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: kAppBarColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        FontAwesomeIcons.house,
                        color: kAppBarColor,
                        size: 15.0,
                      ),
                      hintText: 'الشارع',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: kAppBarColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        FontAwesomeIcons.house,
                        color: kAppBarColor,
                        size: 15.0,
                      ),
                      hintText: 'رقم العمارة',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: kAppBarColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        FontAwesomeIcons.house,
                        color: kAppBarColor,
                        size: 15.0,
                      ),
                      hintText: 'رقم الشقة',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: kAppBarColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        FontAwesomeIcons.house,
                        color: kAppBarColor,
                        size: 15.0,
                      ),
                      hintText: 'الوصف التفصيلى',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  minWidth: MediaQuery.of(context).size.width,
                  color: kAppBarColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text('اضف عنوان جديد'),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

void editAddressBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (builder) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.60,
        color: Colors.transparent, //could change this to Color(0xFF737373),
        //so you don't have to change MaterialApp canvasColor
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'تعديل العنوان',
                  style: TextStyle(
                    color: kAppBarColor,
                    fontSize: 20,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: kAppBarColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        FontAwesomeIcons.house,
                        color: kAppBarColor,
                        size: 15.0,
                      ),
                      hintText: 'القاهرة',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: kAppBarColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        FontAwesomeIcons.house,
                        color: kAppBarColor,
                        size: 15.0,
                      ),
                      hintText: 'المعادى',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: kAppBarColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        FontAwesomeIcons.house,
                        color: kAppBarColor,
                        size: 15.0,
                      ),
                      hintText: 'شارع 9',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: kAppBarColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        FontAwesomeIcons.house,
                        color: kAppBarColor,
                        size: 15.0,
                      ),
                      hintText: 'عمارة 12',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: kAppBarColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        FontAwesomeIcons.house,
                        color: kAppBarColor,
                        size: 15.0,
                      ),
                      hintText: 'شقة 8',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: kAppBarColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        FontAwesomeIcons.house,
                        color: kAppBarColor,
                        size: 15.0,
                      ),
                      hintText: 'امام محطة مترو المعادى',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  minWidth: MediaQuery.of(context).size.width,
                  color: kAppBarColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text('تعديل العنوان'),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
