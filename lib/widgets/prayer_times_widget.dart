import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:projects/models/prayerTimesModel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/general_provider.dart';
import '../utils/getCurrentLocation.dart';

class PrayerTimesWidget extends StatefulWidget {
  Function closePrayerTimesAndWeather;
  PrayerTimesWidget({super.key, required this.closePrayerTimesAndWeather});

  @override
  State<PrayerTimesWidget> createState() => _PrayerTimesWidgetState();
}

class _PrayerTimesWidgetState extends State<PrayerTimesWidget> {
  dynamic currentCity;
  dynamic prayerTimes = [];
  dynamic currentDate;
  dynamic currentTime;
  dynamic getNextPrayerTime;
  bool closePrayerTimes = false;

  @override
  void initState() {
    super.initState();
    getCurrentInfo();
  }

  Future<dynamic> getCurrentInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var currentCityTemp = await getCurrentLocation(1);
    setState(() {
      currentCity = currentCityTemp;
      closePrayerTimes =
          prefs.getBool("closePrayerTimesAndWeather") == true ? true : false;
    });
    getPrayerTimesFunc();
  }

  Future<void> getPrayerTimesFunc() async {
    var response =
        await getPrayerTimes(currentCity['name'].toString().toLowerCase());
    setState(() {
      prayerTimes = response;
    });
  }

  getCurrentTime(context) {
    final localeProvider = Provider.of<GeneralProvider>(context);
    final dateFormat1 =
        DateFormat('dd MMMM yyyy EEEE HH:mm', localeProvider.locale.toString());
    final dateFormat2 =
        DateFormat('HH:mm:ss', localeProvider.locale.toString());
    final now = DateTime.now();
    setState(() {
      currentDate = dateFormat1.format(now);
      currentTime = dateFormat2.format(now);
    });
    DateTime startDate;
    DateTime endDate;
    List getNextPrayerTimeTemp = [];
    prayerTimes.forEach((time) => {
          startDate = DateFormat("HH:mm:ss", localeProvider.locale.toString())
              .parse(currentTime),
          endDate = DateFormat("HH:mm:ss", localeProvider.locale.toString())
              .parse(
                  dateFormat2.format(DateFormat("HH:mm").parse(time['saat']))),
          if (endDate.difference(startDate).inMilliseconds > 0 &&
              !getNextPrayerTimeTemp.isNotEmpty)
            {getNextPrayerTimeTemp.add(endDate.difference(startDate))},
        });
    var splittedDuration = getNextPrayerTimeTemp[0].toString().split('.')[0];
    setState(() {
      getNextPrayerTime =
          splittedDuration.toString().split(':')[0].length == (1)
              ? '0$splittedDuration'
              : splittedDuration;
    });
  }

  getPrayerTimesList(context, time) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 5.0),
            Column(children: [
              Text('·', style: Theme.of(context).textTheme.headline6)
            ]),
            const SizedBox(width: 5.0),
            Column(children: [
              Text(
                time['vakit'] + ' : ',
                style: Theme.of(context).textTheme.bodyText1,
              )
            ]),
            Column(children: [
              Text(time['saat'], style: Theme.of(context).textTheme.bodyText1)
            ])
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (prayerTimes?.length > (0)) {
      getCurrentTime(context);
    }
    return prayerTimes.length > 0
        ? Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(children: [
                              currentDate != null
                                  ? Text(currentDate,
                                      style:
                                          Theme.of(context).textTheme.bodyText1)
                                  : const Text(''),
                            ]),
                            const SizedBox(width: 5.0),
                            Column(children: [
                              Text('·',
                                  style: Theme.of(context).textTheme.headline6)
                            ]),
                            const SizedBox(width: 5.0),
                            Column(children: [
                              Text(
                                currentCity['name'],
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ]),
                            const SizedBox(width: 10.0),
                            Column(children: [
                              GestureDetector(
                                  onTap: () async {
                                    closePrayerTimes = !closePrayerTimes;
                                    widget.closePrayerTimesAndWeather(
                                        closePrayerTimes);
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setBool("closePrayerTimesAndWeather",
                                        closePrayerTimes);
                                  },
                                  child: closePrayerTimes
                                      ? const Icon(Icons.arrow_drop_down)
                                      : const Icon(Icons.arrow_drop_up)),
                            ]),
                          ]),
                      const SizedBox(height: 5.0),
                      !closePrayerTimes
                          ? Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Column(children: const [
                                              Icon(Icons.access_time)
                                            ]),
                                          ),
                                          Expanded(
                                            flex: 10,
                                            child: Column(children: [
                                              SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(children: [
                                                  Column(children: [
                                                    Text(
                                                      "timeToCome",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1,
                                                    ).tr(),
                                                  ]),
                                                  Column(children: [
                                                    Text(
                                                        getNextPrayerTime
                                                            .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1),
                                                  ]),
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          ...prayerTimes?.map(
                                                              (time) =>
                                                                  getPrayerTimesList(
                                                                      context,
                                                                      time))
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                ]),
                                              )
                                            ]),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          : const SizedBox(
                              height: 0,
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
