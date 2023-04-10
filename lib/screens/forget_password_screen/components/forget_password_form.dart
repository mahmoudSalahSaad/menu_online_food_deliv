import 'package:flutter/material.dart';
import 'package:menu_egypt/components/form_errors.dart';

import 'package:menu_egypt/components/input_text_field.dart';

import 'package:menu_egypt/utilities/constants.dart';

class ForgetPasswordForm extends StatefulWidget {
  ForgetPasswordForm({this.formData, this.formKey});

  final GlobalKey? formKey;
  final formData;
  @override
  _ForgetPasswordFormState createState() => _ForgetPasswordFormState();
}

class _ForgetPasswordFormState extends State<ForgetPasswordForm> {
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
        children: [
          InputTextField(
            textInputType: TextInputType.emailAddress,
            labelText: "البريد إلالكترونى",
            border: false,
            iconPath: "assets/icons/mail.png",
            onSaved: (String newValue) => widget.formData['email'] = newValue,
            onChanged: (String value) {
              if (value.isNotEmpty) {
                removeError(error: kEmailNullError);
                if (emailValidatorRegExp.hasMatch(value)) {
                  removeError(error: kInvalidEmailError);
                  widget.formData['email'] = value ;

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
          FormErrors(errors: errors),
        ],
      ),
    );
  }
}
