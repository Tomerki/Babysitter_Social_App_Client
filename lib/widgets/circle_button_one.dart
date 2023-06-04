import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CircleButtonOne extends StatelessWidget {
  final String text;
  final Function handler;
  final double cWidth;
  final double cHeight;
  final double textSize;
  final double cOpacity;
  final double cCircular;
  final double cPaddingTop;
  final double cPaddingBottom;
  final double cPaddingLeft;
  final double cPaddingRight;
  final double cMarginTop;
  final double cMarginBottom;
  final double cMarginLeft;
  final double cMarginRight;
  final Color textColor;
  final Color bgColor;

  CircleButtonOne({
    required this.handler,
    required this.text,
    this.textSize = 20,
    this.cHeight = 0.07,
    this.cWidth = 0.35,
    this.cCircular = 25,
    this.cOpacity = 1,
    this.cPaddingTop = 1,
    this.cPaddingBottom = 1,
    this.cPaddingLeft = 1,
    this.cPaddingRight = 1,
    this.cMarginTop = 1,
    this.cMarginBottom = 1,
    this.cMarginLeft = 1,
    this.cMarginRight = 1,
    this.textColor = Colors.black,
    this.bgColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: cMarginTop,
        bottom: cMarginBottom,
        left: cMarginLeft,
        right: cMarginRight,
      ),
      padding: EdgeInsets.only(
        top: cPaddingTop,
        bottom: cPaddingBottom,
        left: cPaddingLeft,
        right: cPaddingRight,
      ),
      width: MediaQuery.of(context).size.width * cWidth,
      height: MediaQuery.of(context).size.height * cHeight,
      child: TextButton(
        style: TextButton.styleFrom(
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(cCircular))),
          foregroundColor: textColor,
          backgroundColor: bgColor.withOpacity(cOpacity),
        ),
        child: Text(
          text,
          style: GoogleFonts.workSans(
            color: textColor,
            textStyle: const TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w400,
            ),
          ),
          textAlign: TextAlign.center,
        ),
        onPressed: () => handler(),
      ),
    );
  }
}
