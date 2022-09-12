import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final int selectedIndex;
  const BottomNavigationBarWidget(this.selectedIndex, {super.key});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/news');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/exchangeRates');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/settings');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border:
              Border(top: BorderSide(color: Color(0xff777777), width: 0.25))),
      child: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.currency_exchange), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: widget.selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
