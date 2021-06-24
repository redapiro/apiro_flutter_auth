import 'dart:async';

import 'package:flutter/material.dart';
import 'package:user_authentication/support_files/common_widgets/adaptive/adaptive_elevated_button.dart';
import 'package:user_authentication/support_files/common_widgets/adaptive/text_field/app_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({required this.onForgotPassword});

  Function(String, Completer) onForgotPassword;

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
            textInputType: TextInputType.emailAddress,
            onSaved: (value) {
              _userEmail = value!;
            },
          ),
          SizedBox(height: 20),
          if (this.isLoading) CircularProgressIndicator(),
          if (!this.isLoading)
            AdaptiveElevatedButton(
              text: "Submit",
              onPressed: _trySubmit,
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
      this.widget.onForgotPassword(_userEmail, forgotPasswordCompleter);
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
