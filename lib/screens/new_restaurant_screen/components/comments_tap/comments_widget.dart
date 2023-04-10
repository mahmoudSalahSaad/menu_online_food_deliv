import 'package:flutter/material.dart';
import 'package:menu_egypt/models/Comment.dart';
import 'package:menu_egypt/utilities/size_config.dart';


class CommentsWidget extends StatelessWidget {
  const CommentsWidget({
    Key? key,
    @required this.comments,
  }) : super(key: key);

  final List<Comment>? comments;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 8),
          padding: EdgeInsets.symmetric(vertical: 12 , horizontal: 8),
          decoration: BoxDecoration(
            color: Color(0xffF7F7F9) ,
            border: Border.all(color: Color(0xffE4E4E5)),
            borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [

                     Container(
                       padding: EdgeInsets.zero,
                       width: getProportionateScreenHeight(38),
                       height: getProportionateScreenHeight(38),
                       decoration: BoxDecoration(
                           shape: BoxShape.circle, color: Color(0xffFFFFFF)),
                       child: Icon(Icons.person , size: 26,),
                     ),
                   ],
                 ) ,
                  SizedBox(
                    width: getProportionateScreenWidth(5),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(comments![index].name! , style: TextStyle(
                          fontWeight: FontWeight.bold ,
                          fontSize: 16
                        ),),
                        SizedBox(height: getProportionateScreenHeight(0)),
                        Wrap(
                          children: List.generate(
                              comments![index].review!,
                                  (index) => Icon(
                                Icons.star,
                                color: Color(0xffFFC107),
                                size: 18,
                              )),
                        ),
                        SizedBox(height: getProportionateScreenHeight(5)),
                        Text(comments![index].comment!),
                      ],
                    ),
                  ),
                  Text(comments![index].date!)
                ],
              ),

            ],
          ),
        );
      }, childCount: comments!.length),
    );
  }
}
