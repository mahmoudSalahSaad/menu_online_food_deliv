import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:menu_egypt/components/app_bar.dart';
import 'package:menu_egypt/providers/address_provider.dart';
import 'package:menu_egypt/screens/address_screen/add_new_address.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final addresses =
        Provider.of<AddressProvider>(context, listen: false).addresses;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(2),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AppBarWidget(title: 'العناوين'),
            ),
            Consumer<AddressProvider>(
              builder: (context, value, child) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.70,
                  child: addresses.isEmpty
                      ? Center(
                          child: Text('لا يوجد لديك عناوين'),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Row(
                                              children: [
                                                Icon(
                                                  FontAwesomeIcons.house,
                                                  size: 10.0,
                                                ),
                                                SizedBox(width: 5.0),
                                                Text(addresses[index].cityName +
                                                    ',' +
                                                    addresses[index].regionName)
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              editAddressBottomSheet(
                                                  context, addresses[index]);
                                            },
                                            child: Text(
                                              'تعديل العنوان',
                                              style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              print(addresses[index].id);
                                              Provider.of<AddressProvider>(
                                                      context,
                                                      listen: false)
                                                  .deleteAdress(
                                                      addresses[index].id);
                                            },
                                            child: Text(
                                              'حذف العنوان',
                                              style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.locationPin,
                                            size: 10.0,
                                          ),
                                          SizedBox(width: 5.0),
                                          Text(
                                              'شارع ${addresses[index].street} عمارة رقم ${addresses[index].building} شقة رقم ${addresses[index].apartment}')
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: addresses.length,
                        ),
                );
              },
            ),
            //add address
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MaterialButton(
                height: 50.0,
                minWidth: MediaQuery.of(context).size.width,
                onPressed: () {
                  addNewAddressBottomSheet(context);
                },
                color: kAppBarColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'إضافة عنوان جديد',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
