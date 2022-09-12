import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../models/newsModel.dart';

class NewsCategoriesListWidget extends StatefulWidget {
  Function refreshNewsList;
  NewsCategoriesListWidget({super.key, required this.refreshNewsList});

  @override
  State<NewsCategoriesListWidget> createState() =>
      _NewsCategoriesListWidgetState();
}

class _NewsCategoriesListWidgetState extends State<NewsCategoriesListWidget> {
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

  @override
  void initState() {
    super.initState();
  }

  Future<void> getNewsFunc(category) async {
    var response = await getNews(category);
    widget.refreshNewsList(response);
  }

  @override
  Widget build(BuildContext context) {
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
                  await getNewsFunc(selectedCategory),
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
}
