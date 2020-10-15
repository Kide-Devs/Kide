import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color color;
  final Color shadowColor;
  final double verticalPadding;
  final double horizontalPadding;
  final double fontSize;

  const RoundedButton({
    @required this.text,
    @required this.onPressed,
    @required this.color,
    this.verticalPadding = 8,
    this.horizontalPadding = 28,
    this.fontSize = 20,
    this.shadowColor = Colors.transparent,
    key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50),
          // Large enough value
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: 20,
              offset: Offset(0, 5),
              spreadRadius: 1,
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontFamily: "Quicksand",
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 2,
          ),
        ),
      ),
      onTap: onPressed,
    );
  }
}
