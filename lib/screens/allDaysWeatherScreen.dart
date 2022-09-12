import 'package:flutter/material.dart';
import '../screenUtil.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/bottom_navigation_bar_widget.dart';

class AllDaysWeatherScreen extends StatelessWidget {
  const AllDaysWeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          Size.fromHeight(ScreenUtil.elementHeight(context, 60)),
          'All Days Weather'),
      bottomNavigationBar: const BottomNavigationBarWidget(0),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [Text('All Days Weather Screen Coming Soon')]),
      ),
    );
  }
}
