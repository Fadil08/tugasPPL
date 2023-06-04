// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import 'package:image_picker/image_picker.dart';
// import 'package:mychat/homepage/home/homepage.dart';
// import 'package:mychat/homepage/myhome.dart';
// import 'package:mychat/homepage/profile/databaseUser.dart';
// import 'package:mychat/homepage/profile/modeluser.dart';

// import '../../utils/theme.dart';

// class myprofilepage extends StatefulWidget {
//   const myprofilepage({super.key});

//   @override
//   State<myprofilepage> createState() => _myprofilepageState();
// }

// String myId = '';
// String myUsername = '';
// String myUrlAvatar = '';
// var myuser = FirebaseAuth.instance.currentUser;

// // ignore: camel_case_types
// class _myprofilepageState extends State<myprofilepage> {
//   @override
//   void getdatauser() {
// //  User user = _firebaseAuth.currentUser;
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(myuser?.uid.toString())
//         .snapshots()
//         .listen((userData) {
//       setState(() {
//         myId = userData.data()?['uid'];
//         myUsername = userData.data()?['namaLengkap'];
//         myUrlAvatar = userData.data()?['imageURL'];
//       });
//     });
//     @override
//     void initState() {
//       // _getdata();
//       super.initState();
//     }

//     // Future<dynamic> getData() async {
//     //   await FirebaseFirestore.instance
//     //       .collection("Users")
//     //       .doc(profile?.uid)
//     //       .get();
//     // }

//     @override
//     @override
//     Widget build(BuildContext context) {
//       // var akunnya = databaseAuth.getdataUser();
//       Size size = MediaQuery.of(context).size;
//       return Scaffold(
//         body: Column(
//           children: <Widget>[
//             // ProfileViewAppBar(),
//             SliverList(
//                 delegate: SliverChildListDelegate([
//               Center(
//                 child: Container(
//                   width: 100.0,
//                   height: 100.0,
//                   decoration: BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(
//                             color: ColorPelatte.primaryColor.withOpacity(.2),
//                             blurRadius: 10.0)
//                       ],
//                       borderRadius: BorderRadius.circular(100.0),
//                       gradient: LinearGradient(colors: [
//                         ColorPelatte.primaryColor,
//                         Colors.green.shade900
//                       ])),
//                   child: CircleAvatar(
//                     backgroundColor: Colors.transparent,
//                     child: Text('P',
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 40.0,
//                             fontWeight: FontWeight.bold)),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10.0),
//               Center(
//                   child: Text('${myuser?.email}',
//                       style: TextStyle(
//                           fontSize: 18.0,
//                           color: ColorPelatte.fontcolor1,
//                           fontWeight: FontWeight.bold))),
//               Center(
//                   child: Text(myUsername ?? "status",
//                       style: TextStyle(
//                           fontSize: 18.0,
//                           color: Colors.black.withOpacity(.2),
//                           fontWeight: FontWeight.bold))),

//               SizedBox(height: 30.0),
//               // Center(child: ProfileRating()),
//               SizedBox(height: 20.0),
//               Container(
//                 margin: EdgeInsets.only(left: 20, bottom: 10),
//                 child: Row(
//                   children: [
//                     Text('My',
//                         style: TextStyle(
//                             fontSize: 15.0,
//                             fontWeight: FontWeight.w600,
//                             fontFamily: 'OpenSans')),
//                     IconButton(
//                         onPressed: () {
//                           // loaduser();
//                           // getSession();
//                           print('');
//                         },
//                         icon: Icon(Icons.edit_document))
//                   ],
//                 ),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   color: Color.fromARGB(255, 224, 231, 226),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(20.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       SizedBox(height: 10.0),
//                       Text(
//                         "namaLengkap: ",
//                         style: TextStyle(
//                             fontSize: 15.0,
//                             fontWeight: FontWeight.w600,
//                             fontFamily: 'OpenSans'),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(top: 5),
//                         width: size.width * 0.8,
//                         height: size.height * 0.06,
//                         padding: EdgeInsets.all(10),
//                         // ignore: sort_child_properties_last
//                         child: Text("",
//                             // ("namaLengkap").toString(),
//                             style: TextStyle(
//                                 fontSize: 15.0,
//                                 fontWeight: FontWeight.w500,
//                                 fontFamily: 'OpenSans')),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: ColorPelatte.primaryColor,
//                         ),
//                       ),
//                       SizedBox(height: 10.0),
//                       Text(
//                         "Email: ",
//                         style: TextStyle(
//                             fontSize: 15.0,
//                             fontWeight: FontWeight.w600,
//                             fontFamily: 'OpenSans'),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(top: 5),
//                         width: size.width * 0.8,
//                         height: size.height * 0.06,
//                         padding: EdgeInsets.all(10),
//                         child: Text('',
//                             style: TextStyle(
//                                 fontSize: 15.0,
//                                 fontWeight: FontWeight.w500,
//                                 fontFamily: 'OpenSans')),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: ColorPelatte.primaryColor,
//                         ),
//                       ),
//                       SizedBox(height: 10.0),
//                       Text(
//                         "Domisili: ",
//                         style: TextStyle(
//                             fontSize: 15.0,
//                             fontWeight: FontWeight.w600,
//                             fontFamily: 'OpenSans'),
//                       ),
//                       // SizedBox(height: 10.0),
//                       Container(
//                         margin: EdgeInsets.only(top: 5),
//                         width: size.width * 0.8,
//                         height: size.height * 0.06,
//                         padding: EdgeInsets.all(10),
//                         child: Text('' ?? "Not Found",
//                             style: TextStyle(
//                                 fontSize: 15.0,
//                                 fontWeight: FontWeight.w500,
//                                 fontFamily: 'OpenSans')),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: ColorPelatte.primaryColor,
//                         ),
//                       ),
//                       Container(
//                         child: Text(
//                           "Contact: ",
//                           style: TextStyle(
//                               fontSize: 15.0,
//                               fontWeight: FontWeight.w600,
//                               fontFamily: 'OpenSans'),
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(top: 5),
//                         width: size.width * 0.8,
//                         height: size.height * 0.06,
//                         padding: EdgeInsets.all(10),
//                         child: Text('',
//                             style: TextStyle(
//                                 fontSize: 15.0,
//                                 fontWeight: FontWeight.w500,
//                                 fontFamily: 'OpenSans')),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: ColorPelatte.primaryColor,
//                         ),
//                       ),

//                       Text(
//                         "Usia: ",
//                         style: TextStyle(
//                             fontSize: 15.0,
//                             fontWeight: FontWeight.w600,
//                             fontFamily: 'OpenSans'),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(top: 5),
//                         width: size.width * 0.8,
//                         height: size.height * 0.06,
//                         padding: EdgeInsets.all(10),
//                         child: Text('',
//                             style: TextStyle(
//                                 fontSize: 15.0,
//                                 fontWeight: FontWeight.w500,
//                                 fontFamily: 'OpenSans')),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: ColorPelatte.primaryColor,
//                         ),
//                       ),
//                       Text(
//                         "Pekerjaan: ",
//                         style: TextStyle(
//                             fontSize: 15.0,
//                             fontWeight: FontWeight.w600,
//                             fontFamily: 'OpenSans'),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(top: 5),
//                         width: size.width * 0.8,
//                         height: size.height * 0.06,
//                         padding: EdgeInsets.all(10),
//                         child: Text('',
//                             style: TextStyle(
//                                 fontSize: 15.0,
//                                 fontWeight: FontWeight.w500,
//                                 fontFamily: 'OpenSans')),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: ColorPelatte.primaryColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//             ])),
//           ],
//         ),
//       );
//     }
//   }


// }
