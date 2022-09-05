import 'package:flutter/material.dart';
import 'package:projects/utils/getSourceImage.dart';
import 'package:url_launcher/url_launcher.dart';
import '../screenUtil.dart';
import '../widgets/appbar.dart';
import '../widgets/bottomNavigationBar.dart';

class NewsDetailScreen extends StatefulWidget {
  final dynamic news;
  const NewsDetailScreen(this.news, {super.key});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            Size.fromHeight(ScreenUtil.elementHeight(context, 60)),
            'newsDetail'),
        bottomNavigationBar: const CustomBottomNavigationBar(0),
        body: Container(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    IntrinsicHeight(
                      child: Row(children: [
                        Expanded(
                          flex: 2,
                          child: Column(children: [
                            getSourceImage(widget.news['source'], 60.0, 60.0)
                          ]),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          flex: 10,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    widget.news['source'],
                                    textAlign: TextAlign.left,
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(widget.news['name'],
                                            textAlign: TextAlign.left,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ]),
                    ),
                    const SizedBox(height: 15.0),
                    Row(children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              widget.news['description'],
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ),
                    ]),
                    const SizedBox(height: 15.0),
                    Row(children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              widget.news['url'],
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
                        ),
                      ),
                    ]),
                    const SizedBox(height: 15.0),
                    Row(
                      children: [
                        widget.news["image"]?.length > 0
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: SizedBox(
                                        width: 380,
                                        height: 200,
                                        child: Image.network(
                                          widget.news["image"],
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
                            : Row()
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [Icon(Icons.newspaper)]),
                        ),
                        Expanded(
                          flex: 8,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                GestureDetector(
                                    onTap: () async => {
                                          await launchUrl(
                                              Uri.parse(widget.news["url"]))
                                        },
                                    child: const Icon(Icons.link))
                              ]),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
