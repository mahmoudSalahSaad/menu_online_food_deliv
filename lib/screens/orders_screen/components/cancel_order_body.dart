import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:menu_egypt/components/app_bar.dart';
import 'package:menu_egypt/components/dialog.dart';
import 'package:menu_egypt/components/loading_circle.dart';
import 'package:menu_egypt/providers/orders_provider.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:provider/provider.dart';


class CancelOrderBody extends StatefulWidget {
  final String? orderNumber ;
  const CancelOrderBody({Key? key, this.orderNumber}) : super(key: key);

  @override
  State<CancelOrderBody> createState() => _CancelOrderBodyState();
}

class _CancelOrderBodyState extends State<CancelOrderBody> {
  String? comment ;
  bool error = false ;
  final  _formKey = GlobalKey<FormState>() ;
  final TextEditingController _controller = TextEditingController() ;


  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context , listen: true) ;
      return SingleChildScrollView(
        child: Column(
          children: [
            AppBarWidget(title: "ألغاء الطلب", withBack: true) ,
            SizedBox(
              height: getProportionateScreenHeight(20),
            ) ,
            Form(
              key: _formKey,
              child: SizedBox(
                width: getProportionateScreenWidth(340),
                child: TextFormField(
                  controller: _controller,
                  onSaved: (String? value){
                    comment = value ;
                  },
                  onChanged: (String value){
                   if(value.isNotEmpty){
                     setState(() {
                       comment = value ;
                       error = false ;
                     });
                   }
                  },
                  validator: (String? value){
                    if(value!.isEmpty){
                      error = true ;
                      return "التعليق مطلوب" ;
                    }else{
                      setState(() {
                        error = false ;
                      });
                    }
                    return null ;
                  },
                  style: TextStyle(
                    color: Colors.black54 ,
                  ),
                  decoration: InputDecoration(
                      hintText: "سبب الألغاء" ,

                    filled: true,
                    fillColor: Color(0xffF7F7F9),
                    hintStyle: TextStyle(color: Colors.black , height: 2.0 ,fontSize: 18),

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
                        borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1)),
                    contentPadding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10) , vertical: getProportionateScreenHeight(10)),

                  ),
                  maxLines: 5,

                ),
              ),
            ) ,
            orderProvider.isLoading  == false ? SizedBox(
              width: getProportionateScreenWidth(112),
              child: MaterialButton(
                onPressed: (){
                  if(!_formKey.currentState!.validate()){
                    return ;
                  }else{
                    _formKey.currentState!.save();
                    AppDialog.cancelOrder(context, "هل انت متأكد من ألغاء الطلب؟", widget.orderNumber! , comment!) ;
                  }


                },
                color:
                kAppBarColor,
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(10.0)),
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ' ألغاء الطلب ',
                      style:
                      TextStyle(fontSize: getProportionateScreenHeight(14), fontWeight: FontWeight.bold , color: Colors.white , height: 2.0),
                    ),

                  ],
                ),
              ),
            ) : LoadingCircle()
          ],
        ),
      );
  }
}
