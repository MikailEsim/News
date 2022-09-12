import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../screens/newsDetailScreen.dart';
import '../utils/getSourceImage.dart';

class NewsListWidget extends StatefulWidget {
  dynamic news;
  NewsListWidget({super.key, required this.news});

  @override
  State<NewsListWidget> createState() => _NewsListWidgetState();
}

class _NewsListWidgetState extends State<NewsListWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewsDetailScreen(widget.news))),
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
                        getSourceImage(
                            widget.news['source']['name'], 50.0, 50.0)
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
                            '${widget.news['source']['name']} · ${DateFormat('dd.MM.yyyy HH:mm').format(DateTime.parse(widget.news['publishedAt']))}',
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
                            widget.news['title'],
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
                            onTap: () async => {
                              await launchUrl(Uri.parse(widget.news['url']))
                            },
                            child: Text(
                              widget.news['url'],
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    widget.news['urlToImage'] != null
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
                                      widget.news['urlToImage'],
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
                                    'https://www.${widget.news['source']['name'].toString().toLowerCase()}'))
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
                                          widget.news['author'] ?? '',
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
                                              Uri.parse(widget.news['url']))
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
                                                      NewsDetailScreen(
                                                          widget.news))),
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
}
