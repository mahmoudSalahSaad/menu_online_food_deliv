import 'package:flutter/material.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/size_config.dart';

class TextIconWidget extends StatelessWidget {
  const TextIconWidget({
    Key? key,
     this.text,
     this.icon,
     this.onTap, this.signOut = false,

  }) : super(key: key);

  final String? text;
  final Function? onTap;
  final String? icon;
  final bool? signOut ;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>onTap,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,

            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset("$icon" , scale: 3.6,height: 24,) ,
                      SizedBox(width: getProportionateScreenWidth(5)),
                      Text(
                        text!,
                        maxLines: 3,
                        style:
                        TextStyle(fontSize: getProportionateScreenWidth(16) , color: signOut == false ? Color(0xff222222) : Color(0xffB90101)),
                      ),
                    ],
                  ) ,

                  signOut == false ?Icon(Icons.arrow_forward_ios_rounded , color: Color(0xff7D848D),size: 12,)  : SizedBox(),



                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
