import 'dart:async';

import 'package:flutter/material.dart';
import 'package:user_authentication/support_files/common_widgets/adaptive/adaptive_elevated_button.dart';
import 'package:user_authentication/support_files/common_widgets/adaptive/text_field/app_text_field.dart';

import '../../utils/app_colors.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({required this.onForgotPassword, this.onCancel});

  Function(String, Completer) onForgotPassword;
  VoidCallback? onCancel;

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  dynamic? _userImageFile;

  var _userEmail = '';

  late BuildContext context;

  late ThemeData _themeData;

  late Completer forgotPasswordCompleter;
  bool isLoading = false;
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    this.context = context;
    _themeData = Theme.of(context);

    return Form(
        key: _formKey,
        child: Column(children: [
          AppTextField(
            label: "Email",
            validator: (value) {
              if (value!.isEmpty || !value.contains('@')) {
                return "Not a valid email";
              }
              return null;
            },
            controller: _emailController,
            textInputType: TextInputType.emailAddress,
            onSaved: (value) {
              _userEmail = value!;
            },
          ),
          SizedBox(height: 20),
          if (this.isLoading) CircularProgressIndicator(),
          if (!this.isLoading)
            Row(
              children: [
                Spacer(flex: 2),
                Expanded(
                  child: AdaptiveElevatedButton(
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.separatorColor)),
                    buttonBackgroundColor: Colors.white,
                    text: "Cancel",
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                    onPressed: widget.onCancel,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: AdaptiveElevatedButton(
                    buttonBackgroundColor: AppColors.primaryColor,
                    text: "Submit",
                    onPressed: _trySubmit,
                  ),
                ),
              ],
            ),
          SizedBox(height: 15),
        ]));
  }

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(this.context).unfocus();
    print("forgot pas should load");
    if (isValid) {
      forgotPasswordCompleter = Completer();
      this.isLoading = true;
      forgotPasswordCompleter.future.whenComplete(() {
        this.isLoading = false;
        setState(() {});
      });
      this.widget.onForgotPassword(_emailController.text.trim(), forgotPasswordCompleter);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Email is not valid"),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
  }
}
