import 'dart:convert';
import 'package:flutter/services.dart';

Future<dynamic> getCities() async {
  dynamic response =
      await rootBundle.loadString('assets/citiesOfTurkey/citiesOfTurkey.json');
  return json.decode(response);
}
