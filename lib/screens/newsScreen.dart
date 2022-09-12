import 'package:flutter/material.dart';
import 'package:projects/widgets/appbar_widget.dart';
import 'package:projects/widgets/current_day_weather_widget.dart';
import 'package:projects/widgets/prayer_times_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/newsModel.dart';
import '../screenUtil.dart';
import '../widgets/bottom_navigation_bar_widget.dart';
import '../widgets/news_categories_list_widget.dart';
import '../widgets/news_list_widget.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  dynamic newsList = [];
  bool closeWeather = false;

  @override
  void initState() {
    super.initState();
    getNewsFunc('general');
  }

  Future<void> getNewsFunc(category) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await getNews(category);
    setState(() {
      newsList = response;
      closeWeather =
          prefs.getBool("closePrayerTimesAndWeather") == true ? true : false;
    });
  }

  refreshNewsList(newNewsList) {
    setState(() {
      newsList = newNewsList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          Size.fromHeight(ScreenUtil.elementHeight(context, 60)), 'homePage'),
      bottomNavigationBar: const BottomNavigationBarWidget(0),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Row(children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(children: [
                        NewsCategoriesListWidget(
                            refreshNewsList: (newNewsList) =>
                                refreshNewsList(newNewsList))
                      ]),
                    )
                  ],
                ),
                SizedBox(
                  height: closeWeather ? 34 : 60,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(children: [
                          PrayerTimesWidget(
                            closePrayerTimesAndWeather: (value) => {
                              setState(() {
                                closeWeather = value;
                              })
                            },
                          )
                        ]),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: closeWeather ? 0 : 35,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(children: [
                          CurrentDayWeatherWidget(closeWeather: closeWeather)
                        ]),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(children: [
                            ...newsList
                                ?.map((news) => NewsListWidget(news: news))
                          ]),
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
