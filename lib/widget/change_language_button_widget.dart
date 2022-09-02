import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/general_provider.dart';

class ChangeLanguageButtonWidget extends StatefulWidget {
  const ChangeLanguageButtonWidget({super.key});

  @override
  State<ChangeLanguageButtonWidget> createState() =>
      _ChangeLanguageButtonWidgetState();
}

class _ChangeLanguageButtonWidgetState
    extends State<ChangeLanguageButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<GeneralProvider>(context, listen: true);

    return IconButton(
      icon: localeProvider.locale.toString() == 'tr_TR'
          ? Flag.fromCode(FlagsCode.GB, height: 40, width: 40)
          : Flag.fromCode(FlagsCode.TR, height: 40, width: 40),
      onPressed: () {
        if (localeProvider.locale.toString() == 'tr_TR') {
          localeProvider.setLocale(const Locale('en', 'EN'), context);
        } else {
          localeProvider.setLocale(const Locale('tr', 'TR'), context);
        }
      },
    );
  }
}
