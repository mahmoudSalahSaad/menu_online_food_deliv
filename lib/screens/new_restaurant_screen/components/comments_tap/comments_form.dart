import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../components/input_text_field.dart';
import '../../../../utilities/constants.dart';
import '../../../../utilities/size_config.dart';

class CommentsForm extends StatefulWidget {
  const CommentsForm({
    Key? key,
    this.formKey,
     this.formData,
  }) : super(key: key);
  final GlobalKey? formKey;

  final formData;
  @override
  State<CommentsForm> createState() => _CommentsFormState();
}

class _CommentsFormState extends State<CommentsForm> {
  final List<String> errors = [];
  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error!);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InputTextField(
              readOnly: true,
              intialValue: widget.formData['name'],
              textInputType: TextInputType.text,
              iconPath: "assets/icons/Group 1000000781.png",
              labelText: "الاسم",
              border: false,
              onSaved: (String newValue) => widget.formData['name'] = newValue,
              onChanged: (String value) {
                if (value.isNotEmpty) {
                  removeError(error: kNameNullError);
                }
                return null;
              },
              validator: (String value) {
                if (value.isEmpty) {
                  addError(error: kNameNullError);
                  return "";
                }
                return null;
              },
            ),
            SizedBox(
              height: getProportionateScreenHeight(5),
            ),
            InputTextField(
              readOnly: true,
              iconPath: "assets/icons/mail.png",
              intialValue: widget.formData['email'],
              textInputType: TextInputType.emailAddress,
              labelText: "البريد إلالكترونى",
              border: false,
              onSaved: (String newValue) => widget.formData['email'] = newValue,
              onChanged: (String value) {
                if (value.isNotEmpty) {
                  removeError(error: kEmailNullError);
                  if (emailValidatorRegExp.hasMatch(value)) {
                    removeError(error: kInvalidEmailError);
                  }
                }
                return null;
              },
              validator: (String value) {
                if (value.isEmpty) {
                  addError(error: kEmailNullError);
                  return "";
                } else if (!emailValidatorRegExp.hasMatch(value)) {
                  addError(error: kInvalidEmailError);
                  return "";
                }
                return null;
              },
            ),
            SizedBox(
              height: getProportionateScreenHeight(5),
            ),
            TextField(
              minLines: 3,
              maxLines: 3,
              decoration: InputDecoration(
                focusColor: Colors.white,
                hintStyle: TextStyle(color: Colors.black),
                  fillColor: Color(0xffF7F7F9),
                filled: true,
                hintText: "التعليق",
                  contentPadding: EdgeInsets.symmetric(horizontal: 10 , vertical: 8),
                  enabledBorder:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                      borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)) ,
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                      borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),

                  focusedBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                      borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(getProportionateScreenHeight(12)),
                      borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1))
              ),
              onChanged: (String value) {
                widget.formData['comment'] = value;
              },
              onSubmitted: (String value) {
                widget.formData['comment'] = value;
              },
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            RatingBar.builder(
              initialRating: 1,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                widget.formData['review'] = rating;
              },
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
          ],
        ));
  }
}
