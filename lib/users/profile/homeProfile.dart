import 'dart:io';

import 'package:belajar_firebase/Page_Home.dart';
import 'package:belajar_firebase/admin/tambahTanaman/databaseTanaman.dart';
import 'package:belajar_firebase/users/profile/setdatabasae.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:belajar_firebase/utils/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:belajar_firebase/auth/auth.dart';
import 'package:belajar_firebase/auth/sharedpref.dart';

import 'model.dart';

// import './profile_model.dart';
// import '../lib/colors.dart' as RecehanColors;
class myProfile extends StatefulWidget {
  // final int idx;
  // myProfile({required this.idx});
  const myProfile({super.key});

  @override
  State<myProfile> createState() => _myProfileState();
}

void test() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userId =
      prefs.getString('${FirebaseAuth.instance.currentUser?.uid}');
  print('ok');
  print(userId);
}

final myuser = FirebaseAuth.instance.currentUser;

class _myProfileState extends State<myProfile> {
  int idx = 0;
  Auth loadAuth = Auth();
  // SharedPref sharedPref = SharedPref();
  loaduser() async {
    try {
      Auth auth = Auth.fromJson(await SharedPref.read("user"));
      Scaffold.of(context).setState(() {
        loadAuth = auth;
        print(auth);
      });
    } catch (e) {
      print(e);
    }
  }

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    // PickedFile is not supported
    // Now use XFile?
    XFile? pickedFile = await imagePicker
        .pickImage(source: ImageSource.gallery)
        .catchError((onError) {
      //  Fluttertoast.showToast(msg: onError.toString())
    });
    File? image;
    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
    if (image != null) {
      setState(() {
        var avatarImageFile = image;
        var isLoading = true;
      });
      //  uploadFile();
    }
  }
// static Future<void> updateFirestoreData(String collectionPath, String path,
//    Map<String, dynamic> dataUpdateNeeded) {
//  return firebaseFirestore
//      .collection(collectionPath)
//      .doc(path)
//      .update(dataUpdateNeeded);
// }
// Future uploadFile() async {
//  String fileName = id;
//  UploadTask uploadTask = profileProvider.uploadImageFile(avatarImageFile!, fileName);
//  try {
//    TaskSnapshot snapshot = await uploadTask;
//    photoUrl = await snapshot.ref.getDownloadURL();
//    ChatUser updateInfo = ChatUser(id: id,
//        photoUrl: photoUrl,
//        displayName: displayName,
//        phoneNumber: phoneNumber,
//        aboutMe: aboutMe);
//    profileProvider.updateFirestoreData(
//        FirestoreConstants.pathUserCollection, id, updateInfo.toJson())
//        .then((value) async {
//      await profileProvider.setPrefs(FirestoreConstants.photoUrl, photoUrl);
//      setState(() {
//        isLoading = false;
//      });
//    });
//  } on FirebaseException catch (e) {
//    setState(() {
//      isLoading = false;
//    });
//    Fluttertoast.showToast(msg: e.toString());
//  }
// }

  @override
  void initState() {
    // loaduser();
    super.initState();
  }

  Auth data = Auth();
  // getSession(String key) async {
  //   Auth u = await SessionManager().get(key);
  //   return u;
  // }
  List<Users> _usrakun = [];

  @override
  Widget build(BuildContext context) {
    // var akunnya = databaseAuth.getdataUser();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          ProfileViewAppBar(),
          SliverList(
              delegate: SliverChildListDelegate([
            Center(
              child: Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: ColorPelatte.primaryColor.withOpacity(.2),
                          blurRadius: 10.0)
                    ],
                    borderRadius: BorderRadius.circular(100.0),
                    gradient: LinearGradient(colors: [
                      ColorPelatte.primaryColor,
                      Colors.green.shade900
                    ])),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Text('P',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Center(
                child: Text('${myuser?.email}',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: ColorPelatte.fontcolor1,
                        fontWeight: FontWeight.bold))),
            Center(
                child: Text(loadAuth.status ?? "status",
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black.withOpacity(.2),
                        fontWeight: FontWeight.bold))),

            SizedBox(height: 30.0),
            // Center(child: ProfileRating()),
            SizedBox(height: 20.0),
            Container(
              margin: EdgeInsets.only(left: 20, bottom: 10),
              child: Row(
                children: [
                  Text('My ${data.status.toString()}',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'OpenSans')),
                  IconButton(
                      onPressed: () {
                        // loaduser();
                        // getSession();
                        print(data.status.toString());
                      },
                      icon: Icon(Icons.edit_document))
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 224, 231, 226),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    Text(
                      "namaLengkap: ",
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'OpenSans'),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      width: size.width * 0.8,
                      height: size.height * 0.06,
                      padding: EdgeInsets.all(10),
                      // ignore: sort_child_properties_last
                      child: Text("",
                          // ("namaLengkap").toString(),
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'OpenSans')),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorPelatte.primaryColor,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "Email: ",
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'OpenSans'),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      width: size.width * 0.8,
                      height: size.height * 0.06,
                      padding: EdgeInsets.all(10),
                      child: Text(data.email.toString(),
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'OpenSans')),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorPelatte.primaryColor,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "Domisili: ",
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'OpenSans'),
                    ),
                    // SizedBox(height: 10.0),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      width: size.width * 0.8,
                      height: size.height * 0.06,
                      padding: EdgeInsets.all(10),
                      child: Text(loadAuth.domisili ?? "Not Found",
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'OpenSans')),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorPelatte.primaryColor,
                      ),
                    ),
                    Container(
                      child: Text(
                        "Contact: ",
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'OpenSans'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      width: size.width * 0.8,
                      height: size.height * 0.06,
                      padding: EdgeInsets.all(10),
                      child: Text(data.noTelp.toString(),
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'OpenSans')),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorPelatte.primaryColor,
                      ),
                    ),

                    Text(
                      "Usia: ",
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'OpenSans'),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      width: size.width * 0.8,
                      height: size.height * 0.06,
                      padding: EdgeInsets.all(10),
                      child: Text(data.usia.toString(),
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'OpenSans')),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorPelatte.primaryColor,
                      ),
                    ),
                    Text(
                      "Pekerjaan: ",
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'OpenSans'),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      width: size.width * 0.8,
                      height: size.height * 0.06,
                      padding: EdgeInsets.all(10),
                      child: Text(data.pekerjaan.toString(),
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'OpenSans')),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorPelatte.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ])),
        ],
      ),
    );
  }
}

final userId = FirebaseAuth.instance.currentUser;
Future<void> saveData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('id', '${userId?.uid}');
  print(prefs);
}

Future<String?> getData(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

class ProfileViewAppBar extends StatelessWidget {
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      leading: Container(
        padding: EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: () {},
          child: Icon(Icons.arrow_back_ios, color: Colors.red),
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {},
            child: Icon(Icons.bookmark, color: Colors.yellowAccent),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {},
            child: Icon(Icons.settings, color: Colors.purple),
          ),
        ),
        // SizedBox(width: 10.0)
      ],
    );
  }
}

class StarRating extends StatelessWidget {
  // final int star;
  // final List<Color> colors;

  // StarRating(this.star, {this.colors});

  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 5,
      height: 70.0,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(blurRadius: 5.0, color: Colors.black.withOpacity(.2))
        ],
        // gradient: LinearGradient(
        //   // colors: Colors == null ? [Colors.red, Colors.white] :
        // )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('.0',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white.withOpacity(.7),
                  fontWeight: FontWeight.w700)),
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                  5,
                  (index) => Icon(Icons.star,
                      size: 10.0, color: Colors.white.withOpacity(.7))),
            ),
          )
        ],
      ),
    );
  }
}
