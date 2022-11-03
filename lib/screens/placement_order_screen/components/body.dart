import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:menu_egypt/screens/address_screen/add_new_address.dart';
import 'package:menu_egypt/components/app_bar.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';

enum PaymentMethode { cash, visa }

enum Address { address1, address2, address3 }

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  PaymentMethode _methode = PaymentMethode.cash;
  Address _address = Address.address1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 64.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: getProportionateScreenHeight(2),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: AppBarWidget(title: 'الدفع'),
                  ),
                  //resturant
                  ListTile(
                    leading: SizedBox(
                      width: 50,
                      height: 50,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.asset(
                            'assets/images/menuegypt_sandwitches.png'),
                      ),
                    ),
                    title: Text(
                      "طلبك من مطعم",
                      style: TextStyle(color: Colors.white, fontSize: 10.0),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "الدهان",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.motorcycle,
                              size: 10.0,
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              "التوصيل خلال 60 دقيقة",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 10.0),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  //address
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ExpansionTile(
                              title: Text(
                                'عنوان التوصيل',
                                style: TextStyle(color: Colors.white),
                              ),
                              children: [
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return RadioListTile(
                                      title: Column(
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
                                                    Text('القاهرة , المعادى')
                                                  ],
                                                ),
                                              ),
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
                                                  'شارع 9 المعادى عمارة رقم 12 ')
                                            ],
                                          ),
                                        ],
                                      ),
                                      groupValue: _address,
                                      value: null,
                                      activeColor: Colors.red,
                                      onChanged: (Address value) {
                                        setState(() {
                                          _address = value;
                                        });
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return Container(
                                      height: 2.0,
                                      width: double.infinity,
                                      color: Colors.grey,
                                    );
                                  },
                                  itemCount: 2,
                                ),
                              ],
                            ),
                            MaterialButton(
                              onPressed: () {
                                addNewAddressBottomSheet(context);
                              },
                              minWidth: MediaQuery.of(context).size.width,
                              color: kAppBarColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: Colors.white,
                                  width: 1,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              child: Text('اضف عنوان جديد'),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  //payment
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: RadioListTile(
                                    title: Text('الدفع عند الإستلام'),
                                    groupValue: _methode,
                                    value: PaymentMethode.cash,
                                    activeColor: Colors.red,
                                    onChanged: (PaymentMethode value) {
                                      setState(() {
                                        _methode = value;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(width: 5.0),
                                Expanded(
                                    flex: 1,
                                    child: Icon(FontAwesomeIcons.sackDollar)),
                              ],
                            ),
                            Container(
                              height: 2.0,
                              width: double.infinity,
                              color: Colors.grey,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: IgnorePointer(
                                    child: RadioListTile(
                                      title: Text(
                                        'الدفع بالبطاقة (قريباً)',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      groupValue: _methode,
                                      value: PaymentMethode.visa,
                                      activeColor: Colors.red,
                                      onChanged: (PaymentMethode value) {
                                        setState(() {
                                          _methode = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5.0),
                                Expanded(
                                    flex: 1,
                                    child: Icon(
                                      FontAwesomeIcons.creditCard,
                                      color: Colors.grey,
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  //order
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('تفاصيل الطلب'),
                            ListTile(
                              title: Text(
                                " x1 ريزو باربيكو" + " 1 ك",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                "إضافة 1 + إضافة 2",
                                style: TextStyle(color: Colors.grey[300]),
                              ),
                              trailing: Text(
                                '50.0 جم',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              height: 2.0,
                              width: double.infinity,
                              color: Colors.grey,
                            ),
                            ListTile(
                              title: Text(
                                " x1 ريزو باربيكو" + " 1 ك",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                "إضافة 1 + إضافة 2",
                                style: TextStyle(color: Colors.grey[300]),
                              ),
                              trailing: Text(
                                '50.0 جم',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              height: 2.0,
                              width: double.infinity,
                              color: Colors.grey,
                            ),
                            ListTile(
                              title: Text(
                                " x1 ريزو باربيكو" + " 1 ك",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                "إضافة 1 + إضافة 2",
                                style: TextStyle(color: Colors.grey[300]),
                              ),
                              trailing: Text(
                                '50.0 جم',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              height: 2.0,
                              width: double.infinity,
                              color: Colors.grey,
                            ),
                            ListTile(
                              title: Text(
                                " x1 ريزو باربيكو" + " 1 ك",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                "إضافة 1 + إضافة 2",
                                style: TextStyle(color: Colors.grey[300]),
                              ),
                              trailing: Text(
                                '50.0 جم',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //copon
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: IgnorePointer(
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(FontAwesomeIcons.percent,
                                color: Colors.grey),
                            hintText: 'إضافة كوبون خصم',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  //prices
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('تفاصيل الدفع'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'مجموع الطلب',
                                ),
                                Text(
                                  '200.0 جم',
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'التوصيل',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  '20.0 جم',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'الإجمالى',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '220.0 جم',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: MaterialButton(
              height: 50.0,
              minWidth: MediaQuery.of(context).size.width,
              onPressed: () {},
              color: kAppBarColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '220 جم',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'اطلب الان',
                    style: TextStyle(color: Colors.white),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.black12,
                    child: Text(
                      '2',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
