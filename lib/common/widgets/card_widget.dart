import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final double height;
  final double width;
  final List<Color> bgColors;
  final String text;
  final TextStyle textStyle;
  final Function onPressed;
  final double borderRadius;

  const CardWidget({
    Key key,
    this.height = 45,
    this.width = 120,
    this.bgColors = const [Color(0xffb5f959), Color(0xff69ae08)],
    this.text = '',
    this.onPressed,
    this.textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? height),
        gradient: LinearGradient(
          colors: bgColors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? height),
        ),
        elevation: 0.0,
        onPressed: onPressed,
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }
}
