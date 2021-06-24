import 'dart:async';

import 'package:flutter/material.dart';
import 'package:user_authentication/utils/app_colors.dart';

class SocialButtonWidget extends StatelessWidget {
  SocialButtonWidget(
      {Key? key,
      required this.onButtonPress,
      this.isAvailable = false,
      this.imagePath = "",
      this.title = ""})
      : super(key: key);
  final Function(Completer)? onButtonPress;
  final bool isAvailable;
  final String imagePath;
  final String title;
  late ThemeData _themeData;
  late Completer buttonLoader;
  ValueNotifier<bool> buttonLoaderNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);

    return Container(
      margin: EdgeInsets.only(top: isAvailable ? 15 : 0),
      child: ValueListenableBuilder<bool>(
        valueListenable: buttonLoaderNotifier,
        builder: (context, value, child) {
          if (!isAvailable) {
            return Container();
          }
          if (value) {
            return CircularProgressIndicator();
          }
          return _getSocialLoginButton();
        },
      ),
    );
  }

  Widget _getSocialLoginButton() {
    return InkWell(
      onTap: () {
        buttonLoader = Completer();
        buttonLoaderNotifier.value = true;
        buttonLoader.future.whenComplete(() {
          this.buttonLoaderNotifier.value = false;
        });
        onButtonPress!(buttonLoader);
      },
      child: Container(
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(
                color: _themeData.disabledColor,
              ),
              borderRadius: BorderRadius.circular(5)),
          child: Row(children: [
            Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Image.asset(imagePath,
                    width: 30, height: 30, fit: BoxFit.cover)),
            _getVerticalSeparatorLine(),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    title,
                    style: _themeData.textTheme.subtitle1!
                        .copyWith(color: _themeData.disabledColor),
                  )),
            )
          ])),
    );
  }

  Widget _getVerticalSeparatorLine({double? height}) {
    return Container(
        height: height ?? 50, width: 1, color: _themeData.disabledColor);
  }
}
