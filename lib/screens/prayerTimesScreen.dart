import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:projects/models/prayerTimesModel.dart';
import 'package:provider/provider.dart';
import '../provider/general_provider.dart';
import '../screenUtil.dart';
import '../widgets/appbar.dart';
import '../widgets/bottomNavigationBar.dart';

class PrayerTimesScreen extends StatefulWidget {
  const PrayerTimesScreen({super.key});

  @override
  State<PrayerTimesScreen> createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
  List citiesList = [];
  dynamic selectedValueId;
  dynamic selectedValueName;
  dynamic latitude;
  dynamic longitude;
  dynamic prayerTimes = [];
  dynamic currentDate;
  dynamic currentTime;
  dynamic getNextPrayerTime;

  @override
  void initState() {
    super.initState();
    getCitiesFunc();
    getCurrentLocation();
  }

  Future<dynamic> getCitiesFunc() async {
    dynamic response = await rootBundle
        .loadString('assets/citiesOfTurkey/citiesOfTurkey.json');
    dynamic data = json.decode(response);
    setState(() {
      citiesList = data;
    });
  }

  Future<void> getCurrentLocation() async {
    var checkPermission = await Geolocator.checkPermission();
    if (checkPermission == LocationPermission.whileInUse ||
        checkPermission == LocationPermission.always) {
      var position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;
      });
      citiesList.forEach((city) => {
            if ((((double.parse(city['latitude'].toString()) -
                            double.parse(latitude.toString()))
                        .abs()) <
                    0.5) &&
                (((double.parse(city['longitude'].toString()) -
                            double.parse(longitude.toString()))
                        .abs()) <
                    0.5))
              {
                setState(() {
                  selectedValueId = int.parse(city['id'].toString());
                  selectedValueName = city['name'].toString();
                }),
                getPrayerTimesFunc()
              },
          });
    } else {
      await Geolocator.requestPermission();
      getCurrentLocation();
    }
  }

  Future<void> getPrayerTimesFunc() async {
    var response =
        await getPrayerTimes(selectedValueName.toString().toLowerCase());
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
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Row(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Text(
                    time['vakit'] + ' : ',
                    style: Theme.of(context).textTheme.subtitle1,
                  )
                ],
              )
            ],
          ),
          Column(children: [
            Text(time['saat'], style: Theme.of(context).textTheme.bodyText1)
          ]),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (prayerTimes?.length > (0)) {
      getCurrentTime(context);
    }
    return Scaffold(
        appBar: CustomAppBar(
            Size.fromHeight(ScreenUtil.elementHeight(context, 60)),
            'prayerTimes'),
        bottomNavigationBar: const CustomBottomNavigationBar(2),
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(children: [
                      Expanded(
                        child: Column(
                          children: [
                            DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                items: citiesList.map((value) {
                                  return DropdownMenuItem(
                                    value: value['id'],
                                    child: Text(
                                      value['name'],
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                  );
                                }).toList(),
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      ?.color,
                                ),
                                value: selectedValueId ?? 1,
                                onChanged: (value) {
                                  citiesList.forEach((city) {
                                    if (city['id'].toString() ==
                                        value.toString()) {
                                      setState(() {
                                        selectedValueId =
                                            int.parse(city['id'].toString());
                                        selectedValueName =
                                            city['name'].toString();
                                      });
                                    }
                                  });
                                  getPrayerTimesFunc();
                                },
                                iconEnabledColor: Colors.white,
                                buttonHeight: 55,
                                buttonWidth: 250,
                                buttonPadding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                buttonDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.grey,
                                ),
                                itemHeight: 40,
                                itemPadding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                dropdownMaxHeight: 200,
                                dropdownWidth: 250,
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ]),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          currentDate != null
                              ? Text(currentDate,
                                  style: Theme.of(context).textTheme.headline6)
                              : Text('')
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Row(children: [
                                Text(
                                  "Vaktin Çıkmasına",
                                  style: Theme.of(context).textTheme.headline6,
                                )
                              ]),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Row(children: [
                                  getNextPrayerTime != null
                                      ? Text(getNextPrayerTime.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6)
                                      : const Text('')
                                ]),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            ...prayerTimes?.map(
                                (time) => getPrayerTimesList(context, time))
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
