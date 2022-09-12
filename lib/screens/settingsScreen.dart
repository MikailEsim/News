import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../screenUtil.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/bottom_navigation_bar_widget.dart';
import '../widgets/change_language_button_widget.dart';
import '../widgets/change_theme_button_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          Size.fromHeight(ScreenUtil.elementHeight(context, 60)), 'settings'),
      bottomNavigationBar: const BottomNavigationBarWidget(2),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("changeLanguge",
                                    style:
                                        Theme.of(context).textTheme.subtitle1)
                                .tr()
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [ChangeLanguageButtonWidget()],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('changeTheme',
                                    style:
                                        Theme.of(context).textTheme.subtitle1)
                                .tr()
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [ChangeThemeButtonWidget()],
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
}
