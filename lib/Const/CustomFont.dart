import 'package:flutter/material.dart';

class CustomFont {
  Color? textColor;
  double? size;
  CustomFont(this.textColor, this.size);
  TextStyle regular() {
    return TextStyle(color: textColor, fontSize: size, fontFamily: "R");
  }

  TextStyle light() {
    return TextStyle(color: textColor, fontSize: size, fontFamily: "L");
  }

  TextStyle medium() {
    return TextStyle(color: textColor, fontSize: size, fontFamily: "M");
  }

  TextStyle semi() {
    return TextStyle(color: textColor, fontSize: size, fontFamily: "S");
  }

  TextStyle bold() {
    return TextStyle(color: textColor, fontSize: size, fontFamily: "B");
  }
}
