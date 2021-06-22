import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:user_authentication/support_files/common_widgets/adaptive/adaptive_elevated_button.dart';
import 'package:user_authentication/support_files/common_widgets/adaptive/text_field/app_text_field.dart';
import 'package:user_authentication/utils/app_colors.dart';
import 'package:user_authentication/widget/forgot_password/forgot_password_form.dart';
import 'package:user_authentication/widget/sign_up/sign_up_form.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginForm extends StatefulWidget {
  LoginForm(this.submitFn, this.isLoading, this.onForgotPassword,
      {this.imageWidget, this.onGoogleSignInClick});

  final bool isLoading;
  final Widget? imageWidget;
  final Function(String) onForgotPassword;
  final Function()? onGoogleSignInClick;
  final void Function(
    String email,
    String password,
    String firstName,
    String lastName,
    // String userName,
    dynamic? image,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _isForgotPassword = false;
  var _userEmail = '';
  // var _userName = '';
  var _firstName = '';
  var _lastName = '';
  var _userPassword = '';
  dynamic? _userImageFile = File("dummy.txt");
  ThemeData? _themeData;

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    // Make user image optional
    // if (_userImageFile == null && !_isLogin) {
    //   Scaffold.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text(appLocale!.message_pick_image),
    //       backgroundColor: Theme.of(context).errorColor,
    //     ),
    //   );
    //   return;
    // }

    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _firstName.trim(),
        _lastName.trim(),
        // _userName.trim(),
        _userImageFile!,
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);

    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(maxWidth: 450),
        child: Column(
          children: [
            widget.imageWidget ??
                Container(
                  width: 120,
                  height: 60,
                  child:
                      Image.asset("assets/images/logo.png", fit: BoxFit.cover),
                ),
            SizedBox(height: 20),
            Card(
              elevation: 2.0,
              margin: EdgeInsets.all(20),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _getAuthForm(),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "By signing in, you agree to Apiro's",
                          style: _themeData!.textTheme.subtitle2!),
                      TextSpan(
                          text: " Terms of Use ",
                          style: _themeData!.textTheme.subtitle2!
                              .copyWith(color: _themeData!.primaryColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              _onTermsOfUserClick();
                            }),
                      TextSpan(
                          text: " and ",
                          style: _themeData!.textTheme.subtitle2!),
                      TextSpan(
                          text: "Privacy Policy.",
                          style: _themeData!.textTheme.subtitle2!
                              .copyWith(color: _themeData!.primaryColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              _onPrivacyPolicyClick();
                            }),
                    ])),
                    SizedBox(height: 5),
                    Container(
                      width: double.maxFinite,
                      child: RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(children: [
                            TextSpan(
                                text: !_isLogin
                                    ? "Already a member "
                                    : "Not a member yet?",
                                style: _themeData!.textTheme.subtitle2!),
                            TextSpan(
                                text: " here ",
                                style: _themeData!.textTheme.subtitle2!
                                    .copyWith(color: _themeData!.primaryColor),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    _onRegisterHereClick();
                                  }),
                            TextSpan(
                                text: !_isLogin ? "Login" : "Register",
                                style: _themeData!.textTheme.subtitle2!),
                          ])),
                    ),
                    SizedBox(height: 11),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    )));
  }

  Widget _getAuthForm() {
    if (_isForgotPassword) {
      return ForgotPasswordScreen(
        isLoading: widget.isLoading,
        onForgotPassword: widget.onForgotPassword,
      );
    }
    return !_isLogin
        ? SignUpFormScreen(
            isLoading: widget.isLoading,
            submitFn: widget.submitFn,
          )
        : _getLoginForm();
  }

  Widget _getLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AppTextField(
            label: "Email",
            // controller: TextEditingController(),
            validator: (value) {
              if (value!.isEmpty || !value.contains('@')) {
                return "Not a valid email";
              }
              return null;
            },
            textInputType: TextInputType.emailAddress,
            onSaved: (value) {
              _userEmail = value!;
            },
          ),
          SizedBox(height: 15),
          AppTextField(
            label: "Password",
            isPasswordField: true,
            validator: (value) {
              if (value!.isEmpty || value.length < 7) {
                return "Password must be at least 7 characters long";
              }
              return null;
            },
            onSaved: (value) {
              _userPassword = value!;
            },
            // controller: TextEditingController(),
          ),
          SizedBox(height: 20),
          if (widget.isLoading) CircularProgressIndicator(),
          if (!widget.isLoading)
            AdaptiveElevatedButton(
              text: 'Sign In',
              onPressed: _trySubmit,
            ),
          SizedBox(height: 10),
          Row(children: [
            InkWell(
              onTap: _onForgotPasswordTap,
              child: Text(
                "Forgot Password",
                style: _themeData!.textTheme.subtitle2!
                    .copyWith(color: _themeData!.primaryColor),
              ),
            )
          ]),
          SizedBox(height: 15),
          _getHorizontalSeparatorLine(),
          SizedBox(height: 15),
          _getSocialLoginButton(
              imagePath: "assets/images/google.png",
              title: "Sign In With Google",
              onPress: () {
                _onSignInWithGoogleClick();
              }),
          /*
          SizedBox(height: 15),
          _getSocialLoginButton(
              imagePath: "assets/images/microsoft.png",
              title: appLocale.sign_in_with_microsoft,
              onPress: () {
                _onSignInWithMicroSoftClick();
              }),
          SizedBox(height: 15),
          _getSocialLoginButton(
              imagePath: "assets/images/apple_logo.png",
              title: appLocale.label_sign_in_with_apple,
              onPress: () {
                _onSignInWithAppleClick();
              }),
          SizedBox(height: 15),
          _getSocialLoginButton(
              imagePath: "assets/images/amazon.png",
              title: appLocale.sign_in_with_aws,
              onPress: () {
                _onSignInWithAWSClick();
              }),
          */
          SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _getHorizontalSeparatorLine() {
    return Container(
        height: 1, width: double.maxFinite, color: AppColors.separatorColor);
  }

  Widget _getVerticalSeparatorLine({double? height}) {
    return Container(
        height: height ?? 50, width: 1, color: _themeData!.disabledColor);
  }

  Widget _getSocialLoginButton(
      {Function()? onPress, String? title, String? imagePath}) {
    return InkWell(
      onTap: onPress,
      child: Container(
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(
                color: _themeData!.disabledColor,
              ),
              borderRadius: BorderRadius.circular(5)),
          child: Row(children: [
            Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Image.asset(imagePath!,
                    width: 30, height: 30, fit: BoxFit.cover)),
            _getVerticalSeparatorLine(),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    title!,
                    style: _themeData!.textTheme.subtitle1!
                        .copyWith(color: _themeData!.disabledColor),
                  )),
            )
          ])),
    );
  }

  void _onForgotPasswordTap() {
    print("Forgot User password pressed");
    setState(() {
      _isForgotPassword = !_isForgotPassword;
    });
  }

  void _onTermsOfUserClick() {
    print("Terms of Use pressed");
    launch("https://google.com");
  }

  void _onRegisterHereClick() {
    print("Register here clicked pressed");
    if (_isForgotPassword) {
      setState(() {
        _isForgotPassword = !_isForgotPassword;
      });
    } else {
      setState(() {
        _isLogin = !_isLogin;
      });
    }
  }

  void _onPrivacyPolicyClick() {
    print("privacy policy pressed");
    launch("https://google.com");
  }

  void _onSignInWithMicroSoftClick() {
    print("Sign in with microsoft clicked");
  }

  void _onSignInWithGoogleClick() async {
    if (widget.onGoogleSignInClick != null) {
      widget.onGoogleSignInClick!();
    }
  }

  void _onSignInWithAWSClick() {
    print("sign in with aws clicked");
  }

  void _onSignInWithAppleClick() {
    print("sign in with apple clicked");
  }
}
