import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/weatherModel.dart';
import '../screens/allDaysWeatherScreen.dart';
import '../utils/getCurrentLocation.dart';

class CurrentDayWeatherWidget extends StatefulWidget {
  bool closeWeather;
  CurrentDayWeatherWidget({super.key, required this.closeWeather});

  @override
  State<CurrentDayWeatherWidget> createState() =>
      _CurrentDayWeatherWidgetState();
}

class _CurrentDayWeatherWidgetState extends State<CurrentDayWeatherWidget> {
  dynamic currentCity;
  dynamic locale = 'tr';
  dynamic weatherList;

  @override
  void initState() {
    super.initState();
    getCurrentInfo();
  }

  Future<dynamic> getCurrentInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final localeTemp = prefs.getBool("langIsTr") == true ? 'tr' : 'en';
    var currentCityTemp = await getCurrentLocation(0);
    setState(() {
      currentCity = currentCityTemp;
      locale = localeTemp;
    });
    getWeatherFunc();
  }

  Future<void> getWeatherFunc() async {
    var response =
        await getWeather(currentCity['name'].toString().toLowerCase(), locale);
    setState(() {
      weatherList = response;
    });
  }

  getTitleCapitalized(string) {
    var splitString = string.split(' ');
    var titleString = splitString.length == 1
        ? splitString[0][0].toUpperCase() + splitString[0].substring(1)
        : splitString[0][0].toUpperCase() +
            splitString[0].substring(1) +
            ' ' +
            splitString[1][0].toUpperCase() +
            splitString[1].substring(1);
    return titleString;
  }

  @override
  Widget build(BuildContext context) {
    return widget.closeWeather == false && weatherList != null
        ? Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AllDaysWeatherScreen()));
                          },
                          child: const Icon(Icons.list))
                    ],
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                    getTitleCapitalized(
                                        weatherList[0]['description']),
                                    style:
                                        Theme.of(context).textTheme.bodyText1)
                              ],
                            ),
                            const SizedBox(width: 7.5),
                            Column(
                              children: [
                                Image.network(
                                  weatherList[0]['icon'],
                                  width: 25.0,
                                  height: 25.0,
                                )
                              ],
                            ),
                            const SizedBox(width: 5.0),
                            Column(children: [
                              Text('·',
                                  style: Theme.of(context).textTheme.headline6)
                            ]),
                            const SizedBox(width: 5.0),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text('degree',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1)
                                        .tr(),
                                    Text(weatherList[0]['degree'] + '°C',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1)
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(width: 5.0),
                            Column(children: [
                              Text('·',
                                  style: Theme.of(context).textTheme.headline6)
                            ]),
                            const SizedBox(width: 5.0),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text('minDegree',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1)
                                        .tr(),
                                    Text(weatherList[0]['min'] + '°C',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1)
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(width: 5.0),
                            Column(children: [
                              Text('·',
                                  style: Theme.of(context).textTheme.headline6)
                            ]),
                            const SizedBox(width: 5.0),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text('maxDegree',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1)
                                        .tr(),
                                    Text(weatherList[0]['max'] + '°C',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1)
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(width: 5.0),
                            Column(children: [
                              Text('·',
                                  style: Theme.of(context).textTheme.headline6)
                            ]),
                            const SizedBox(width: 5.0),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text('nightDegree',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1)
                                        .tr(),
                                    Text(weatherList[0]['night'] + '°C',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1)
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(width: 5.0),
                            Column(children: [
                              Text('·',
                                  style: Theme.of(context).textTheme.headline6)
                            ]),
                            const SizedBox(width: 5.0),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text('humidity',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1)
                                        .tr(),
                                    Text('%' + weatherList[0]['humidity'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1)
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : const Text('');
  }
}
