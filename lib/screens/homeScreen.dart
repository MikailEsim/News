import 'package:flutter/material.dart';
import '../models/NewsModel/news.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> generalNewsList = [];

  @override
  void initState() {
    super.initState();
    getGeneralNewsFunc();
  }

  Future<void> getGeneralNewsFunc() async {
    var response = await getNews('general', '3');
    setState(() {
      generalNewsList = response;
    });
  }

  getCategories(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Image.asset('assets/newsSourceImages/aspor.png', width: 50),
            const SizedBox(width: 10),
            Image.asset('assets/newsSourceImages/aspor.png', width: 50),
            const SizedBox(width: 10),
            Image.asset('assets/newsSourceImages/aspor.png', width: 50),
            const SizedBox(width: 10),
            Image.asset('assets/newsSourceImages/aspor.png', width: 50),
            const SizedBox(width: 10),
            Image.asset('assets/newsSourceImages/aspor.png', width: 50),
            const SizedBox(width: 10),
            Image.asset('assets/newsSourceImages/aspor.png', width: 50),
            const SizedBox(width: 10),
            Image.asset('assets/newsSourceImages/aspor.png', width: 50),
            const SizedBox(width: 10),
            Image.asset('assets/newsSourceImages/aspor.png', width: 50),
            const SizedBox(width: 10),
            Image.asset('assets/newsSourceImages/aspor.png', width: 50),
            const SizedBox(width: 10),
            Image.asset('assets/newsSourceImages/aspor.png', width: 50),
            const SizedBox(width: 10),
            Image.asset('assets/newsSourceImages/aspor.png', width: 50),
          ],
        ),
      ),
    );
  }

  getNewList(index) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
      decoration: const BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Color(0xff777777), width: 0.9))),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Row(
                    children: [getNewsSourceIcon(index)],
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
                          generalNewsList[index]["source"],
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          generalNewsList[index]["name"],
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
                        child: Text(
                          generalNewsList[index]["url"],
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: Image.network(
                          generalNewsList[index]["image"],
                          width: 325,
                          height: 200,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getNewsSourceIcon(index) {
    print(generalNewsList[index]["source"]);
    String sourceIcon = 'assets/newsSourceImages/notFoundSource.png';
    if (generalNewsList[index]["source"] == 'Aspor') {
      sourceIcon = 'assets/newsSourceImages/sabah.png';
    } else if (generalNewsList[index]["source"] == 'Birgün') {
      sourceIcon = 'assets/newsSourceImages/birgün.png';
    } else if (generalNewsList[index]["source"] == 'CnnTürk') {
      sourceIcon = 'assets/newsSourceImages/cnnturk.png';
    } else if (generalNewsList[index]["source"] == 'Cumhuriyet') {
      sourceIcon = 'assets/newsSourceImages/cumhuriyet.png';
    } else if (generalNewsList[index]["source"] == 'Dünya') {
      sourceIcon = 'assets/newsSourceImages/dunya.png';
    } else if (generalNewsList[index]["source"] == 'En Son Haber') {
      sourceIcon = 'assets/newsSourceImages/ensonhaber.png';
    } else if (generalNewsList[index]["source"] == 'Fanatik') {
      sourceIcon = 'assets/newsSourceImages/fanatik.png';
    } else if (generalNewsList[index]["source"] == 'Fotomaç') {
      sourceIcon = 'assets/newsSourceImages/fotomac.png';
    } else if (generalNewsList[index]["source"] == 'HaberTürk') {
      sourceIcon = 'assets/newsSourceImages/haberturk.png';
    } else if (generalNewsList[index]["source"] == 'Hürriyet') {
      sourceIcon = 'assets/newsSourceImages/hurriyet.png';
    } else if (generalNewsList[index]["source"] == 'İnternet Haber') {
      sourceIcon = 'assets/newsSourceImages/internethaber.png';
    } else if (generalNewsList[index]["source"] == 'KARAR') {
      sourceIcon = 'assets/newsSourceImages/karar.png';
    } else if (generalNewsList[index]["source"] == 'Milliyet') {
      sourceIcon = 'assets/newsSourceImages/milliyet.png';
    } else if (generalNewsList[index]["source"] == 'Mynet') {
      sourceIcon = 'assets/newsSourceImages/mynet.png';
    } else if (generalNewsList[index]["source"] == 'Ntv') {
      sourceIcon = 'assets/newsSourceImages/ntv.png';
    } else if (generalNewsList[index]["source"] == 'Posta') {
      sourceIcon = 'assets/newsSourceImages/posta.png';
    } else if (generalNewsList[index]["source"] == 'Sabah') {
      sourceIcon = 'assets/newsSourceImages/sabah.png';
    } else if (generalNewsList[index]["source"] == 'Shift Delete') {
      sourceIcon = 'assets/newsSourceImages/shiftdelete.png';
    } else if (generalNewsList[index]["source"] == 'Sözcü') {
      sourceIcon = 'assets/newsSourceImages/Sözcü.png';
    } else if (generalNewsList[index]["source"] == 'Sporx') {
      sourceIcon = 'assets/newsSourceImages/sporx.png';
    }
    return ClipOval(
      child: Image.asset(
        sourceIcon,
        height: 50,
        width: 50,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: generalNewsList.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Column(
              children: [getCategories(context), getNewList(index)],
            );
          } else {
            return Column(
              children: [getNewList(index)],
            );
          }
        });
  }
}
