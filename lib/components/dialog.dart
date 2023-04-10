import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_egypt/providers/orders_provider.dart';
import 'package:menu_egypt/screens/orders_screen/my_orders.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:provider/provider.dart';

class AppDialog {
  static infoDialog({
    BuildContext? context,
    String? title,
    String? message,
    String? btnTxt,
  }) {
    PanaraInfoDialog.showAnimatedGrow(
      context!,
      title: title,
      message: message!,
      buttonText: btnTxt!,
      onTapDismiss: () {
        Navigator.pop(context);
      },
      textColor: kAppBarColor,
      panaraDialogType: PanaraDialogType.custom,
      color: kPrimaryColor,
    );
  }
  static mailDialog({
    BuildContext? context,
    String? title,
    String? message,
    String? btnTxt,
  }) {
    PanaraInfoDialog.showAnimatedGrow(
      context!,
        imagePath: "assets/gif/icons8-gmail-logo.gif",
      message: message!,
      buttonText: btnTxt!,
      onTapDismiss: () {
        Navigator.pop(context);
      },
      textColor: kAppBarColor,
      panaraDialogType: PanaraDialogType.custom,
      color: kPrimaryColor,
    );
  }

  static confirmDialog({
    BuildContext? context,
    String? title,
    String? message,
    String? confirmBtnTxt,
    String? cancelBtnTxt,
    Function? onConfirm,
  }) {
    PanaraConfirmDialog.showAnimatedGrow(
      context!,
      title: title,
      message: message!,
      confirmButtonText: confirmBtnTxt!,
      cancelButtonText: cancelBtnTxt!,
      onTapCancel: () {
        Navigator.pop(context);
      },
      onTapConfirm: ()=>onConfirm,
      textColor: kAppBarColor,
      panaraDialogType: PanaraDialogType.custom,
      color: kPrimaryColor,
    );
  }

  static Future<void> cancelOrder(BuildContext context , String message , String orderNumber , String comment){
    return PanaraConfirmDialog.showAnimatedGrow(context,
        message: message,
        color: kAppBarColor,
        textColor: Colors.black,
        confirmButtonText: "تأكيد",
        cancelButtonText: "اغلاق",
        onTapConfirm: ()async{
          final orderProvider = Provider.of<OrderProvider>(context , listen : false) ;
          orderProvider.cancelOrder(orderNumber , comment) ;
           await orderProvider.getOrders() ;
          Get.back();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> MyOrders())) ;
        },
        onTapCancel: (){
          Get.back() ;
        },
        panaraDialogType: PanaraDialogType.custom
    ) ;
  }
}
