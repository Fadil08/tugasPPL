import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mychat/homepage/myhome.dart';
import 'package:mychat/util.dart';
import 'package:mychat/utils/theme.dart';

class viewDataPegetahuan extends StatefulWidget {
  const viewDataPegetahuan({super.key});

  @override
  State<viewDataPegetahuan> createState() => _viewDataPegetahuanState();
}

class _viewDataPegetahuanState extends State<viewDataPegetahuan> {
  CollectionReference pengetahuan =
      FirebaseFirestore.instance.collection('pengetahuan');
  late Stream<QuerySnapshot> _strembuilder;
  @override
  void initState() {
    // TODO: implement initState
    _strembuilder =
        pengetahuan.where("rolePengetahuan", isEqualTo: "Tanaman").snapshots();
    super.initState();
  }

  // Widget _buildAvatar(BuildContext context) {
  //   final color = getUserAvatarNameColor(user);
  //   final hasImage = user.imageUrl != null;
  //   final name = getUserName(user);

  //   return Container(
  //     margin: const EdgeInsets.only(right: 16),
  //     child: CircleAvatar(
  //       backgroundColor: hasImage ? Colors.transparent : color,
  //       backgroundImage: hasImage ? NetworkImage(user.imageUrl!) : null,
  //       radius: 20,
  //       child: !hasImage
  //           ? Text(
  //               name.isEmpty ? '' : name[0].toUpperCase(),
  //               style: const TextStyle(color: Colors.white),
  //             )
  //           : null,
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Data Pengetahuan"),
          backgroundColor: ColorPelatte.primaryColor,
          centerTitle: true,
        ),
        body: StreamBuilder(
            stream: _strembuilder,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }



              return Container(
                child: Column(
                  children: [
                    Text("Tanaman"),
                    ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final calldata = snapshot.data![index];

                        return GestureDetector(
                          onTap: () {
                            print(calldata);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Row(
                              children: [
                                Container(),
                                Text(calldata['namaTanaman']),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              );
            }));
  }
}
