import 'package:flutter/material.dart';
import 'package:user_authentication/widget/login/login_form.dart';

class AuthenticationScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onLogin;
  final Function(String) onForgotPassword;
  final Function(Map<String, dynamic>) onSignUp;

  AuthenticationScreen(
      {required this.onForgotPassword,
      required this.onLogin,
      required this.onSignUp});

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  var _isLoading = false;
  bool isError = false;
  String errorMessage = "";

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
    if (isLogin) {
      widget.onLogin({
        'email': email,
        'password': password,
      });
    } else {
      widget.onSignUp({
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
        'image': image,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: LoginForm(_submitLoginForm, _isLoading, widget.onForgotPassword),
    );
  }
}
