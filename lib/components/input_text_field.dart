import 'package:flutter/material.dart';
import 'package:menu_egypt/utilities/size_config.dart';




class InputTextField extends StatefulWidget {
  const InputTextField({Key? key, this.controller, this.labelText, this.border, this.iconPath, this.textInputType, this.onSaved, this.onChanged,required this.validator, this.obscure, this.readOnly, this.intialValue, this.isPassword  = false}) : super(key: key);
  final TextEditingController? controller;
  final String? labelText;
  final bool? border;
  final bool? isPassword ;
  final String? iconPath ;
  final TextInputType? textInputType;
  final Function(String)? onSaved;
  final Function(String)? onChanged;
  final Function(String) validator;
  final bool? obscure, readOnly;
  final String? intialValue;

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  bool state = false ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    state = widget.obscure ?? false ;
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: widget.readOnly ?? false,
      initialValue: widget.intialValue,
      keyboardType: widget.textInputType,
      obscureText: state,
      onSaved: (String? value)=> widget.onSaved!(value!)!,
      onChanged: (String? value)=>widget.onChanged!(value!),
      style: TextStyle(color: Color(0xff222222) , fontSize: 18 , height: 1.8),
      validator: (String? value)=>widget.validator!(value!),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(  vertical: 14),
          hintText: widget.labelText,
          focusColor: Colors.black,
          suffixIcon: widget.isPassword == true? GestureDetector(
            onTap: (){
              if(state == true){
                setState(() {
                 state = false ;
                });
              }else{
                setState(() {
                 state = true ;
                });
              }
            },
            child: state == true ? Image.asset("assets/icons/Group 1000000776.png") : Icon(Icons.visibility_outlined , color: Color(0xff222222),) ,
          ) : SizedBox(),
          filled: true,

          prefixIcon: Image.asset(widget.iconPath! , scale: 3.6,),
          hintStyle: TextStyle(color: Colors.black),
          fillColor: Color(0xffF7F7F9),
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
              borderSide: BorderSide(color: Color(0xffE4E4E5) , width: 1))),
    );
  }
}


