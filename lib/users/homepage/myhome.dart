import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'penjadwalan/theme.dart';

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
    HomeMenu(),
    MyHomePenjadwalan(),
    RoomsPage(),
    ProfilePage()
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
          BottomNavigationBarItem(
              icon: Icon(Icons.contact_mail_rounded), label: 'contact'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'profile')
        ],
      ),
    );
  }
}

List<SetdataTanaman> dataTanaman = [];

class SetdataTanaman {}

class HomeMenu extends StatefulWidget {
  const HomeMenu({super.key});

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

final user = FirebaseAuth.instance.currentUser;

@override
class _HomeMenuState extends State<HomeMenu> {
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    // fetchRecord();
    initState();
  }

  // fetchRecord() async {
  //   var records = await FirebaseFirestore.instance.collection('users').get();
  //   maprecord(records);
  // }

  // maprecord(QuerySnapshot<Map<String, dynamic>> record) {
  //   var _list = record.docs
  //       .map((item) => SetdataTanaman(
  //           namaTanaman: item.data()['NamaTanaman'],
  //           idTanaman: item.data()['id_Tanaman'],
  //           deskripsiTanaman: item.data()['DeskripsiTanaman'],
  //           durasiPemupukan: item.data()['DurasiPemupukan'],
  //           durasiInseksida: item.data()['DurasiInseksida'],
  //           durasiPenyiraman: item.data()['DurasiPenyiraman'],
  //           informasiTanaman: item.data()['InformasiTanaman'],
  //           lamaPanen: item.data()['LamaPanen']))
  //       // : item.data()['userid']))
  //       .toList();
  //   // dataTanaman = _list;
  //   // print(_list);

  //   setState(() {
  //     dataTanaman = _list;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
      children: [
        Container(
          width: size.width * 1,
          height: size.height * 0.2,
          decoration: BoxDecoration(
              color: ColorPelatte.primaryColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
        )
      ],
    ));
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class MyHomePenjadwalan extends StatefulWidget {
  const MyHomePenjadwalan({super.key});

  @override
  State<MyHomePenjadwalan> createState() => _MyHomePenjadwalanState();
}

class _MyHomePenjadwalanState extends State<MyHomePenjadwalan> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class RoomsPage extends StatefulWidget {
  const RoomsPage({super.key});

  @override
  State<RoomsPage> createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
