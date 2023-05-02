import 'package:belajar_firebase/widgets/pages/chat/mychat.dart';
import 'package:belajar_firebase/widgets/pages/penjadwalan/listdata.dart';
import 'package:belajar_firebase/widgets/pages/profile/homeProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


// import 'package:gondur/widget/penjadwalan.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class PageMain extends StatefulWidget {
  const PageMain({super.key});

  @override
  State<PageMain> createState() => _PageMainState();
}

class _PageMainState extends State<PageMain> {
  final sizeheightBuilder = 20;
  final sizeWidthBuilder = 20;
  int _selectedIndex = 0;

  void _navigatorBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    _HomeMenu(),
    PageMain(),
    Mychatt(),
    Myprofile()
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

class _HomeMenu extends StatefulWidget {
  const _HomeMenu({super.key});

  @override
  State<_HomeMenu> createState() => __HomeMenuState();
}

class __HomeMenuState extends State<_HomeMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            actions: [
              IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  icon: Icon(Icons.logout))
            ],
            leading: Container(
              width: 40,
              height: 40,
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(10),
              color: Colors.amber[50],
            ),
            centerTitle: true,
            // expandedHeight: 200,
            title: Text(
              "GONDUR",
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: 20,
              height: 20,
              color: Colors.amber,
              margin: EdgeInsets.all(20),
            ),
          ),
        ],
      ),
    );
  }
}
