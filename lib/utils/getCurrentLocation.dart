import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'getCities.dart';

Future<dynamic> getCurrentLocation(int controlRequestPermission) async {
  EasyLoading.show(status: 'loading'.tr());
  var currentCity = {'plate': 1, 'name': 'Adana'};
  var checkPermission = await Geolocator.checkPermission();
  if (checkPermission != LocationPermission.whileInUse &&
      checkPermission != LocationPermission.always &&
      checkPermission == LocationPermission.denied &&
      controlRequestPermission == 1) {
    await Geolocator.requestPermission();
  }
  if (checkPermission == LocationPermission.whileInUse ||
      checkPermission == LocationPermission.always) {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var cities = await getCities();
    cities.forEach((city) => {
          if ((((double.parse(city['latitude'].toString()) -
                          double.parse(position.latitude.toString()))
                      .abs()) <
                  0.5) &&
              (((double.parse(city['longitude'].toString()) -
                          double.parse(position.longitude.toString()))
                      .abs()) <
                  0.5))
            {
              currentCity = {
                'plate': city['id'],
                'name': city['name'],
              },
            },
        });
  }
  EasyLoading.dismiss();
  return currentCity;
}
