import 'dart:async';

import 'package:flutter/material.dart';
import 'package:user_authentication/widget/login/login_form.dart';
import 'package:intl/intl.dart';

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
  final bool isRegisterHereVisible;
  final Widget? imageWidget;
  final ButtonStyle? buttonStyle;
  final Color? buttonBackgroundColor;
  final Color? buttonForegroundColor;
  final String? termsUrl;
  final String? privacyPolicyUrl;
  final String? companyName;
  final bool? isProfileImageVisible;

  AuthenticationScreen({
    required this.onForgotPassword,
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
    this.isRegisterHereVisible = true,
    this.isAppleLoginAvailable = false,
    this.buttonStyle,
    this.buttonForegroundColor,
    this.buttonBackgroundColor,
    this.termsUrl,
    this.privacyPolicyUrl,
    this.companyName,
    this.isProfileImageVisible,
  });

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  var _isLoading = false;
  bool isError = false;
  String errorMessage = "";
  Completer signupLoginCompleter = Completer();

  void _submitLoginForm(
    String email,
    String password,
    // String username,
    String firstName,
    String lastName,
    String phoneNumber,
    dynamic? image,
    bool isLogin,
    BuildContext ctx,
  ) async {
    _isLoading = true;
    setState(() {});

    signupLoginCompleter.future.whenComplete(() {
      _isLoading = false;
      signupLoginCompleter = Completer();
      if (mounted) setState(() {});
    });

    signupLoginCompleter.future.onError((error, s) {
      _isLoading = false;
      signupLoginCompleter = Completer();
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
        'phone_number': phoneNumber,
        'password': password,
        'created_on': DateFormat("dd-MMM-yyyy hh:mm:ss").format(DateTime.now()),
        'image': image,
      }, signupLoginCompleter);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LoginForm(
        _submitLoginForm,
        _isLoading,
        (email, completer) {
          widget.onForgotPassword(email, completer);
        },
        imageWidget: widget.imageWidget,
        onGoogleSignInClick: widget.onGoogleSignInClick,
        onAppleSignInClick: widget.onAppleSignInClick,
        isRegisterHereVisible: widget.isRegisterHereVisible,
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
        buttonForegroundColor: widget.buttonForegroundColor,
        buttonBackgroundColor: widget.buttonBackgroundColor,
        termsUrl: widget.termsUrl,
        privacyPolicyUrl: widget.privacyPolicyUrl,
        companyName: widget.companyName,
        isProfileImageVisible: widget.isProfileImageVisible,
      ),
    );
  }
}
