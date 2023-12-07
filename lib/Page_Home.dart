import 'package:belajar_firebase/users/chat/chatpage.dart';
import 'package:belajar_firebase/users/chat/chatuser/rooms.dart';
import 'package:belajar_firebase/users/profile/myprofile.dart';

import 'package:belajar_firebase/users/penjadwalan/homePenjadwalan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:belajar_firebase/widgets/pages/users/profile/homeProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'widgets/descripriont.dart';
import 'package:belajar_firebase/utils/theme.dart';

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
    LisContactPakar(),
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

  // @override
  // void initState() {
  //   fetchRecord();
  //   initState();
  // }

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

class TrendingMovies extends StatefulWidget {
  const TrendingMovies({super.key});

  @override
  State<TrendingMovies> createState() => _TrendingMoviesState();
}

class _TrendingMoviesState extends State<TrendingMovies> {
  // @override
  // void initState() {
  //   // fetchRecord();
  //   initState();
  // }

  @override
  Widget build(BuildContext context) {
    List trending = [];
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trending Movies',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 10),
          Container(
              height: 270,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: trending.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Description(
                                      name: trending[index]['title'],
                                      bannerurl:
                                          'https://image.tmdb.org/t/p/w500' +
                                              trending[index]['backdrop_path'],
                                      posterurl:
                                          'https://image.tmdb.org/t/p/w500' +
                                              trending[index]['imageURL'],
                                      description: trending[index]['overview'],
                                    )));
                      },
                      child: Container(
                        width: 140,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500' +
                                          trending[index]['poster_path']),
                                ),
                              ),
                              height: 200,
                            ),
                            SizedBox(height: 5),
                            Container(
                              child: modified_text(
                                  size: 15,
                                  text: trending[index]['title'] != null
                                      ? trending[index]['title']
                                      : 'Loading'),
                            )
                          ],
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }

  modified_text({required int size, required text}) {}
}
