import 'dart:convert' as convert;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import '../../utils/constant.dart';

dynamic getNews(String tag, String padding) async {
  final header = {"authorization": apiKey, "content-type": "application/json"};
  final url = newApiUrl + tag + '&padding=' + padding;

  EasyLoading.show(status: 'loading'.tr());
  var response = await http.get(Uri.parse(url), headers: header);
  EasyLoading.dismiss();
  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    return jsonResponse["result"];
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}
