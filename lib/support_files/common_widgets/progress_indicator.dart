import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  final double height;
  final double width;

  CustomProgressIndicator({this.height = 25, this.width = 25});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          height: this.height,
          width: this.width,
          child: Center(
              child: CircularProgressIndicator(
            strokeWidth: 1.0,
          ))),
    );
  }
}
