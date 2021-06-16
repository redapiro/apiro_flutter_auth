import 'package:flutter/material.dart';
import 'package:user_authentication/support_files/common_widgets/adaptive/adaptive_elevated_button.dart';
import 'package:user_authentication/support_files/common_widgets/adaptive/text_field/app_text_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen(
      {required this.isLoading, required this.onForgotPassword});

  final _formKey = GlobalKey<FormState>();
  dynamic? _userImageFile;
  final bool isLoading;
  var _userEmail = '';
  late BuildContext context;
  Function(String) onForgotPassword;
  late ThemeData _themeData;

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
    if (isValid) {
      this.onForgotPassword(_userEmail);
    }
  }
}
