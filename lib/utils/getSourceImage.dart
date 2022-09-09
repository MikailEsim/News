import 'package:flutter/material.dart';

getSourceImage(source, height, width) {
  String sourceIcon = 'assets/newsSourceImages/notFoundSource.png';
  if (source == 'Aspor.com.tr') {
    sourceIcon = 'assets/newsSourceImages/aspor.png';
  } else if (source == 'Birgun.net') {
    sourceIcon = 'assets/newsSourceImages/birgun.png';
  } else if (source == 'Cnnturk.com.tr') {
    sourceIcon = 'assets/newsSourceImages/cnnturk.png';
  } else if (source == 'Cumhuriyet.com.tr') {
    sourceIcon = 'assets/newsSourceImages/cumhuriyet.png';
  } else if (source == 'Dünya') {
    sourceIcon = 'assets/newsSourceImages/dunya.png';
  } else if (source == 'Eurohoops') {
    sourceIcon = 'assets/newsSourceImages/eurohoops.jpg';
  } else if (source == 'F5haber.com') {
    sourceIcon = 'assets/newsSourceImages/f5.png';
  } else if (source == 'Ensonhaber.com') {
    sourceIcon = 'assets/newsSourceImages/ensonhaber.png';
  } else if (source == 'Fanatik.com.tr') {
    sourceIcon = 'assets/newsSourceImages/fanatik.png';
  } else if (source == 'Fotomac.com.tr') {
    sourceIcon = 'assets/newsSourceImages/fotomac.png';
  } else if (source == 'Google News') {
    sourceIcon = 'assets/newsSourceImages/googlenews.png';
  } else if (source == 'Haberturk.com') {
    sourceIcon = 'assets/newsSourceImages/haberturk.png';
  } else if (source == 'Hurriyet.com.tr') {
    sourceIcon = 'assets/newsSourceImages/hurriyet.png';
  } else if (source == 'İnternet Haber') {
    sourceIcon = 'assets/newsSourceImages/internethaber.png';
  } else if (source == 'Karar.com') {
    sourceIcon = 'assets/newsSourceImages/karar.png';
  } else if (source == 'Milliyet.com.tr') {
    sourceIcon = 'assets/newsSourceImages/milliyet.png';
  } else if (source == 'Mynet.com') {
    sourceIcon = 'assets/newsSourceImages/mynet.png';
  } else if (source == 'Mynet') {
    sourceIcon = 'assets/newsSourceImages/mynet.png';
  } else if (source == 'Ntv.com.tr' || source == 'Ntvspor.net') {
    sourceIcon = 'assets/newsSourceImages/ntv.png';
  } else if (source == 'Onedio.com') {
    sourceIcon = 'assets/newsSourceImages/onedio.png';
  } else if (source == 'Posta') {
    sourceIcon = 'assets/newsSourceImages/posta.png';
  } else if (source == 'Sabah.com.tr') {
    sourceIcon = 'assets/newsSourceImages/sabah.png';
  } else if (source == 'Shift Delete') {
    sourceIcon = 'assets/newsSourceImages/shiftdelete.png';
  } else if (source == 'Sondakika.com') {
    sourceIcon = 'assets/newsSourceImages/sondakika.png';
  } else if (source == 'Sozcu.com.tr') {
    sourceIcon = 'assets/newsSourceImages/sozcu.png';
  } else if (source == 'Sporx.com') {
    sourceIcon = 'assets/newsSourceImages/sporx.png';
  } else if (source == 'Youtube.com') {
    sourceIcon = 'assets/newsSourceImages/youtube.png';
  }
  return ClipOval(
    child: Image.asset(
      sourceIcon,
      height: height,
      width: width,
    ),
  );
}
