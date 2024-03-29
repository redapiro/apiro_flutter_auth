import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveElevatedButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final Function()? onPressed;
  final ButtonStyle? style;
  final double? width;
  final double? height;
  final TextStyle ? textStyle;
  final BoxDecoration? decoration;
  final Color? buttonBackgroundColor;
  final Color? buttonForegroundColor;

  AdaptiveElevatedButton({
    this.onPressed,
    this.style,
    this.width,this.textStyle,
    this.height,
    this.child,
    this.text,
    this.decoration,
    this.buttonBackgroundColor,
    this.buttonForegroundColor,
  });

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return _getElevatedButton(context);
    } else if (Platform.isLinux) {
      return _getElevatedButton(context);
    } else if (Platform.isIOS) {
      return _getCupertinoButton();
    } else if (Platform.isMacOS) {
      return _getCupertinoButton();
    } else {
      return _getElevatedButton(context);
    }
  }

  Widget _getElevatedButton(BuildContext context) {
    return Container(
      width: this.width ?? double.maxFinite,
      height: this.height ?? 50,
      decoration: this.decoration,
      child: ElevatedButton(
        style: this.style ??
            ElevatedButton.styleFrom(
              foregroundColor: this.buttonForegroundColor ??
                  Theme.of(context).scaffoldBackgroundColor,
              backgroundColor:
                  this.buttonBackgroundColor ?? Theme.of(context).primaryColor,
            ),
        child: this.child ??
            Text(
              text ?? "",
              style: textStyle ?? TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
        onPressed: onPressed,
      ),
    );
  }

  Widget _getCupertinoButton() {
    return CupertinoButton(
      child: this.child ??
          Text(
            text ?? "",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
      onPressed: onPressed,
    );
  }
}
