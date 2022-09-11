import 'package:flutter/material.dart';

getSourceImage(source, height, width) {
  String sourceIcon = 'assets/newsSourceImages/default.png';
  if (source == 'Airporthaber.com') {
    sourceIcon = 'assets/newsSourceImages/airporthaber.jpg';
  } else if (source == 'Aksam.com.tr') {
    sourceIcon = 'assets/newsSourceImages/aksam.png';
  } else if (source == 'Aspor.com.tr') {
    sourceIcon = 'assets/newsSourceImages/aspor.png';
  } else if (source == 'Birgun.net') {
    sourceIcon = 'assets/newsSourceImages/birgun.png';
  } else if (source == 'Chip.com.tr') {
    sourceIcon = 'assets/newsSourceImages/chip.png';
  } else if (source == 'Cnnturk.com') {
    sourceIcon = 'assets/newsSourceImages/cnnturk.png';
  } else if (source == 'Cumhuriyet.com.tr') {
    sourceIcon = 'assets/newsSourceImages/cumhuriyet.png';
  } else if (source == 'Donanimhaber.com') {
    sourceIcon = 'assets/newsSourceImages/donanimhaber.png';
  } else if (source == 'Dunya.com') {
    sourceIcon = 'assets/newsSourceImages/dunya.png';
  } else if (source == 'Egehaber.com') {
    sourceIcon = 'assets/newsSourceImages/egehaber.png';
  } else if (source == 'Ensonhaber.com') {
    sourceIcon = 'assets/newsSourceImages/ensonhaber.png';
  } else if (source == 'Eurohoops') {
    sourceIcon = 'assets/newsSourceImages/eurohoops.jpg';
  } else if (source == 'F5haber.com') {
    sourceIcon = 'assets/newsSourceImages/f5.png';
  } else if (source == 'Fanatik.com.tr') {
    sourceIcon = 'assets/newsSourceImages/fanatik.png';
  } else if (source == 'Fenerbahce.org') {
    sourceIcon = 'assets/newsSourceImages/fenerbahce.png';
  } else if (source == 'Fotomac.com.tr') {
    sourceIcon = 'assets/newsSourceImages/fotomac.png';
  } else if (source == 'Google News') {
    sourceIcon = 'assets/newsSourceImages/googlenews.png';
  } else if (source == 'Haber7.com') {
    sourceIcon = 'assets/newsSourceImages/haber7.jpg';
  } else if (source == 'Haber24.com') {
    sourceIcon = 'assets/newsSourceImages/haber24.png';
  } else if (source == 'Haberkolik.net') {
    sourceIcon = 'assets/newsSourceImages/haberkolik.png';
  } else if (source == 'Haberturk.com') {
    sourceIcon = 'assets/newsSourceImages/haberturk.png';
  } else if (source == 'Halktv.com.tr') {
    sourceIcon = 'assets/newsSourceImages/halktv.jpg';
  } else if (source == 'Hurriyet.com.tr') {
    sourceIcon = 'assets/newsSourceImages/hurriyet.png';
  } else if (source == 'Internethaber.com') {
    sourceIcon = 'assets/newsSourceImages/internethaber.png';
  } else if (source == 'Kamupersoneli.net') {
    sourceIcon = 'assets/newsSourceImages/kamupersoneli.png';
  } else if (source == 'Karar.com') {
    sourceIcon = 'assets/newsSourceImages/karar.png';
  } else if (source == 'Kriptokoin.com') {
    sourceIcon = 'assets/newsSourceImages/kriptokoin.jpg';
  } else if (source == 'Milliyet.com.tr') {
    sourceIcon = 'assets/newsSourceImages/milliyet.png';
  } else if (source == 'Motorsport.com') {
    sourceIcon = 'assets/newsSourceImages/motorsport.jpg';
  } else if (source == 'Mynet.com') {
    sourceIcon = 'assets/newsSourceImages/mynet.png';
  } else if (source == 'Ntv.com.tr') {
    sourceIcon = 'assets/newsSourceImages/ntv.png';
  } else if (source == 'Ntvspor.net') {
    sourceIcon = 'assets/newsSourceImages/ntvspor.jpg';
  } else if (source == 'Odatv4.com') {
    sourceIcon = 'assets/newsSourceImages/odatv4.png';
  } else if (source == 'Onedio.com') {
    sourceIcon = 'assets/newsSourceImages/onedio.png';
  } else if (source == 'Posta.com.tr') {
    sourceIcon = 'assets/newsSourceImages/posta.png';
  } else if (source == 'Sabah.com.tr') {
    sourceIcon = 'assets/newsSourceImages/sabah.png';
  } else if (source == 'Shiftdelete.net') {
    sourceIcon = 'assets/newsSourceImages/shiftdelete.png';
  } else if (source == 'Sondakika.com') {
    sourceIcon = 'assets/newsSourceImages/sondakika.png';
  } else if (source == 'Sozcu.com.tr') {
    sourceIcon = 'assets/newsSourceImages/sozcu.png';
  } else if (source == 'Star.com.tr') {
    sourceIcon = 'assets/newsSourceImages/star.png';
  } else if (source == 'Sporx.com') {
    sourceIcon = 'assets/newsSourceImages/sporx.png';
  } else if (source == 'T24.com.tr') {
    sourceIcon = 'assets/newsSourceImages/t24.jpg';
  } else if (source == 'Takvim.com.tr') {
    sourceIcon = 'assets/newsSourceImages/takvim.png';
  } else if (source == 'Teknolojioku.com') {
    sourceIcon = 'assets/newsSourceImages/teknolojioku.png';
  } else if (source == 'Tgrthaber.com.tr') {
    sourceIcon = 'assets/newsSourceImages/tgrthaber.png';
  } else if (source == 'Gazetevatan.com') {
    sourceIcon = 'assets/newsSourceImages/vatan.png';
  } else if (source == 'Webtekno.com') {
    sourceIcon = 'assets/newsSourceImages/webtekno.png';
  } else if (source == 'Yasemin.com') {
    sourceIcon = 'assets/newsSourceImages/yasemin.png';
  } else if (source == 'Yeniakit.com.tr') {
    sourceIcon = 'assets/newsSourceImages/yeniakit.jpg';
  } else if (source == 'Yenicaggazetesi.com.tr') {
    sourceIcon = 'assets/newsSourceImages/yenicag.png';
  } else if (source == 'Yenisafak.com') {
    sourceIcon = 'assets/newsSourceImages/yenisafak.png';
  } else if (source == 'YouTube') {
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
