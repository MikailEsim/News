import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/general_provider.dart';

class ChangeLanguageButtonWidget extends StatefulWidget {
  const ChangeLanguageButtonWidget({super.key});

  @override
  State<ChangeLanguageButtonWidget> createState() =>
      _ChangeLanguageButtonWidgetState();
}

class _ChangeLanguageButtonWidgetState
    extends State<ChangeLanguageButtonWidget> {
  bool langIsTr = true;

  @override
  void initState() {
    super.initState();
    getLang();
  }

  getLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      langIsTr = prefs.getBool("langIsTr") == null
          ? true
          : prefs.getBool("langIsTr") == true
              ? true
              : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<GeneralProvider>(context, listen: true);
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              IconButton(
                icon: Flag.fromCode(FlagsCode.TR),
                onPressed: () {
                  if (langIsTr) {
                    localeProvider.setLocale(const Locale('en', 'EN'), context);
                  } else {
                    localeProvider.setLocale(const Locale('tr', 'TR'), context);
                  }
                  getLang();
                },
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Switch.adaptive(
                  value: !langIsTr,
                  onChanged: (value) {
                    if (value) {
                      localeProvider.setLocale(
                          const Locale('en', 'EN'), context);
                    } else {
                      localeProvider.setLocale(
                          const Locale('tr', 'TR'), context);
                    }
                    getLang();
                  }),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              IconButton(
                icon: Flag.fromCode(FlagsCode.GB),
                onPressed: () {
                  if (langIsTr) {
                    localeProvider.setLocale(const Locale('en', 'EN'), context);
                  } else {
                    localeProvider.setLocale(const Locale('tr', 'TR'), context);
                  }
                  getLang();
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
