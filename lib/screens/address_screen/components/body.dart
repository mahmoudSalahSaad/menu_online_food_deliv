import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/components/app_bar.dart';
import 'package:menu_egypt/components/dialog.dart';
import 'package:menu_egypt/components/loading_circle.dart';
import 'package:menu_egypt/models/address.dart';
import 'package:menu_egypt/providers/address_provider.dart';
import 'package:menu_egypt/screens/address_screen/add_new_address.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<AddressModel> addresses = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureProvider<Map<String, dynamic>>(
        initialData: {},
        create: (_) {
          addresses =
              Provider.of<AddressProvider>(context, listen: false).addresses;
          return Provider.of<AddressProvider>(context, listen: true)
              .getAddresses();
        },
        child: Consumer<Map<String, dynamic>>(builder: (_, value, __) {
          if (value.isNotEmpty) {
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
                                      padding: const EdgeInsets.only(left: 16.0 , right: 16.0 , bottom: 8.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: Color(0xffF7F7F9),
                                            border: Border.all(
                                              color: Color(0xffE4E4E5),
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
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
                                                        Image.asset("assets/icons/location.png" ,scale: 3.6,),
                                                        SizedBox(
                                                            width:
                                                                getProportionateScreenWidth(
                                                                    5)),
                                                        Text("${addresses[index]
                                                            .cityName! +
                                                            ',' +
                                                            addresses[index]
                                                                .regionName! +
                                                           ',' +
                                                            addresses[index]
                                                                .neighborhood! }", style: TextStyle(fontSize: 16))
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                         Navigator.push(context, MaterialPageRoute(builder: (_)=> EditMyAddress(
                                                           addressModel: addresses[index],
                                                         ))) ;
                                                        },
                                                        child: Container(
                                                          height: getProportionateScreenHeight(40),
                                                          width: getProportionateScreenHeight(40),
                                                          decoration:
                                                              BoxDecoration(
                                                                color: Colors.white,
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              20))),
                                                          child: Image.asset("assets/icons/edit-2.png" , scale: 4.2,),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            getProportionateScreenWidth(
                                                                10),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          deleteDialog(
                                                              context,
                                                              addresses[index]
                                                                  .id!);
                                                        },
                                                        child: Container(
                                                          height: getProportionateScreenHeight(40),
                                                          width: getProportionateScreenHeight(40),
                                                          decoration:
                                                              BoxDecoration(
                                                                color: Colors.white,
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              20))),
                                                          child: Image.asset("assets/icons/Group 1000000840.png" , scale: 4,),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 6,
                                              ),
                                              Row(
                                                children: [
                                                  Image.asset("assets/icons/Group 1000000831.png" , scale: 3.6,) ,
                                                  SizedBox(
                                                      width:
                                                          getProportionateScreenWidth(
                                                              5)),
                                                  Text(
                                                      'شارع: ${addresses[index].street}', style: TextStyle(fontSize: 16))
                                                ],
                                              ),
                                              SizedBox(
                                                height: 12,
                                              ),
                                              Row(
                                                children: [
                                                  Image.asset("assets/icons/Group 1000000793.png" , scale: 3.6,) ,
                                                  SizedBox(
                                                      width:
                                                          getProportionateScreenWidth(
                                                              5)),
                                                  Text(
                                                      'عمارة: ${addresses[index].building} شقة: ${addresses[index].apartment}' , style: TextStyle(fontSize: 16),)
                                                ],
                                              ),
                                              SizedBox(
                                                height: 12,
                                              ),
                                              addresses[index].description !=
                                                      null
                                                  ? Row(
                                                      children: [
                                                       Image.asset("assets/icons/Group 1000000834.png" ,  scale: 3.6,),
                                                        SizedBox(
                                                            width:
                                                                getProportionateScreenWidth(
                                                                    5)),
                                                        Text(
                                                            'الوصف: ${addresses[index].description}', style: TextStyle(fontSize: 16))
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
                              Navigator.push(context, MaterialPageRoute(builder: (_)=> AddNewAddress())) ;
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
                              Navigator.push(context, MaterialPageRoute(builder: (_)=> AddNewAddress())) ;
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
            return Center(child: LoadingCircle());
          }
        }),
      ),
    );
  }

  void deleteDialog(BuildContext context, int addressId) {
    AppDialog.confirmDialog(
      context: context,
      title: 'حذف العنوان',
      message: 'هل تريد حذف العنوان؟',
      confirmBtnTxt: 'حذف',
      cancelBtnTxt: 'رجوع',
      onConfirm: () async {
        print(addressId);
        Get.back();
        Provider.of<AddressProvider>(context, listen: false)
            .deleteAdress(addressId);
      },
    );
  }
}
