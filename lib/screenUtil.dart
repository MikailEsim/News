import 'package:flutter/material.dart';

class ScreenUtil {
  static double elementHeight(BuildContext context, double size) {
    double height = MediaQuery.of(context).size.height;
    double scaleFactor = height / 812;
    return scaleFactor * size;
  }

  static double elementHeightLandscape(BuildContext context, double size) {
    double height = MediaQuery.of(context).size.height;
    double scaleFactor = height / 375;
    return scaleFactor * size;
  }

  static double elementWidth(BuildContext context, double size) {
    double height = MediaQuery.of(context).size.width;
    double scaleFactor = height / 375;
    return scaleFactor * size;
  }
}
