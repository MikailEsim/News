import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import '../utils/constant.dart';

dynamic getExchangeRates() async {
  final url = exchangeRatesUrl;

  EasyLoading.show(status: 'loading'.tr());
  var response = await http.get(Uri.parse(url));
  EasyLoading.dismiss();
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
    return (jsonResponse);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}
