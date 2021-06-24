import 'dart:async';

import 'package:flutter/material.dart';
import 'package:user_authentication/widget/login/login_form.dart';

class AuthenticationScreen extends StatefulWidget {
  final Function(Map<String, dynamic>, Completer) onLogin;
  final Function(String, Completer) onForgotPassword;
  final Function(Map<String, dynamic>, Completer) onSignUp;
  final Function(Completer)? onGoogleSignInClick;
  final Function(Completer)? onAppleSignInClick;
  final Function(Completer)? onMicroSoftSignInClick;
  final Function(Completer)? onGithubSignInClick;
  final Function(Completer)? onFacebookSignInClick;
  final Function(Completer)? onLoginWithApiroClick;
  final bool isMicrosoftLoginAvailable;
  final bool isGoogleLoginAvailable;
  final bool isGithubLoginAvailable;
  final bool isFacebookLoginAvailable;
  final bool isAppleLoginAvailable;
  final bool isLoginWithApiroVisible;
  final Widget? imageWidget;

  AuthenticationScreen(
      {required this.onForgotPassword,
      required this.onLogin,
      required this.onSignUp,
      this.onGoogleSignInClick,
      this.imageWidget,
      this.onAppleSignInClick,
      this.onMicroSoftSignInClick,
      this.onGithubSignInClick,
      this.onFacebookSignInClick,
      this.onLoginWithApiroClick,
      this.isMicrosoftLoginAvailable = false,
      this.isGoogleLoginAvailable = false,
      this.isGithubLoginAvailable = false,
      this.isLoginWithApiroVisible = false,
      this.isFacebookLoginAvailable = false,
      this.isAppleLoginAvailable = false});

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
        onAppleSignInClick: widget.onAppleSignInClick,
        onFacebookSignInClick: widget.onFacebookSignInClick,
        onGithubSignInClick: widget.onGithubSignInClick,
        onMicrosoftSignInClick: widget.onMicroSoftSignInClick,
        isAppleSignInAvailable: widget.isAppleLoginAvailable,
        isFacebookSignInAvailable: widget.isFacebookLoginAvailable,
        isGithubSignInAvailable: widget.isGithubLoginAvailable,
        isGoogleSignInAvailable: widget.isGoogleLoginAvailable,
        isMicrosoftSignInAvailable: widget.isMicrosoftLoginAvailable,
        isLoginWithApiroVisible: widget.isLoginWithApiroVisible,
        onLoginWithApiroClick: widget.onLoginWithApiroClick,
      ),
    );
  }
}
