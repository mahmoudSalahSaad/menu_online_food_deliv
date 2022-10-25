import 'package:flutter/material.dart';
import 'package:menu_egypt/models/Comment.dart';
import 'package:menu_egypt/utilities/size_config.dart';

import '../../../../utilities/constants.dart';

class CommentsWidget extends StatelessWidget {
  const CommentsWidget({
    Key key,
    @required this.comments,
  }) : super(key: key);

  final List<Comment> comments;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, index) {
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: getProportionateScreenHeight(30),
                  height: getProportionateScreenHeight(40),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: kPrimaryColor),
                  child: Icon(Icons.person),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(5),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(comments[index].name),
                      SizedBox(height: getProportionateScreenHeight(5)),
                      Wrap(
                        children: List.generate(
                            comments[index].review,
                            (index) => Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                )),
                      ),
                      SizedBox(height: getProportionateScreenHeight(5)),
                      Text(comments[index].comment),
                    ],
                  ),
                ),
                Text(comments[index].date)
              ],
            ),
            Divider(
              color: Colors.white,
            )
          ],
        );
      }, childCount: comments.length),
    );
  }
}
