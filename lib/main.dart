import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:menu_egypt/screens/splash_screen/splash_screen.dart';
import 'package:menu_egypt/utilities/constants.dart';
import 'package:menu_egypt/utilities/provider.dart';
import 'package:provider/provider.dart';

import 'package:menu_egypt/utilities/routes.dart';
import 'package:menu_egypt/utilities/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //String _connectionStatus = 'Unknown';
  //final Connectivity _connectivity = Connectivity();
  /*StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }
*/

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: providers(),
        child: Listener(
          onPointerDown: (_) {
            WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
          },
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
            initialRoute: SplashScreen.routeName,
            routes: routes,
            // onGenerateRoute: (RouteSettings routeSettings) {
            //   final List<String> pathElements = routeSettings.name.split('/');
            //   if (pathElements[0] != '') {
            //     return nColor.fromARGB(255, 212, 171, 171)      //   }
            //   //pathElements[1] == 'restaurant';
            //   if (pathElements[1] == 'new_restaurant') {
            //     final int index = int.parse(pathElements[2]);
            //     final int listType = int.parse(pathElements[3]);
            //     final int lang = int.parse(pathElements[4]);
            //     return MaterialPageRoute(
            //         builder: (BuildContext contex) => NewRestaurantScreen(
            //               restaurantIndex: index,
            //               listType: listType,
            //               lang: lang,
            //             ));
            //   }
            //   return null;
            // },
          ),
        ));
  }

  // Future<void> _updateConnectionStatus(ConnectivityResult result) async {
  //   switch (result) {
  //     case ConnectivityResult.wifi:
  //     case ConnectivityResult.mobile:
  //     case ConnectivityResult.none:
  //       setState(() => _connectionStatus = result.toString());
  //       break;
  //     default:
  //       setState(() => _connectionStatus = 'Failed to get connectivity.');
  //       break;
  //   }
  //   if (_connectionStatus == "ConnectivityResult.none") {
  //     SchedulerBinding.instance.addPostFrameCallback((_) {
  //       Get.offNamed(BaseMessageScreen.routeName);
  //     });
  //   } else {
  //     SchedulerBinding.instance.addPostFrameCallback((_) {
  //       Get.offAllNamed(SplashScreen.routeName);
  //     });
  //   }
  // }
}
