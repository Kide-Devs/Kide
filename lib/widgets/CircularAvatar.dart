import 'package:flutter/material.dart';

class InitialNameAvatar extends StatelessWidget {
  InitialNameAvatar(this.name,
      {this.backgroundColor,
      this.foregroundColor,
      this.borderColor,
      this.textSize,
      this.borderSize});

  final String name;
  final Color backgroundColor, foregroundColor, borderColor;
  final double textSize, borderSize;

  final double radius = 40;

  @override
  Widget build(BuildContext context) {
    String value = '';
    if (name != '') {
      name.trimLeft().trimRight().split(' ').forEach((word) {
        value += word[0].toUpperCase();
      });
    }

    return Container(
      height: radius * 2 + borderSize,
      width: radius * 2 + borderSize,
      decoration: BoxDecoration(
        color: borderColor,
        borderRadius: BorderRadius.circular(radius + borderSize),
      ),
      child: Center(
        child: Container(
          height: radius * 2,
          width: radius * 2,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                color: foregroundColor,
                fontSize: textSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
