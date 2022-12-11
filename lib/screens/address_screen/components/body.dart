import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:menu_egypt/components/app_bar.dart';
import 'package:menu_egypt/models/address.dart';
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
  List<AddressModel> addresses = [];
  @override
  void initState() {
    addresses = Provider.of<AddressProvider>(context, listen: false).addresses;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureProvider<Map<String, dynamic>>(
        initialData: null,
        create: (_) =>
            Provider.of<AddressProvider>(context, listen: true).getAddresses(),
        child: Consumer<Map<String, dynamic>>(builder: (_, value, __) {
          if (value != null) {
            return addresses.isNotEmpty
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: getProportionateScreenHeight(2),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child:
                              AppBarWidget(title: 'العناوين', withBack: true),
                        ),
                        Container(
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
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.white,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          FontAwesomeIcons
                                                              .house,
                                                          size:
                                                              getProportionateScreenHeight(
                                                                  15),
                                                        ),
                                                        SizedBox(
                                                            width:
                                                                getProportionateScreenWidth(
                                                                    5)),
                                                        Text(addresses[index]
                                                                .cityName +
                                                            ',' +
                                                            addresses[index]
                                                                .regionName)
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          editAddressBottomSheet(
                                                              context,
                                                              addresses[index]);
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              20))),
                                                          child: Icon(
                                                            Icons.edit,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            getProportionateScreenWidth(
                                                                10),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          print(addresses[index]
                                                              .id);
                                                          Provider.of<AddressProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .deleteAdress(
                                                                  addresses[
                                                                          index]
                                                                      .id);
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              20))),
                                                          child: Icon(
                                                            Icons.delete,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    FontAwesomeIcons
                                                        .locationPin,
                                                    size:
                                                        getProportionateScreenHeight(
                                                            10),
                                                  ),
                                                  SizedBox(
                                                      width:
                                                          getProportionateScreenWidth(
                                                              5)),
                                                  Text(
                                                      'شارع: ${addresses[index].street}')
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    FontAwesomeIcons
                                                        .locationPin,
                                                    size:
                                                        getProportionateScreenHeight(
                                                            10),
                                                  ),
                                                  SizedBox(
                                                      width:
                                                          getProportionateScreenWidth(
                                                              5)),
                                                  Text(
                                                      'عمارة: ${addresses[index].building} شقة: ${addresses[index].apartment}')
                                                ],
                                              ),
                                              addresses[index].description !=
                                                      null
                                                  ? Row(
                                                      children: [
                                                        Icon(
                                                          FontAwesomeIcons
                                                              .locationPin,
                                                          size:
                                                              getProportionateScreenHeight(
                                                                  10),
                                                        ),
                                                        SizedBox(
                                                            width:
                                                                getProportionateScreenWidth(
                                                                    5)),
                                                        Text(
                                                            'الوصف: ${addresses[index].description}')
                                                      ],
                                                    )
                                                  : SizedBox(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: addresses.length,
                                ),
                        ),
                        //add address
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: MaterialButton(
                            height: getProportionateScreenHeight(50),
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
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text('لا يوجد لديك عناوين'),
                        ),
                        //add address
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: MaterialButton(
                            height: getProportionateScreenHeight(50),
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
                        )
                      ],
                    ),
                  );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}
