import 'package:flutter/material.dart';
import 'package:user_authentication/support_files/common_widgets/adaptive/adaptive_elevated_button.dart';
import 'package:user_authentication/support_files/common_widgets/adaptive/text_field/app_text_field.dart';
import 'package:user_authentication/support_files/common_widgets/user_image_picker/user_image_picker.dart';
import 'package:user_authentication/utils/validator.dart';

class SignUpFormScreen extends StatefulWidget {
  final bool isLoading;
  final void Function(
    String email,
    String password,
    String firstName,
    String lastName,
    String phoneNumber,
    // String userName,
    dynamic? image,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  SignUpFormScreen({
    required this.isLoading,
    required this.submitFn,
  });
  @override
  _SignUpFormScreen createState() {
    return _SignUpFormScreen();
    // isLoading: this.isLoading, submitFn: this.submitFn);
  }
}

class _SignUpFormScreen extends State<SignUpFormScreen> {
  var _firstName = '';
  var _lastName = '';
  var _userEmail = '';
  var _phoneNumber = '';
  final _formKey = GlobalKey<FormState>();
  dynamic? _userImageFile;
  var _userPassword = '';
  var _userConfirmPassword = '';
  late BuildContext context;
  TextEditingController _passwordController = TextEditingController();

  late ThemeData _themeData;

  // _SignUpFormScreen({
  //   required this.isLoading,
  //   required this.submitFn,
  // });

  @override
  Widget build(BuildContext context) {
    this.context = context;
    this._themeData = Theme.of(context);

    return Form(
        key: _formKey,
        child: Column(
          children: [
            UserImagePicker(_pickedImage),
            AppTextField(
              label: "First name",
              autocorrect: true,
              enableSuggestions: false,
              isMandatory: true,
              textCapitalization: TextCapitalization.words,
              validator: (value) {
                if (value!.isEmpty || value.length < 3) {
                  return "First name should have more than 2 characters";
                }
                return null;
              },
              onSaved: (value) {
                _firstName = value!;
              },
              margin: EdgeInsets.only(bottom: 15.0, top: 15.0),
            ),
            AppTextField(
              label: "Last name",
              autocorrect: true,
              isMandatory: true,
              enableSuggestions: false,
              textCapitalization: TextCapitalization.words,
              validator: (value) {
                if (value!.isEmpty || value.length < 3) {
                  return "Last name should have more than 2 characters";
                }
                return null;
              },
              onSaved: (value) {
                _lastName = value!;
              },
              margin: EdgeInsets.only(bottom: 15.0),
            ),
            _getPhoneNumberRow(),
            AppTextField(
              label: "Email",
              isMandatory: true,
              validator: (value) {
                if (value!.isEmpty || !value.contains('@')) {
                  return "Enter a valid email";
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
              isMandatory: true,
              isPasswordField: true,
              controller: _passwordController,
              validator: (value) {
                if (value!.isEmpty || value.length < 7) {
                  return "Password should be 7 characters long";
                } else if (!Validators().validateStrongPassword(value)) {
                  return "Password should contain at least one special character, one capital letter and should have at least 8 characters";
                }
                return null;
              },
              onSaved: (value) {
                _userPassword = value!;
              },
              // controller: TextEditingController(),
            ),
            SizedBox(height: 15),
            AppTextField(
              label: "Confirm Password",
              isMandatory: true,
              isPasswordField: true,
              validator: (value) {
                if (value!.isEmpty || value.length < 7) {
                  return "Password should be 7 characters long";
                } else if (value != _passwordController.text.trim()) {
                  return "Confirm password and password field should be same";
                }
                return null;
              },
              onSaved: (value) {
                _userConfirmPassword = value!;
              },
              // controller: TextEditingController(),
            ),
            SizedBox(height: 20),
            if (widget.isLoading) CircularProgressIndicator(),
            if (!widget.isLoading)
              AdaptiveElevatedButton(
                text: 'Signup',
                onPressed: _trySubmit,
              ),
            SizedBox(height: 10),
          ],
        ));
  }

  Widget _getPhoneNumberRow() {
    return Container(
        child: AppTextField(
      label: "Phone Number",
      autocorrect: true,
      enableSuggestions: false,
      textCapitalization: TextCapitalization.words,
      validator: (value) {
        return null;
      },
      onSaved: (value) {
        _firstName = value!;
      },
      margin: EdgeInsets.only(bottom: 15.0, top: 15.0),
    ));
  }

  void _pickedImage(dynamic image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(this.context).unfocus();

    // We can allow a user to not provide an image before registering
    // if (_userImageFile == null) {
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
        _userImageFile,
        false,
        context,
      );
    }
  }
}
