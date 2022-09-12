import 'dart:convert' as convert;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import '../utils/constant.dart';

dynamic getNews(String category) async {
  final url = '$newsApiUrl$category';

  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    return jsonResponse["articles"];
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}
