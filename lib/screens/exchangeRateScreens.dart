import 'package:flutter/material.dart';
import '../screenUtil.dart';
import '../widgets/appbar.dart';
import '../widgets/bottomNavigationBar.dart';

class ExchangeRatesScreen extends StatelessWidget {
  const ExchangeRatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            Size.fromHeight(ScreenUtil.elementHeight(context, 60)),
            'exchangeRates'),
        bottomNavigationBar: const CustomBottomNavigationBar(1),
        body: Text('Exchange Rate Screen'));
  }
}
