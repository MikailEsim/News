import 'package:flutter/material.dart';
import '../screenUtil.dart';
import '../widgets/appbar.dart';
import '../widgets/bottomNavigationBar.dart';

class PrayerTimesScreen extends StatelessWidget {
  const PrayerTimesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            Size.fromHeight(ScreenUtil.elementHeight(context, 60)),
            'prayerTimes'),
        bottomNavigationBar: const CustomBottomNavigationBar(2),
        body: Text('Prayer Times Screen'));
  }
}
