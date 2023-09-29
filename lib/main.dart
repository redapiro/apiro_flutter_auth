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
        primaryColor: AppColors.primaryColor,
        dividerColor: AppColors.dividerColor,
        scaffoldBackgroundColor: Colors.white,
        disabledColor: AppColors.disabledColor,
        buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.white,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            )),
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium: TextStyle(
                fontFamily: "OpenSans",
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
        appBarTheme: AppBarTheme(
          color: AppColors.primaryColor,
          toolbarTextStyle: ThemeData.light()
              .textTheme
              .copyWith(
                  titleLarge: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                // color: Colors.blueGrey[600],
                color: Colors.white,
                // fontWeight: FontWeight.w700,
              ))
              .bodyText2,
          titleTextStyle: ThemeData.light()
              .textTheme
              .copyWith(
                  titleLarge: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                // color: Colors.blueGrey[600],
                color: Colors.white,
                // fontWeight: FontWeight.w700,
              ))
              .titleLarge,
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red)
            .copyWith(secondary: Colors.red)
            .copyWith(background: Colors.red),
      ),
      home: AuthenticationScreen(
        onForgotPassword: (email, completer) {},
        onLogin: (data, completer) {},
        onSignUp: (data, completer) {},
        isLoginWithApiroVisible: true,
      ),
    );
  }
}
