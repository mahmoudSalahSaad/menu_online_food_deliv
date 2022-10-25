import 'package:flutter/material.dart';
import 'package:menu_egypt/components/form_errors.dart';
import 'package:menu_egypt/components/input_text_field.dart';
import 'package:menu_egypt/providers/user_provider.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';

class SignInForm extends StatefulWidget {
  SignInForm({
    Key key,
    this.formKey,
    @required this.formData,
  }) : super(key: key);
  final GlobalKey formKey;

  final formData;
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final List<String> errors = [];
  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputTextField(
              textInputType: TextInputType.emailAddress,
              labelText: "البريد إلالكترونى",
              border: false,
              intialValue: userProvider.emailExist ?? '',
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
            InputTextField(
              textInputType: TextInputType.visiblePassword,
              obscure: true,
              labelText: "الرقم السرى",
              border: false,
              onSaved: (String newValue) =>
                  widget.formData['password'] = newValue,
              onChanged: (String value) {
                if (value.isNotEmpty) {
                  removeError(error: kPassNullError);
                } else if (value.length > 5) {
                  removeError(error: kShortPassError);
                }
                return null;
              },
              validator: (String value) {
                if (value.isEmpty) {
                  addError(error: kPassNullError);
                  return "";
                } else if (value.length <= 5) {
                  addError(error: kShortPassError);
                  return "";
                }
                return null;
              },
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            FormErrors(errors: errors),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
          ],
        ));
  }
}
