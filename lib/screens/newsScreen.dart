import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:projects/screens/newsDetailScreen.dart';
import 'package:projects/widgets/appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/newsModel.dart';
import '../models/weatherModel.dart';
import '../screenUtil.dart';
import '../utils/getSourceImage.dart';
import '../widgets/bottomNavigationBar.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List citiesList = [];
  dynamic currentCityId;
  dynamic weatherList;
  String currentCity = 'Ankara';
  dynamic categories = [
    {"key": 0, "name": 'general'},
    {"key": 1, "name": 'business'},
    {"key": 2, "name": 'sports'},
    {"key": 3, "name": 'science'},
    {"key": 4, "name": 'technology'},
    {"key": 5, "name": 'health'},
    {"key": 6, "name": 'entertainment'},
  ];
  dynamic selectedCategory = 'general';
  dynamic generalNewsList = [];

  @override
  void initState() {
    super.initState();
    getCitiesFunc();
    getCurrentLocation();
    getNewsFunc('general');
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final locale = prefs.getBool("langIsTr") == true ? 'tr' : 'en';
    var checkPermission = await Geolocator.checkPermission();
    if (checkPermission == LocationPermission.whileInUse ||
        checkPermission == LocationPermission.always) {
      EasyLoading.show(status: 'loading'.tr());
      var position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      citiesList.forEach((city) => {
            if ((((double.parse(city['latitude'].toString()) -
                            double.parse(position.latitude.toString()))
                        .abs()) <
                    0.5) &&
                (((double.parse(city['longitude'].toString()) -
                            double.parse(position.longitude.toString()))
                        .abs()) <
                    0.5))
              {
                setState(() {
                  currentCityId = 6;
                  currentCity = city['name'];
                }),
                getWeatherFunc(city, locale),
                EasyLoading.dismiss(),
              },
          });
    } else {
      setState(() {
        currentCityId = 6;
        currentCity = 'Ankara';
      });
      getWeatherFunc(currentCity, locale);
    }
  }

  Future<void> getWeatherFunc(city, lang) async {
    var response = await getWeather(city.toString().toLowerCase(), lang);
    setState(() {
      weatherList = response;
    });
  }

  Future<void> getNewsFunc(category) async {
    var response = await getNews(category);
    setState(() {
      generalNewsList = response;
    });
  }

  getCategories(context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...categories.map(
              (category) => GestureDetector(
                onTap: () async => {
                  setState(() {
                    selectedCategory = category['name'];
                  }),
                  await getNewsFunc(category['name']),
                },
                child: Container(
                    margin: const EdgeInsets.only(right: 10.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: selectedCategory == category['name']
                          ? Colors.blue
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      category['name'],
                      style: selectedCategory == category['name']
                          ? const TextStyle(
                              color: Colors.white,
                              fontSize: 17.5,
                              fontWeight: FontWeight.bold)
                          : Theme.of(context).textTheme.subtitle1,
                    ).tr()),
              ),
            )
          ],
        ),
      ),
    );
  }

  getCurrentDayWeather(context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Column(
              children: [
                GestureDetector(
                    onTap: () {
                      print('show all week weather');
                    },
                    child: Icon(Icons.clear_all))
              ],
            ),
            const SizedBox(width: 5.0),
            Column(children: [
              Text('·', style: Theme.of(context).textTheme.headline6)
            ]),
            const SizedBox(width: 5.0),
            Column(
              children: [
                Text(currentCity, style: Theme.of(context).textTheme.bodyText1)
              ],
            ),
            const SizedBox(width: 5.0),
            Column(children: [
              Text('·', style: Theme.of(context).textTheme.headline6)
            ]),
            const SizedBox(width: 5.0),
            Column(
              children: [
                Text(weatherList[0]['date'] + ' ' + weatherList[0]['day'],
                    style: Theme.of(context).textTheme.bodyText1)
              ],
            ),
            const SizedBox(width: 5.0),
            Column(children: [
              Text('·', style: Theme.of(context).textTheme.headline6)
            ]),
            const SizedBox(width: 5.0),
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
              Text('·', style: Theme.of(context).textTheme.headline6)
            ]),
            const SizedBox(width: 5.0),
            Column(
              children: [
                Text(weatherList[0]['description'],
                    style: Theme.of(context).textTheme.bodyText1)
              ],
            ),
            const SizedBox(width: 5.0),
            Column(children: [
              Text('·', style: Theme.of(context).textTheme.headline6)
            ]),
            const SizedBox(width: 5.0),
            Column(
              children: [
                Text(weatherList[0]['degree'],
                    style: Theme.of(context).textTheme.bodyText1)
              ],
            ),
            const SizedBox(width: 5.0),
            Column(children: [
              Text('·', style: Theme.of(context).textTheme.headline6)
            ]),
            const SizedBox(width: 5.0),
            Column(
              children: [
                Text(weatherList[0]['min'],
                    style: Theme.of(context).textTheme.bodyText1)
              ],
            ),
            const SizedBox(width: 5.0),
            Column(children: [
              Text('·', style: Theme.of(context).textTheme.headline6)
            ]),
            const SizedBox(width: 5.0),
            Column(
              children: [
                Text(weatherList[0]['max'],
                    style: Theme.of(context).textTheme.bodyText1)
              ],
            ),
            const SizedBox(width: 5.0),
            Column(children: [
              Text('·', style: Theme.of(context).textTheme.headline6)
            ]),
            const SizedBox(width: 5.0),
            Column(
              children: [
                Text(weatherList[0]['night'],
                    style: Theme.of(context).textTheme.bodyText1)
              ],
            ),
            const SizedBox(width: 5.0),
            Column(children: [
              Text('·', style: Theme.of(context).textTheme.headline6)
            ]),
            const SizedBox(width: 5.0),
            Column(
              children: [
                Text(weatherList[0]['humidity'],
                    style: Theme.of(context).textTheme.bodyText1)
              ],
            ),
          ],
        ),
      ),
    );
  }

  getNewList(context, news) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NewsDetailScreen(news))),
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Color(0xff777777), width: 0.9))),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Row(
                      children: [
                        getSourceImage(news['source']['name'], 50.0, 50.0)
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 10,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${news['source']['name']} · ${DateFormat('dd.MM.yyyy HH:mm').format(DateTime.parse(news['publishedAt']))}',
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            news['title'],
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async =>
                                {await launchUrl(Uri.parse(news['url']))},
                            child: Text(
                              news['url'],
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    news['urlToImage'] != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: SizedBox(
                                  width: 310,
                                  height: 200,
                                  child: InteractiveViewer(
                                    boundaryMargin: const EdgeInsets.all(80),
                                    panEnabled: false,
                                    scaleEnabled: true,
                                    minScale: 1.0,
                                    maxScale: 2.2,
                                    child: Image.network(
                                      news['urlToImage'],
                                      fit: BoxFit.fill,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return const Text('');
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Row(),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        Expanded(
                          flex: 12,
                          child: Column(children: [
                            GestureDetector(
                              onTap: () async => {
                                await launchUrl(Uri.parse(
                                    'https://www.${news['source']['name'].toString().toLowerCase()}'))
                              },
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: const [
                                        Icon(Icons.newspaper),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 5.0),
                                  Expanded(
                                    flex: 10,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          news['author'] ?? '',
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.start,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ]),
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                    onTap: () async => {
                                          await launchUrl(
                                              Uri.parse(news['url']))
                                        },
                                    child: const Icon(Icons.link))
                              ]),
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                GestureDetector(
                                    onTap: () => {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      NewsDetailScreen(news))),
                                        },
                                    child: const Icon(Icons.info_outline))
                              ]),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          Size.fromHeight(ScreenUtil.elementHeight(context, 60)), 'homePage'),
      bottomNavigationBar: const CustomBottomNavigationBar(0),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Row(children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [getCategories(context)],
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          weatherList != null
                              ? getCurrentDayWeather(context)
                              : const Text('')
                        ],
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              ...generalNewsList
                                  ?.map((news) => getNewList(context, news))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
