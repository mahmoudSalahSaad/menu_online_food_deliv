import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/provider.dart';
import 'package:menu_egypt/widgets/BaseConnectivity.dart';
import 'package:provider/provider.dart';

import 'package:menu_egypt/utilities/routes.dart';
import 'package:menu_egypt/utilities/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) {
    runApp(BaseConnectivity(child: MyApp()));
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: providers(),
        child: Listener(
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primaryColor: kAppBarColor,
                cardColor: Colors.black,
                brightness: Brightness.dark,
                scaffoldBackgroundColor: Colors.transparent,
                fontFamily: 'DroidArabic',
                appBarTheme: appBarTheme()),
            textDirection: TextDirection.rtl,
            initialRoute: '/',
            routes: routes,
          ),
        ));
  }
}
