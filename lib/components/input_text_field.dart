import 'package:flutter/material.dart';
import 'package:menu_egypt/utilities/size_config.dart';

class InputTextField extends StatelessWidget {
  const InputTextField(
      {@required this.labelText,
      @required this.border,
      Key key,
      this.controller,
      @required this.textInputType,
      @required this.onSaved,
      @required this.onChanged,
      @required this.validator,
      this.obscure,
      this.readOnly,
      this.intialValue})
      : super(key: key);
  final TextEditingController controller;
  final String labelText;
  final bool border;
  final TextInputType textInputType;
  final Function onSaved;
  final Function onChanged;
  final Function validator;
  final bool obscure, readOnly;
  final String intialValue;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly ?? false,
      initialValue: intialValue,
      keyboardType: textInputType,
      obscureText: obscure != null ? obscure : false,
      onSaved: onSaved,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(getProportionateScreenHeight(5)),
          labelText: labelText,
          focusColor: Colors.white,
          labelStyle: TextStyle(color: Colors.white),
          focusedBorder: border
              ? InputBorder.none
              : UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
          border: border ? InputBorder.none : UnderlineInputBorder()),
    );
  }
}
