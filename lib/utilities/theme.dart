import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

ThemeData darkThemeData() {
  return ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: appBarTheme(),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
      backgroundColor: Colors.black,
      centerTitle: true,
      elevation: 0.0,
      systemOverlayStyle:
          SystemUiOverlayStyle(statusBarBrightness: Brightness.dark));
}
