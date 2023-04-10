import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../../../../models/Restaurant.dart';

class BranchesWidget extends StatelessWidget {
  const BranchesWidget({
    Key? key,
    this.resturant,
  }) : super(key: key);

  final RestaurantModel? resturant;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, index) {
        return resturant!.branches!.length > 0
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  resturant!.branches![index]['name'] != null
                      ? Text(
                          '${resturant!.branches![index]['name']}' , style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold),)
                      : Container(),
                  SizedBox(
                    height: 4,
                  ),
                  resturant!.branches![index]['address'] != null
                      ? Text(
                          '${resturant!.branches![index]['address']}', style: TextStyle(fontSize: 14 ),)
                      : Container(),
                  // resturant.branches[index]['numone'] != null ||
                  //         resturant.branches[index]['numtwo'] != null
                  //     ? Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Row(
                  //             children: [
                  //               resturant.branches[index]['numone'] != null
                  //                   ? GestureDetector(
                  //                       onTap: () async {
                  //                         bool result =
                  //                             await FlutterPhoneDirectCaller
                  //                                 .callNumber(
                  //                                     '${resturant.branches[index]['numone']}');
                  //                         if (result) {
                  //                           print('call');
                  //                         }
                  //                       },
                  //                       child: Text(resturant.branches[index]
                  //                           ['numone']),
                  //                     )
                  //                   : Container(),
                  //               resturant.branches[index]['numtwo'] != null
                  //                   ? GestureDetector(
                  //                       onTap: () async {
                  //                         bool result =
                  //                             await FlutterPhoneDirectCaller
                  //                                 .callNumber(
                  //                                     '${resturant.branches[index]['numtwo']}');
                  //                         if (result) {
                  //                           print('call');
                  //                         }
                  //                       },
                  //                       child: Text(
                  //                           ' - ${resturant.branches[index]['numtwo']}'),
                  //                     )
                  //                   : Container(),
                  //             ],
                  //           ),
                  //
                  //         ],
                  //       )
                  //     : Container()
                ],
              )
            : Center(child: Text('لايوجد فروع'));
      }, childCount: resturant!.branches!.length),
    );
  }
}
