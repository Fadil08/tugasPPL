import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var data;
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  Future getInfo() async {
    var email = auth.currentUser!.email;
    var datas;
    try {
      final response = await firestore.collection('users').get();
      final data =
          response.docs.where((element) => element['email'] == email).first;
      datas = data;
    } catch (e) {}
    return datas;
  }

  @override
  void initState() {
    getInfo().then((value) {
      data = value;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(18, 38, 67, 1),
        title: Text('Profile Page'),
      ),
      body: data != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(29.0),
                  child: CircleAvatar(
                      backgroundColor: Color.fromRGBO(18, 38, 67, 1),
                      radius: 63,
                      backgroundImage: NetworkImage(data['image'])),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Container(
                    height: 55,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(214, 224, 239, 1),
                        borderRadius: BorderRadius.circular(11)),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Name: ${data['name']}',
                            style: const TextStyle(
                                color: Color.fromRGBO(18, 38, 67, 0.82),
                                fontWeight: FontWeight.w300),
                          ),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Container(
                    height: 55,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(214, 224, 239, 1),
                        borderRadius: BorderRadius.circular(11)),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'email: ${data['email']}',
                            style: const TextStyle(
                                color: Color.fromRGBO(18, 38, 67, 0.82),
                                fontWeight: FontWeight.w300),
                          ),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Container(
                    height: 55,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(214, 224, 239, 1),
                        borderRadius: BorderRadius.circular(11)),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'number: ${data['number']}',
                            style: const TextStyle(
                                color: Color.fromRGBO(18, 38, 67, 0.82),
                                fontWeight: FontWeight.w300),
                          ),
                        )),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      print(data);
                    },
                    child: Text("tets"))
              ],
            )
          : Center(
              child: CircularProgressIndicator(
                color: Colors.indigo,
              ),
            ),
    );
  }
}
