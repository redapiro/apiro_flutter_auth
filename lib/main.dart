import 'package:flutter/material.dart';
import 'package:user_authentication/utils/app_colors.dart';
import 'package:user_authentication/widget/login/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apiro Flutter Auth',
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: AppColors.primaryColor,
        backgroundColor: Colors.red,
        accentColor: Colors.red,
        dividerColor: AppColors.dividerColor,
        scaffoldBackgroundColor: Colors.white,
        disabledColor: AppColors.disabledColor,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.white,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            )),
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: "OpenSans",
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
        appBarTheme: AppBarTheme(
          color: AppColors.primaryColor,
          textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                // color: Colors.blueGrey[600],
                color: Colors.white,
                // fontWeight: FontWeight.w700,
              )),
        ),
      ),
      home: LoginScreen(),
    );
  }
}
