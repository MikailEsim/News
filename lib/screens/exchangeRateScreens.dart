import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/exchangeRatesModel.dart';
import '../provider/general_provider.dart';
import '../screenUtil.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/bottom_navigation_bar_widget.dart';

class ExchangeRatesScreen extends StatefulWidget {
  const ExchangeRatesScreen({super.key});

  @override
  State<ExchangeRatesScreen> createState() => _ExchangeRatesScreenState();
}

class _ExchangeRatesScreenState extends State<ExchangeRatesScreen> {
  dynamic exchangeRatesList = [];
  dynamic exchangeRatesUpdateDate = null;

  @override
  void initState() {
    super.initState();
    getExchangeRatesFunc();
  }

  Future<void> getExchangeRatesFunc() async {
    var response = await getExchangeRates();
    dynamic exchangeRates;
    setState(() {
      exchangeRates = response;
    });
    exchangeRates.forEach((key, value) {
      if (key != 'Update_Date') {
        exchangeRatesList.add({"exchange_name": key, "exchange_data": value});
      } else {
        setState(() {
          exchangeRatesUpdateDate = {"date": value};
        });
      }
    });
  }

  getExchangeRatesList(context, exchangeRate) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          exchangeRate['exchange_name']
                                      .toString()
                                      .contains("ons") ||
                                  exchangeRate['exchange_name']
                                      .toString()
                                      .contains("altin") ||
                                  exchangeRate['exchange_name']
                                      .toString()
                                      .contains("bilezik") ||
                                  exchangeRate['exchange_name']
                                      .toString()
                                      .contains("gumus")
                              ? Text(
                                  exchangeRate['exchange_name'],
                                  style: Theme.of(context).textTheme.subtitle2,
                                ).tr()
                              : Text(
                                  exchangeRate['exchange_name'],
                                  style: Theme.of(context).textTheme.subtitle2,
                                )
                        ],
                      )),
                  Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  Icon(
                                    exchangeRate['exchange_data']['De??i??im']
                                            .toString()
                                            .contains('-')
                                        ? Icons.arrow_drop_down
                                        : Icons.arrow_drop_up,
                                    color: exchangeRate['exchange_data']
                                                ['De??i??im']
                                            .toString()
                                            .contains('-')
                                        ? Colors.red
                                        : Colors.green,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    exchangeRate['exchange_data']['De??i??im'],
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      )),
                  Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            exchangeRate['exchange_data']['Al????'],
                            style: Theme.of(context).textTheme.bodyText1,
                          )
                        ],
                      )),
                  Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            exchangeRate['exchange_data']['Sat????'],
                            style: Theme.of(context).textTheme.bodyText1,
                          )
                        ],
                      )),
                ],
              ),
              Row(
                children: const [
                  SizedBox(
                    height: 10.0,
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  getLastUpdateDate(context, date) {
    final localeProvider = Provider.of<GeneralProvider>(context);
    final dateFormat =
        DateFormat('dd MMMM yyyy HH:mm', localeProvider.locale.toString());
    return dateFormat.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          Size.fromHeight(ScreenUtil.elementHeight(context, 60)),
          'exchangeRates'),
      bottomNavigationBar: const BottomNavigationBarWidget(1),
      body: Row(children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  color: Colors.blue,
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("type",
                                    style: TextStyle(
                                        fontSize: 17.5,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))
                                .tr()
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text("change",
                                    style: TextStyle(
                                        fontSize: 17.5,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))
                                .tr()
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text("buying",
                                    style: TextStyle(
                                        fontSize: 17.5,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))
                                .tr()
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text("selling",
                                    style: TextStyle(
                                        fontSize: 17.5,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))
                                .tr()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 45,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 9.0, right: 9.0, top: 10.0, bottom: 10.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              ...exchangeRatesList?.map((exchangeRate) =>
                                  getExchangeRatesList(context, exchangeRate))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('lastUpdate',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))
                          .tr(),
                      Text(
                        exchangeRatesUpdateDate != null
                            ? getLastUpdateDate(context,
                                DateTime.parse(exchangeRatesUpdateDate['date']))
                            : '',
                        style:
                            const TextStyle(fontSize: 15, color: Colors.white),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
