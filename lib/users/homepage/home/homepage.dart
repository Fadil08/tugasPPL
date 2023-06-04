import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mychat/homepage/myhome.dart';
import 'package:mychat/utils/theme.dart';

import 'desk.dart';

class myhome extends StatefulWidget {
  const myhome({super.key});

  @override
  State<myhome> createState() => _myhomeState();
}

final firestore = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;
Stream<QuerySnapshot> getuser(role) {
  return firestore
      .collection("users")
      .where("uid", isEqualTo: "${role}")
      .snapshots();
}

Stream<QuerySnapshot> getPengetahuan(role) {
  return firestore
      .collection("pengetahuan")
      .where("rolePengetahuan", isEqualTo: role)
      .snapshots();
}

class _myhomeState extends State<myhome> {
  Stream<QuerySnapshot<Object?>> onlogin(role) {
    setState(() {});
    return getuser(role);
  }

  Stream<QuerySnapshot<Object?>> onpengethuan(role) {
    setState(() {});
    return getPengetahuan(role);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int _jumlah = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
              // height: size.height * 0.15,
              width: size.width * 1,
              child: StreamBuilder(
                  stream: onlogin("${auth.currentUser?.uid}"),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return const Text('null');
                    } else if (snapshot.hasData || snapshot.data != null) {
                      DocumentSnapshot data = snapshot.data?.docs[0];
                      // var data1 = data[0];

                      return Container(
                        padding: EdgeInsets.only(left: 10),
                        width: size.width * 1,
                        height: size.width * 0.2,
                        child: Row(
                          children: [
                            Container(
                              width: size.width * 0.1,
                              height: size.height * 0.1,
                              child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage("${data["image"]}"),
                              ),
                            ),
                            Text(data["email"])
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: ColorPelatte.primaryColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                      );
                    } else {
                      return Container();
                    }
                  })),
          Container(
            padding: const EdgeInsets.all(8.0),
            color: ColorPelatte.bg,
            width: size.width * 1,
            height: size.height * 0.8,
            child: ContainedTabBarView(
              tabs: [
                Text(
                  'Tanaman',
                  style: TextStyle(color: ColorPelatte.primarydarkColor),
                ),
                Text('pupuk',
                    style: TextStyle(color: ColorPelatte.primarydarkColor)),
                Text('Pestisida',
                    style: TextStyle(color: ColorPelatte.primarydarkColor)),
                Text(
                  'Hama',
                  style: TextStyle(color: ColorPelatte.primarydarkColor),
                ),
              ],
              views: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: onpengethuan('Tanaman'),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text('null');
                      } else if (snapshot.hasData || snapshot.data != null) {
                        return ListView.separated(
                            itemBuilder: (context, index) {
                              DocumentSnapshot dsData =
                                  snapshot.data!.docs[index];
                              String lvJudul = dsData['nama_pengetahuan'];
                              String lvdeskripsi = dsData['deksripsi'];
                              String image = dsData['imageURL'];

                              _jumlah = snapshot.data!.docs.length;
                              return Padding(
                                padding: EdgeInsets.all(3),
                                child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Description(
                                                    name: lvJudul,
                                                    bannerurl: image,
                                                    description: lvdeskripsi,
                                                  )));
                                      // final dtBaru = Tanaman(
                                      //   namaTanaman: lvJudul,
                                      //   deskripsi: lvdeskripsi,
                                      // );
                                      // databaseTanaman.tambahDataTanaman(
                                      //     item: dtBaru);
                                    },
                                    title: Text(lvJudul),
                                    leading: Container(
                                      width: size.width * 0.2,
                                      height: size.height * 0.2,
                                      child: CircleAvatar(
                                          backgroundImage: NetworkImage(image)),
                                    )),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 8.0),
                            itemCount: snapshot.data!.docs.length);
                      }
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.pinkAccent,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: onpengethuan('Pupuk'),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text('null');
                      } else if (snapshot.hasData || snapshot.data != null) {
                        return ListView.separated(
                            itemBuilder: (context, index) {
                              DocumentSnapshot dsData =
                                  snapshot.data!.docs[index];
                              String lvJudul = dsData['nama_pengetahuan'];
                              String lvdeskripsi = dsData['rolePengetahuan'];
                              String image = dsData['imageURL'];

                              _jumlah = snapshot.data!.docs.length;
                              return Padding(
                                padding: EdgeInsets.all(3),
                                child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Description(
                                                    name: lvJudul,
                                                    bannerurl: image,
                                                    description: lvdeskripsi,
                                                  )));
                                      // final dtBaru = Tanaman(
                                      //   namaTanaman: lvJudul,
                                      //   deskripsi: lvdeskripsi,
                                      // );
                                      // databaseTanaman.tambahDataTanaman(
                                      //     item: dtBaru);
                                    },
                                    title: Text(lvJudul),
                                    leading: Container(
                                      width: size.width * 0.2,
                                      height: size.height * 0.2,
                                      child: CircleAvatar(
                                          backgroundImage: NetworkImage(image)),
                                    )),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 8.0),
                            itemCount: snapshot.data!.docs.length);
                      }
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.pinkAccent,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: onpengethuan('Pestisida'),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text('null');
                      } else if (snapshot.hasData || snapshot.data != null) {
                        return ListView.separated(
                            itemBuilder: (context, index) {
                              DocumentSnapshot dsData =
                                  snapshot.data!.docs[index];
                              String lvJudul = dsData['nama_pengetahuan'];
                              String lvdeskripsi = dsData['rolePengetahuan'];
                              String image = dsData['imageURL'];

                              _jumlah = snapshot.data!.docs.length;
                              return Padding(
                                padding: EdgeInsets.all(3),
                                child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Description(
                                                    name: lvJudul,
                                                    bannerurl: image,
                                                    description: lvdeskripsi,
                                                  )));

                                      // final dtBaru = Tanaman(
                                      //   namaTanaman: lvJudul,
                                      //   deskripsi: lvdeskripsi,
                                      // );
                                      // databaseTanaman.tambahDataTanaman(
                                      //     item: dtBaru);
                                    },
                                    title: Text(lvJudul),
                                    leading: Container(
                                      width: size.width * 0.2,
                                      height: size.height * 0.2,
                                      child: CircleAvatar(
                                          backgroundImage: NetworkImage(image)),
                                    )),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 8.0),
                            itemCount: snapshot.data!.docs.length);
                      }
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.pinkAccent,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: onpengethuan('Hama'),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text('null');
                      } else if (snapshot.hasData || snapshot.data != null) {
                        return ListView.separated(
                            itemBuilder: (context, index) {
                              DocumentSnapshot dsData =
                                  snapshot.data!.docs[index];
                              String lvJudul = dsData['nama_pengetahuan'];
                              String lvdeskripsi = dsData['rolePengetahuan'];
                              String image = dsData['imageURL'];
                              _jumlah = snapshot.data!.docs.length;
                              return Padding(
                                padding: EdgeInsets.all(3),
                                child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Description(
                                                    name: lvJudul,
                                                    bannerurl: image,
                                                    description: lvdeskripsi,
                                                  )));
                                      // final dtBaru = Tanaman(
                                      //   namaTanaman: lvJudul,
                                      //   deskripsi: lvdeskripsi,
                                      // );
                                      // databaseTanaman.tambahDataTanaman(
                                      //     item: dtBaru);
                                    },
                                    title: Text(lvJudul),
                                    leading: Container(
                                      width: size.width * 0.2,
                                      height: size.height * 0.2,
                                      child: CircleAvatar(
                                          backgroundImage: NetworkImage(image)),
                                    )),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 8.0),
                            itemCount: snapshot.data!.docs.length);
                      }
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.pinkAccent,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
              onChange: (index) => print(index),
            ),
          ),
          // Expanded(
          //   child: StreamBuilder<QuerySnapshot>(
          //     stream: getPengetahuan(),
          //     builder: (context, snapshot) {
          //       if (snapshot.hasError) {
          //         return const Text('null');
          //       } else if (snapshot.hasData || snapshot.data != null) {
          //         return ListView.separated(
          //             // scrollDirection: Axis.horizontal,
          //             itemBuilder: (context, index) {
          //               DocumentSnapshot dsData = snapshot.data!.docs[index];
          //               String lvJudul = dsData['nama_pengetahuan'];
          //               String lvdeskripsi = dsData['rolePengetahuan'];
          //               String image = dsData['imageURL'];
          //               _jumlah = snapshot.data!.docs.length;
          //               return Container(
          //                   padding: const EdgeInsets.all(8.0),
          //                   color: ColorPelatte.bg,
          //                   width: size.width * 1,
          //                   height: size.height * 1,
          //                   child: ContainedTabBarView(tabs: [
          //                     Text('Tanaman'),
          //                     Text('pupuk'),
          //                     Text('Pestisida'),
          //                     Text('Hama'),
          //                   ], views: [

          //                   ]));
          //               // return Padding(
          //               //   padding: EdgeInsets.all(3),
          //               //   child: ListTile(
          //               //       onTap: () {
          //               //         // final dtBaru = Tanaman(
          //               //         //   namaTanaman: lvJudul,
          //               //         //   deskripsi: lvdeskripsi,
          //               //         // );
          //               //         // databaseTanaman.tambahDataTanaman(
          //               //         //     item: dtBaru);
          //               //       },
          //               //       title: Text(lvJudul),
          //               //       leading: Container(
          //               //         width: size.width * 0.2,
          //               //         height: size.height * 0.2,
          //               //         child: CircleAvatar(
          //               //             backgroundImage: NetworkImage(image)),
          //               //       )),
          //               // );
          //             },
          //             separatorBuilder: (context, index) =>
          //                 const SizedBox(height: 8.0),
          //             itemCount: snapshot.data!.docs.length);
          //       }
          //       return const Center(
          //         child: CircularProgressIndicator(
          //           valueColor: AlwaysStoppedAnimation<Color>(
          //             Colors.pinkAccent,
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}

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
    myhome(),
    penjadwalan(),
    mychat(),
    myprofile(),
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
              icon: Icon(Icons.calendar_month_outlined), label: 'penjadwalan'),
          BottomNavigationBarItem(
              icon: Icon(Icons.contact_mail_rounded), label: 'contact'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'profile')
        ],
      ),
    );
  }
}

class myprofile extends StatelessWidget {
  const myprofile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class mychat extends StatelessWidget {
  const mychat({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class penjadwalan extends StatefulWidget {
  const penjadwalan({super.key});

  @override
  State<penjadwalan> createState() => _penjadwalanState();
}

class _penjadwalanState extends State<penjadwalan> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
