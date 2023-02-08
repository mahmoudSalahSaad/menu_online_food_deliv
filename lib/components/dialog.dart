import 'package:flutter/cupertino.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class AppDialog {
  static infoDialog({
    BuildContext context,
    String title,
    String message,
    String btnTxt,
  }) {
    PanaraInfoDialog.showAnimatedGrow(
      context,
      title: title,
      message: message,
      buttonText: btnTxt,
      onTapDismiss: () {
        Navigator.pop(context);
      },
      textColor: kAppBarColor,
      panaraDialogType: PanaraDialogType.custom,
      color: kPrimaryColor,
    );
  }
  static mailDialog({
    BuildContext context,
    String title,
    String message,
    String btnTxt,
  }) {
    PanaraInfoDialog.showAnimatedGrow(
      context,
        imagePath: "assets/gif/icons8-gmail-logo.gif",
      message: message,
      buttonText: btnTxt,
      onTapDismiss: () {
        Navigator.pop(context);
      },
      textColor: kAppBarColor,
      panaraDialogType: PanaraDialogType.custom,
      color: kPrimaryColor,
    );
  }

  static confirmDialog({
    BuildContext context,
    String title,
    String message,
    String confirmBtnTxt,
    String cancelBtnTxt,
    Function onConfirm,
  }) {
    PanaraConfirmDialog.showAnimatedGrow(
      context,
      title: title,
      message: message,
      confirmButtonText: confirmBtnTxt,
      cancelButtonText: cancelBtnTxt,
      onTapCancel: () {
        Navigator.pop(context);
      },
      onTapConfirm: onConfirm,
      textColor: kAppBarColor,
      panaraDialogType: PanaraDialogType.custom,
      color: kPrimaryColor,
    );
  }
}
