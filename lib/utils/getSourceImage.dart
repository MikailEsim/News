import 'package:flutter/material.dart';

getSourceImage(source, height, width) {
  String sourceIcon = 'assets/newsSourceImages/notFoundSource.png';
  if (source == 'Aspor') {
    sourceIcon = 'assets/newsSourceImages/sabah.png';
  } else if (source == 'Birgün') {
    sourceIcon = 'assets/newsSourceImages/birgün.png';
  } else if (source == 'CnnTürk') {
    sourceIcon = 'assets/newsSourceImages/cnnturk.png';
  } else if (source == 'Cumhuriyet') {
    sourceIcon = 'assets/newsSourceImages/cumhuriyet.png';
  } else if (source == 'Dünya') {
    sourceIcon = 'assets/newsSourceImages/dunya.png';
  } else if (source == 'En Son Haber') {
    sourceIcon = 'assets/newsSourceImages/ensonhaber.png';
  } else if (source == 'Fanatik') {
    sourceIcon = 'assets/newsSourceImages/fanatik.png';
  } else if (source == 'Fotomaç') {
    sourceIcon = 'assets/newsSourceImages/fotomac.png';
  } else if (source == 'HaberTürk') {
    sourceIcon = 'assets/newsSourceImages/haberturk.png';
  } else if (source == 'Hürriyet') {
    sourceIcon = 'assets/newsSourceImages/hurriyet.png';
  } else if (source == 'İnternet Haber') {
    sourceIcon = 'assets/newsSourceImages/internethaber.png';
  } else if (source == 'KARAR') {
    sourceIcon = 'assets/newsSourceImages/karar.png';
  } else if (source == 'Milliyet') {
    sourceIcon = 'assets/newsSourceImages/milliyet.png';
  } else if (source == 'Mynet') {
    sourceIcon = 'assets/newsSourceImages/mynet.png';
  } else if (source == 'Ntv') {
    sourceIcon = 'assets/newsSourceImages/ntv.png';
  } else if (source == 'Posta') {
    sourceIcon = 'assets/newsSourceImages/posta.png';
  } else if (source == 'Sabah') {
    sourceIcon = 'assets/newsSourceImages/sabah.png';
  } else if (source == 'Shift Delete') {
    sourceIcon = 'assets/newsSourceImages/shiftdelete.png';
  } else if (source == 'Sözcü') {
    sourceIcon = 'assets/newsSourceImages/Sözcü.png';
  } else if (source == 'Sporx') {
    sourceIcon = 'assets/newsSourceImages/sporx.png';
  }
  return ClipOval(
    child: Image.asset(
      sourceIcon,
      height: height,
      width: width,
    ),
  );
}
