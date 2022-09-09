import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:projects/screens/newsDetailScreen.dart';
import 'package:projects/widgets/appbar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/newsModel.dart';
import '../screenUtil.dart';
import '../utils/getSourceImage.dart';
import '../widgets/bottomNavigationBar.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  dynamic generalNewsList = [];
  dynamic categories = [
    {"key": 0, "name": 'general'},
    {"key": 1, "name": 'business'},
    {"key": 2, "name": 'sports'},
    {"key": 3, "name": 'science'},
    {"key": 4, "name": 'technology'},
    {"key": 5, "name": 'health'},
    {"key": 6, "name": 'entertainment'},
  ];

  @override
  void initState() {
    super.initState();
    getGeneralNewsFunc('general');
  }

  Future<void> getGeneralNewsFunc(category) async {
    var response = await getNews(category);
    setState(() {
      generalNewsList = response;
    });
  }

  getCategories(context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...categories.map((category) => GestureDetector(
                  onTap: () async => await getGeneralNewsFunc(category['name']),
                  child: Container(
                      margin: const EdgeInsets.only(right: 10.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xff777777), width: 2.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        category['name'],
                        style: Theme.of(context).textTheme.subtitle1,
                      ).tr()),
                ))
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
                            ],
                          )
                        : Row(),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [Icon(Icons.newspaper)]),
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
