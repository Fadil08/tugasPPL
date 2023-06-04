import 'package:flutter/material.dart';

import '../../users/chat/mychat.dart';
import '../../users/profile/homeProfile.dart';
import '../../users/penjadwalan/homePenjadwalan.dart';

class PageMainAdmin extends StatefulWidget {
  const PageMainAdmin({super.key});

  @override
  State<PageMainAdmin> createState() => _PageMainAdminState();
}

class _PageMainAdminState extends State<PageMainAdmin> {
  int _selectedIndex = 0;

  void _navigatorBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    myHomeAdmin(),
    MyHomePenjadwalan(),
    Mychatt(),
    myProfile()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _navigatorBottomBar,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined), label: 'Noted'),
          BottomNavigationBarItem(icon: Icon(Icons.payment), label: 'Payment'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'user')
        ],
      ),
    );
  }
}


class myHomeAdmin extends StatefulWidget {
  const myHomeAdmin({super.key});

  @override
  State<myHomeAdmin> createState() => _myHomeAdminState();
}

class _myHomeAdminState extends State<myHomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
