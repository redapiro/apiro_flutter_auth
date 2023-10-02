import 'dart:async';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:user_authentication/support_files/common_widgets/adaptive/adaptive_elevated_button.dart';
import 'package:user_authentication/support_files/common_widgets/adaptive/text_field/app_text_field.dart';
import 'package:user_authentication/utils/app_colors.dart';
import 'package:user_authentication/widget/forgot_password/forgot_password_form.dart';
import 'package:user_authentication/widget/sign_up/sign_up_form.dart';
import 'package:user_authentication/widget/social_button/social_button_widget.dart';

class LoginForm extends StatefulWidget {
  LoginForm(
    this.submitFn,
    this.isLoading,
    this.onForgotPassword, {
    this.imageWidget,
    this.onGoogleSignInClick,
    this.onAppleSignInClick,
    this.onFacebookSignInClick,
    this.onGithubSignInClick,
    this.onMicrosoftSignInClick,
    this.isFacebookSignInAvailable,
    this.isGoogleSignInAvailable,
    this.onLoginWithApiroClick,
    this.isMicrosoftSignInAvailable,
    this.isGithubSignInAvailable,
    this.isLoginWithApiroVisible = false,
    this.isRegisterHereVisible = true,
    this.buttonForegroundColor,
    this.buttonBackgroundColor,
    this.isAppleSignInAvailable,
    this.termsUrl,
    this.privacyPolicyUrl,
    this.companyName,
    this.isProfileImageVisible,
    this.isForgotPasswordVisible,
    this.loginWithApiroKey,
  });

  final bool isLoading;
  final Widget? imageWidget;
  final Function(String, Completer) onForgotPassword;
  final Function(Completer)? onGoogleSignInClick;
  final Function(Completer)? onAppleSignInClick;
  final Function(Completer)? onMicrosoftSignInClick;
  final Function(Completer)? onGithubSignInClick;
  final Function(Completer)? onFacebookSignInClick;
  final Function(Completer)? onLoginWithApiroClick;
  final bool? isFacebookSignInAvailable;
  final bool? isGoogleSignInAvailable;
  final bool? isMicrosoftSignInAvailable;
  final bool? isGithubSignInAvailable;
  final bool? isAppleSignInAvailable;
  final bool? isLoginWithApiroVisible;
  final bool isRegisterHereVisible;
  final bool? isForgotPasswordVisible;
  final Color? buttonBackgroundColor;
  final Color? buttonForegroundColor;
  final String? termsUrl;
  final String? privacyPolicyUrl;
  final String? companyName;
  final bool? isProfileImageVisible;
  final Key? loginWithApiroKey;

  final void Function(
    String email,
    String password,
    String firstName,
    String lastName,
    String phoneNumber,
    // String userName,
    dynamic image,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  //TODO use proper variable type
  // TODO null-safety is missing
  var _isLogin = true;
  var _isForgotPassword = false;
  var _userEmail = '';
  var _phoneNumber = '';

  // var _userName = '';
  var _firstName = '';
  var _lastName = '';
  var _userPassword = '';
  dynamic _userImageFile = File("dummy.txt");
  ThemeData? _themeData;
  late Completer loginWithApiroCompleter;
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  bool isLoginWithApiroLoading = false;
  bool isSignUpWithSocialButtonAvailable = true;

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
        _phoneNumber.trim(),
        // _userName.trim(),
        _userImageFile!,
        _isLogin,
        context,
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
            child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(maxWidth: 450),
            child: Column(
              children: [
                // widget.imageWidget ?? Container(),
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
                        // RichText(
                        //     text: TextSpan(children: [
                        //   TextSpan(
                        //       text:
                        //           "By signing in, you agree to ${widget.companyName}",
                        //       style: _themeData!.textTheme.subtitle2!),
                        //   TextSpan(
                        //       text: " Terms of Use ",
                        //       style: _themeData!.textTheme.subtitle2!
                        //           .copyWith(color: AppColors.appBlueColor),
                        //       recognizer: TapGestureRecognizer()
                        //         ..onTap = () {
                        //           _onTermsOfUserClick(
                        //               widget.termsUrl ?? "www.google.com");
                        //         }),
                        //   TextSpan(
                        //       text: " and ",
                        //       style: _themeData!.textTheme.subtitle2!),
                        //   TextSpan(
                        //       text: "Privacy Policy.",
                        //       style: _themeData!.textTheme.subtitle2!
                        //           .copyWith(color: AppColors.appBlueColor),
                        //       recognizer: TapGestureRecognizer()
                        //         ..onTap = () {
                        //           _onPrivacyPolicyClick(
                        //               widget.privacyPolicyUrl ??
                        //                   "www.google.com");
                        //         }),
                        // ])),
                        SizedBox(height: 5),
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

  Widget _getRegisterRow() {
    return Container(
      // width: double.maxFinite,
      alignment: AlignmentDirectional.bottomStart,
      // margin: EdgeInsets.only(bottom: 10),
      child: RichText(
          textAlign: TextAlign.start,
          text: TextSpan(children: [
            TextSpan(
                text: !_isLogin ? "Already a member " : "Not a member yet?",
                style: _themeData!.textTheme.subtitle2!),
            TextSpan(
                text: !_isLogin ? "Login" : "Register",
                style: _themeData!.textTheme.subtitle2!),
            TextSpan(
                text: " here ",
                style: _themeData!.textTheme.subtitle2!
                    .copyWith(color: AppColors.appBlueColor),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    _onRegisterHereClick();
                  }),
          ])),
    );
  }

  Widget _getAuthForm() {
    if (_isForgotPassword) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ForgotPasswordScreen(
            onForgotPassword: (email, completer) {
              widget.onForgotPassword(email, completer);
            },
            onCancel:  _onRegisterHereClick,
          ),
          // _getRegisterRow()
        ],
      );
    }

    if (!_isLogin) {
      if (isSignUpWithSocialButtonAvailable) {
        return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          _getSocialLoginAvailableButtons(isSignUp: true),
          SizedBox(height: 15),
          AdaptiveElevatedButton(
            text: "Sign Up With Email",
            onPressed: () {
              this.isSignUpWithSocialButtonAvailable = false;
              setState(() {});
            },
            buttonBackgroundColor: widget.buttonBackgroundColor,
            buttonForegroundColor: widget.buttonForegroundColor,
          ),
          SizedBox(height: 15),
          _getRegisterRow(),
          SizedBox(height: 15),
        ]);
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SignUpFormScreen(
              isLoading: widget.isLoading,
              submitFn: widget.submitFn,
              buttonForegroundColor: widget.buttonForegroundColor,
              buttonBackgroundColor: widget.buttonBackgroundColor,
              isProfileImageVisible: widget.isProfileImageVisible,
            ),
            _getRegisterRow(),
            SizedBox(height: 5)
          ],
        );
      }
    } else {
      return _getLoginForm();
    }
    // return !_isLogin
    //     ? SignUpFormScreen(
    //         isLoading: widget.isLoading,
    //         submitFn: widget.submitFn,
    //       )
    //     : _getLoginForm();
  }

  Widget _getLoginForm() {
    return FocusTraversalGroup(
      policy: OrderedTraversalPolicy(),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AppTextField(
              label: "Username",
              focusNode: _emailFocusNode,
              // controller: TextEditingController(),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Not a valid Username";
                }
                return null;
              },
              onFieldSubmit: (val) {
                _userEmail = val!;
                FocusScope.of(context).requestFocus(_passwordFocusNode);
              },
              textInputType: TextInputType.emailAddress,
              onSaved: (value) {
                _userEmail = value!;
              },
            ),
            SizedBox(height: 15),
            AppTextField(
              label: "Password",
              focusNode: _passwordFocusNode,
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
              onFieldSubmit: (value) {
                _userPassword = value!;
                _trySubmit();
              },
              // controller: TextEditingController(),
            ),
            SizedBox(height: 20),
            if (widget.isLoading) CircularProgressIndicator(),
            if (!widget.isLoading)
              AdaptiveElevatedButton(
                buttonBackgroundColor: widget.buttonBackgroundColor,
                buttonForegroundColor: widget.buttonForegroundColor,
                text: 'Sign In',
                onPressed: _trySubmit,
              ),
            SizedBox(height: 10),
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              if (widget.isForgotPasswordVisible != false)
                InkWell(
                  onTap: _onForgotPasswordTap,
                  child: Text(
                    "Forgot Password",
                    style: _themeData!.textTheme.subtitle2!
                        .copyWith(color: AppColors.greenColor),
                  ),
                ),
              // Expanded(child: Container()),
              SizedBox(width: 15),
              if (widget.isRegisterHereVisible)
                Expanded(child: _getRegisterRow()),
            ]),
            SizedBox(height: 15),
            _getHorizontalSeparatorLine(),
            _getSocialLoginAvailableButtons(),
            _getDebugDemoUserButton(),
            /* SizedBox(height: 15),
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
      ),
    );
  }

  Widget _getSocialLoginAvailableButtons({bool isSignUp = false}) {
    return Column(
      children: [
        SocialButtonWidget(
          onButtonPress: (completer) {
            if (widget.onGoogleSignInClick != null) {
              widget.onGoogleSignInClick!(completer);
            }
          },
          title: isSignUp ? "Sign Up With Google" : "Sign In With Google",
          isAvailable: (widget.isGoogleSignInAvailable ?? false),
          imagePath: "assets/images/google.png",
        ),
        SocialButtonWidget(
          onButtonPress: (completer) {
            if (widget.onMicrosoftSignInClick != null) {
              widget.onMicrosoftSignInClick!(completer);
            }
          },
          title: isSignUp ? "Sign Up With Microsoft" : "Sign In With Microsoft",
          isAvailable: (widget.isMicrosoftSignInAvailable ?? false),
          imagePath: "assets/images/microsoft.png",
        ),
        SocialButtonWidget(
          onButtonPress: (completer) {
            if (widget.onGithubSignInClick != null) {
              widget.onGithubSignInClick!(completer);
            }
          },
          title: isSignUp ? "Sign Up With Github" : "Sign In With Github",
          isAvailable: (widget.isGithubSignInAvailable ?? false),
          imagePath: "assets/images/github.png",
        ),
        SocialButtonWidget(
          onButtonPress: (completer) {
            if (widget.onAppleSignInClick != null) {
              widget.onAppleSignInClick!(completer);
            }
          },
          title: isSignUp ? "Sign Up With Apple" : "Sign In With Apple",
          isAvailable: (widget.isAppleSignInAvailable ?? false),
          imagePath: "assets/images/apple_logo.png",
        ),
        SocialButtonWidget(
          onButtonPress: (completer) {
            if (widget.onFacebookSignInClick != null) {
              widget.onFacebookSignInClick!(completer);
            }
          },
          title: isSignUp ? "Sign Up With Facebook" : "Sign In With Facebook",
          isAvailable: (widget.isFacebookSignInAvailable ?? false),
          imagePath: "assets/images/facebook.png",
        ),
      ],
    );
  }

  Widget _getHorizontalSeparatorLine() {
    return Container(
        height: 1, width: double.maxFinite, color: AppColors.separatorColor);
  }

  Widget _getDebugDemoUserButton() {
    return SocialButtonWidget(key: widget.loginWithApiroKey,
      onButtonPress: (completer) {
        if (widget.onLoginWithApiroClick != null) {
          widget.onLoginWithApiroClick!(completer);
        }
      },
      title: "Sign In With Apiro",
      isAvailable: (widget.isLoginWithApiroVisible ?? false),
      // imagePath: "assets/images/logo.png",
    );
  }

  void _onForgotPasswordTap() {
    print("Forgot User password pressed");
    setState(() {
      _isForgotPassword = !_isForgotPassword;
    });
  }

  void _onTermsOfUserClick(String termsUrl) {
    print("Terms of Use pressed : $termsUrl");
    launchUrlString(termsUrl);
  }

  void _onRegisterHereClick() {
    print("Register here clicked pressed");
    if (_isForgotPassword) {
      setState(() {
        _isForgotPassword = !_isForgotPassword;
      });
    } else {
      if (_isLogin) {
        isSignUpWithSocialButtonAvailable = true;
      }
      setState(() {
        _isLogin = !_isLogin;
      });
    }
  }

  void _onPrivacyPolicyClick(String privacyPolicyUrl) {
    print("privacy policy pressed : $privacyPolicyUrl");
    launchUrlString(privacyPolicyUrl);
  }
}
