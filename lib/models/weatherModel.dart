import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import '../utils/constant.dart';

dynamic getWeather(city, lang) async {
  final headers = {"authorization": apiKey, "content-type": "application/json"};
  final url = "$weatherUrl$city&data.lang=$lang";

  var response = await http.get(Uri.parse(url), headers: headers);
  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    return jsonResponse["result"];
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}
