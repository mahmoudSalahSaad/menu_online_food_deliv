import 'package:flutter/cupertino.dart';

class Comment {
  final String email, name, comment, date;
  final int review;
  Comment({
    @required this.email,
    @required this.name,
    @required this.date,
    @required this.comment,
    @required this.review,
  });
}
