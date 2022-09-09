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
      langIsTr = prefs.getBool("langIsTr") == true ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<GeneralProvider>(context, listen: true);
    return IconButton(
      icon: langIsTr
          ? Flag.fromCode(FlagsCode.GB, height: 40, width: 40)
          : Flag.fromCode(FlagsCode.TR, height: 40, width: 40),
      onPressed: () {
        if (localeProvider.locale.toString() == 'tr_TR') {
          localeProvider.setLocale(const Locale('en', 'EN'), context);
        } else {
          localeProvider.setLocale(const Locale('tr', 'TR'), context);
        }
        getLang();
      },
    );
  }
}
