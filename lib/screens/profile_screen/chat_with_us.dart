import 'package:flutter/material.dart';
import 'package:menu_egypt/components/app_bar.dart';
import 'package:menu_egypt/utilities/size_config.dart';
import 'package:url_launcher/url_launcher.dart';



class ChatWithUs extends StatelessWidget {
  const ChatWithUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    _launchCaller(String number) async {
      if (await canLaunch("tel:// $number" ,)) {
        await launch("tel:// $number" ,);
      } else {
        throw 'Could not launch $number';
      }
    }

    _launchMail(Uri number) async {
      if (await canLaunchUrl(number ,)) {
        await launchUrl(number ,);
      } else {
        throw 'Could not launch $number';
      }
    }
    return Scaffold(
      body:SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBarWidget(
                  title: 'الدعم',
                  withBack: true,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.04,
                ),
                Text('لديك اقتراح أو طلب مساعدة يمكنكم التواصل معنا عبر :' , style: TextStyle(
                  color: Color(0xff222222) ,
                  fontWeight: FontWeight.bold ,
                  fontSize: 18
                ),) ,

                SizedBox(
                  height: 12,
                ),
                GestureDetector(
                  onTap: (){
                    _launchCaller("01116618752") ;
                  },
                  child: Text("- 01116618752" , style: TextStyle(
                    color: Color(0xffB90101) ,
                    fontSize: 16 ,
                    fontWeight: FontWeight.bold
                  ),),
                ),
                SizedBox(
                  height: 12,
                ),
                GestureDetector(
                  onTap: (){
                    String encodeQueryParameters(Map<String, String> params) {
                      return params.entries
                          .map((MapEntry<String, String> e) =>
                      '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                          .join('&');
                    }
// ···
                    final Uri emailLaunchUri = Uri(
                      scheme: 'mailto',
                      path: 'info@menuegypt.com',
                      query: encodeQueryParameters(<String, String>{
                        'subject': '',
                      }),
                    );
                    _launchMail(emailLaunchUri) ;
                  },
                  child: Text("- info@menuegypt.com" , style: TextStyle(
                      color: Color(0xffB90101) ,
                      fontSize: 16 ,
                      fontWeight: FontWeight.bold
                  ),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
