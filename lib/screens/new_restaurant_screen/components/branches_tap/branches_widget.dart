import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../../../../models/Restaurant.dart';

class BranchesWidget extends StatelessWidget {
  const BranchesWidget({
    Key key,
    @required this.resturant,
  }) : super(key: key);

  final RestaurantModel resturant;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, index) {
        return resturant.branches.length > 0
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  resturant.branches[index]['name'] != null
                      ? Text(
                          'اسم الفرع :  ${resturant.branches[index]['name']}')
                      : Container(),
                  resturant.branches[index]['address'] != null
                      ? Text(
                          'عنوان الفرع :  ${resturant.branches[index]['address']}')
                      : Container(),
                  resturant.branches[index]['numone'] != null ||
                          resturant.branches[index]['numtwo'] != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('أرقام التليفون : '),
                            Row(
                              children: [
                                resturant.branches[index]['numone'] != null
                                    ? GestureDetector(
                                        onTap: () async {
                                          bool result =
                                              await FlutterPhoneDirectCaller
                                                  .callNumber(
                                                      '${resturant.branches[index]['numtwo']}');
                                          if (result) {
                                            print('call');
                                          }
                                        },
                                        child: Text(resturant.branches[index]
                                            ['numone']),
                                      )
                                    : Container(),
                                resturant.branches[index]['numtwo'] != null
                                    ? GestureDetector(
                                        onTap: () async {
                                          bool result =
                                              await FlutterPhoneDirectCaller
                                                  .callNumber(
                                                      '${resturant.branches[index]['numtwo']}');
                                          if (result) {
                                            print('call');
                                          }
                                        },
                                        child: Text(
                                            ' - ${resturant.branches[index]['numtwo']}'),
                                      )
                                    : Container(),
                              ],
                            ),
                            Divider()
                          ],
                        )
                      : Container()
                ],
              )
            : Center(child: Text('لايوجد فروع'));
      }, childCount: resturant.branches.length),
    );
  }
}
