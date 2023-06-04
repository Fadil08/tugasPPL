import 'package:belajar_firebase/auth/auth.dart';
import 'package:belajar_firebase/coba.dart';
import 'package:belajar_firebase/users/chat/setchat.dart';
import 'package:belajar_firebase/users/profile/setdatabasae.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'detailobrolan.dart';
import 'modelchat.dart';

// class ChatPage extends StatefulWidget {
//   const ChatPage({super.key});
//   @override
//   _ChatPageState createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   List<ChatUsers> chatUsers = [
//     ChatUsers(
//         name: "Jane Russel",
//         messageText: "Awesome Setup",
//         imageURL: "images/userImage1.jpeg",
//         time: "Now"),
//     ChatUsers(
//         name: "Glady's Murphy",
//         messageText: "That's Great",
//         imageURL: "images/userImage2.jpeg",
//         time: "Yesterday"),
//     ChatUsers(
//         name: "Jorge Henry",
//         messageText: "Hey where are you?",
//         imageURL: "images/userImage3.jpeg",
//         time: "31 Mar"),
//     ChatUsers(
//         name: "Philip Fox",
//         messageText: "Busy! Call me in 20 mins",
//         imageURL: "images/userImage4.jpeg",
//         time: "28 Mar"),
//     ChatUsers(
//         name: "Debra Hawkins",
//         messageText: "Thankyou, It's awesome",
//         imageURL: "images/userImage5.jpeg",
//         time: "23 Mar"),
//     ChatUsers(
//         name: "Jacob Pena",
//         messageText: "will update you in evening",
//         imageURL: "images/userImage6.jpeg",
//         time: "17 Mar"),
//     ChatUsers(
//         name: "Andrey Jones",
//         messageText: "Can you please share the file?",
//         imageURL: "images/userImage7.jpeg",
//         time: "24 Feb"),
//     ChatUsers(
//         name: "John Wick",
//         messageText: "How are you?",
//         imageURL: "images/userImage8.jpeg",
//         time: "18 Feb"),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: SingleChildScrollView(
//         physics: BouncingScrollPhysics(),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             SafeArea(
//               child: Padding(
//                 padding: EdgeInsets.only(left: 16, right: 16, top: 10),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Text(
//                       "Conversations",
//                       style:
//                           TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
//                     ),
//                     Container(
//                       padding:
//                           EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
//                       height: 30,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(30),
//                         color: Colors.pink[50],
//                       ),
//                       child: Row(
//                         children: <Widget>[
//                           Icon(
//                             Icons.add,
//                             color: Colors.pink,
//                             size: 20,
//                           ),
//                           SizedBox(
//                             width: 2,
//                           ),
//                           Text(
//                             "Add New",
//                             style: TextStyle(
//                                 fontSize: 14, fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             Container(
//               // padding: EdgeInsets.all(),
//               width: size.width * 1,
//               height: size.height * 0.07,
//               color: Colors.amber,
//               child: Row(
//                 children: [
//                   Container(
//                       width: size.width * 0.3,
//                       child: TextButton(
//                           onPressed: () {},
//                           child: Text(
//                             "users",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w500),
//                           ))),
//                   SizedBox(
//                     width: size.width * 0.05,
//                   ),
//                   Container(
//                       width: size.width * 0.3,
//                       child: TextButton(
//                           onPressed: () {},
//                           child: Text(
//                             "Pakar",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w500),
//                           ))),
//                   SizedBox(
//                     width: size.width * 0.05,
//                   ),
//                   Container(
//                       width: size.width * 0.3,
//                       child: TextButton(
//                           onPressed: () {},
//                           child: Text(
//                             "Admin",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w500),
//                           ))),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(top: 16, left: 16, right: 16),
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: "Search...",
//                   hintStyle: TextStyle(color: Colors.grey.shade600),
//                   prefixIcon: Icon(
//                     Icons.search,
//                     color: Colors.grey.shade600,
//                     size: 20,
//                   ),
//                   filled: true,
//                   fillColor: Colors.grey.shade100,
//                   contentPadding: EdgeInsets.all(8),
//                   enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       borderSide: BorderSide(color: Colors.grey.shade100)),
//                 ),
//               ),
//             ),
//             ListView.builder(
//               itemCount: chatUsers.length,
//               shrinkWrap: true,
//               padding: EdgeInsets.only(top: 16),
//               physics: NeverScrollableScrollPhysics(),
//               itemBuilder: (context, index) {
//                 return ConversationList(
//                   name: chatUsers[index].name,
//                   messageText: chatUsers[index].messageText,
//                   imageUrl: chatUsers[index].imageURL,
//                   time: chatUsers[index].time,
//                   isMessageRead: (index == 0 || index == 3) ? true : false,
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class chatPage extends StatefulWidget {
  const chatPage({super.key});

  @override
  State<chatPage> createState() => _chatPageState();
}

final auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;

List<ModelData> dataChat = [];
List<ModelData> start = [];

class _chatPageState extends State<chatPage> {
  List<ChatUsers> chatUsers = [
    ChatUsers(
        name: "Jane Russel",
        messageText: "Awesome Setup",
        imageURL: "images/userImage1.jpeg",
        time: "Now"),
    ChatUsers(
        name: "Glady's Murphy",
        messageText: "That's Great",
        imageURL: "images/userImage2.jpeg",
        time: "Yesterday"),
    ChatUsers(
        name: "Jorge Henry",
        messageText: "Hey where are you?",
        imageURL: "images/userImage3.jpeg",
        time: "31 Mar"),
    ChatUsers(
        name: "Philip Fox",
        messageText: "Busy! Call me in 20 mins",
        imageURL: "images/userImage4.jpeg",
        time: "28 Mar"),
    ChatUsers(
        name: "Debra Hawkins",
        messageText: "Thankyou, It's awesome",
        imageURL: "images/userImage5.jpeg",
        time: "23 Mar"),
    ChatUsers(
        name: "Jacob Pena",
        messageText: "will update you in evening",
        imageURL: "images/userImage6.jpeg",
        time: "17 Mar"),
    ChatUsers(
        name: "Andrey Jones",
        messageText: "Can you please share the file?",
        imageURL: "images/userImage7.jpeg",
        time: "24 Feb"),
    ChatUsers(
        name: "John Wick",
        messageText: "How are you?",
        imageURL: "images/userImage8.jpeg",
        time: "18 Feb"),
  ];

  static Future<List<ModelData>> getrun() async {
    var commentsRef = FirebaseFirestore.instance
        .collection('users')
        .where("uid", isNotEqualTo: auth.currentUser?.uid);
    // .where("status", isEqualTo: "user");
    var querySnapshot = await commentsRef.get();
    return querySnapshot.docs.map((e) => ModelData.fromJson(e.data())).toList();
  }

  getStart() async {
    start = await getrun();
  }

  fetchRecord() async {
    var records = await FirebaseFirestore.instance.collection('users').get();
    maprecord(records);
  }

  maprecord(QuerySnapshot<Map<String, dynamic>> record) {
    var _list = record.docs
        .map((item) => ModelData(
              uid: item.data()['uid'],
              namaLengkap: item.data()['namaLengkap'],
              pekerjaan: item.data()['pekerjaan'],
              email: item.data()['email'],
              gender: item.data()['gender'],
              noTelp: item.data()['noTelp'],
              password: item.data()['password'],
              status: item.data()['status'],
              image: item.data()['image'],
            ))
        // : item.data()['userid']))
        .toList();
    print(_list);
    setState(() {
      dataChat = _list;
    });
  }

  @override
  void initState() {
    getStart();
    fetchRecord();
    // TODO: implement initState
    super.initState();
  }

  Pattern? get search => null;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
                itemCount: dataChat.length,
                itemBuilder: (context, index) {
                  final data = dataChat[index];
                  return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card(
                        child: Row(
                          children: [
                            CircleAvatar(
                                backgroundImage: NetworkImage("${data.image}")),
                            Text(data.namaLengkap.toString())
                          ],
                        ),
                      ));
                })));
  }
  // Widget build(BuildContext context) {
  //   return Expanded(
  //       child: Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 16),
  //     child: StreamBuilder(
  //         stream: firestore.collection('message').snapshots(),
  //         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //           return !snapshot.hasData
  //               ? Container()
  //               : ListView.builder(
  //                   itemCount: snapshot.data!.docs.where((element) {
  //                     return element.id.contains(search!);
  //                   }).length,
  //                   itemBuilder: (context, i) {});
  //         }),
  //   ));
  // }
}
