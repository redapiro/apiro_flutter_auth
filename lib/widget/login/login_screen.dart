import 'package:flutter/material.dart';
import 'package:user_authentication/widget/login/login_form.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
  ) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: LoginForm(
        _submitLoginForm,
        _isLoading,
      ),
    );
  }
}
