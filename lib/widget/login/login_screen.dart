import 'dart:async';

import 'package:flutter/material.dart';
import 'package:user_authentication/widget/login/login_form.dart';

class AuthenticationScreen extends StatefulWidget {
  final Function(Map<String, dynamic>, Completer) onLogin;
  final Function(String, Completer) onForgotPassword;
  final Function(Map<String, dynamic>, Completer) onSignUp;
  final Function()? onGoogleSignInClick;
  final Widget? imageWidget;

  AuthenticationScreen(
      {required this.onForgotPassword,
      required this.onLogin,
      required this.onSignUp,
      this.onGoogleSignInClick,
      this.imageWidget});

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  var _isLoading = false;
  bool isError = false;
  String errorMessage = "";
  late Completer signupLoginCompleter;

  void _submitLoginForm(
    String email,
    String password,
    // String username,
    String firstName,
    String lastName,
    dynamic? image,
    bool isLogin,
    BuildContext ctx,
  ) async {
    _isLoading = true;
    setState(() {});

    signupLoginCompleter = Completer();
    signupLoginCompleter.future.whenComplete(() {
      _isLoading = false;
      if (mounted) setState(() {});
    });

    if (isLogin) {
      widget.onLogin({
        'email': email,
        'password': password,
      }, signupLoginCompleter);
    } else {
      widget.onSignUp({
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
        'image': image,
      }, signupLoginCompleter);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: LoginForm(
        _submitLoginForm,
        _isLoading,
        (email) {
          widget.onForgotPassword(email, signupLoginCompleter);
        },
        imageWidget: widget.imageWidget,
        onGoogleSignInClick: widget.onGoogleSignInClick,
      ),
    );
  }
}
