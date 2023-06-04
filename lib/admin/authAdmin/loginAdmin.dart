import 'dart:convert';

import 'package:belajar_firebase/auth/Page_signUp.dart';
import 'package:belajar_firebase/services/dbservice.dart';
import 'package:belajar_firebase/admin/main_menu/admin_mainPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_alert_dialog/models/alert_dialog_text.dart';
import 'package:smart_alert_dialog/smart_alert_dialog.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

import '../../auth/auth.dart';
import '../../auth/sharedpref.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// import 'Page_forgatePassword.dart';

class pageLoginAdmin extends StatefulWidget {
  const pageLoginAdmin({super.key});

  @override
  State<pageLoginAdmin> createState() => _pageLoginAdminState();
}

List<Auth> dataAuth = [];
final datalogin = FirebaseAuth.instance.currentUser;

class _pageLoginAdminState extends State<pageLoginAdmin> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? nama;
  String? email;
  final formKey = GlobalKey<FormState>();
  bool visible = false;
  String? uid;
  String? status;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void initState() {
    fetchRecord();
    getstatus();
    // getsesions()
    databaseAuth.getdataUser();
    super.initState();
  }

  getsesions() async {
    final getNama = await SessionManager().get("namaLengkap");
    final getEmail = await SessionManager().get("status");
    setState(() {
      email = email.toString();
      nama = getNama.toString();
    });
  }

  fetchRecord() async {
    var records = await FirebaseFirestore.instance.collection('users').get();
    maprecord(records);
  }

  maprecord(QuerySnapshot<Map<String, dynamic>> record) {
    var _list = record.docs
        .map((item) => Auth(
            uid: item.data()['uid'],
            namaLengkap: item.data()['namaLengkap'],
            pekerjaan: item.data()['pekerjaan'],
            email: item.data()['email'],
            gender: item.data()['gender'],
            noTelp: item.data()['noTelp'],
            password: item.data()['password'],
            status: item.data()['status']))
        // : item.data()['userid']))
        .toList();
    print(_list);
    setState(() {
      dataAuth = _list;
    });
  }

//

  void login() async {
    try {
      print("ok");
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } catch (e) {
      print(e);
    }
  }

  void erorsnackbar(eror) {
    AnimatedSnackBar.material(
      '$eror',
      type: AnimatedSnackBarType.info,
    ).show(context);
  }

  void snackbarSucses() {
    AnimatedSnackBar.rectangle(
      'Success',
      'This is a success Login in Apps',
      type: AnimatedSnackBarType.success,
      brightness: Brightness.dark,
    ).show(
      context,
    );
  }

  void eroroAlertIsEmpty(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => SmartAlertDialog(
          isDismissible: true,
          title: 'Message Login',
          text: AlertDialogText(),
          message: 'Username and password cannot be empty'),
    );
  }

  loaduser() async {
    try {
      Auth auth = Auth.fromJson(await SharedPref.read("admin"));
      Scaffold.of(context).setState(() {
        loadAuth = auth;
        print(loadAuth.namaLengkap);
      });
    } catch (e) {
      erorsnackbar(e);
    }
  }

  getstatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      status = pref.getString("status") ?? "Status not fond";
    });
  }

  Auth saveAuth = Auth();
  Auth load = Auth();
  void storeSession() async {
    await SessionManager().set('uid', saveAuth.uid);
    await SessionManager().set('namaLengkap', saveAuth.namaLengkap);
    await SessionManager().set('email', saveAuth.email);
    await SessionManager().set('password', saveAuth.password);
    await SessionManager().set('pekerjaan', saveAuth.pekerjaan);
    await SessionManager().set('status', saveAuth.status);
    await SessionManager().set('gender', saveAuth.gender);
    await SessionManager().set('noTelp', saveAuth.noTelp);
    await SessionManager().set('domisili', saveAuth.domisili);
  }

  Auth data = Auth();

  // void SignInUsers() async {
  Auth loadAuth = Auth();
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              // padding:EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
              width: MediaQuery.of(context).size.width * 1,

              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                  border: Border.fromBorderSide(BorderSide(
                      style: BorderStyle.solid,
                      color: Color.fromARGB(255, 150, 218, 185),
                      width: 0.5)),
                  gradient: LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Color.fromARGB(255, 3, 216, 10),
                        Color.fromARGB(32, 109, 201, 136)
                      ]),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Goundur',
                    // '${datalogin?.uid}',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text(
                    'Sistem Informasi',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal),
                  ),
                  Text('Management Tanaman Pertanian')
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.1,
              padding: EdgeInsets.only(
                top: 20,
              ),
              child: Text(
                'Selamat Datang ${status}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                validator: ((value) {
                  if (value!.isEmpty) {
                    return ("Data tidak boleh kosong");
                  }
                  return null;
                }),
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                scrollPadding: EdgeInsets.all(10),
                decoration: InputDecoration(
                    hintText: 'example@gmail.com',
                    labelText: 'Email',
                    fillColor: Colors.black54,
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.email)),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                  validator: ((value) {
                    if (value!.isEmpty) {
                      return ("Data tidak boleh kosong");
                    }
                    return null;
                  }),
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordController,
                  obscureText: true,
                  scrollPadding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 02),
                  decoration: InputDecoration(
                      hintText: 'Passsword',
                      labelText: 'Password',
                      fillColor: Colors.black54,
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.lock),
                      suffixIcon: Icon(Icons.visibility_off))),
            ),
            Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: Text(
                        'Forget Password ?',
                        style: TextStyle(
                            color: Color.fromARGB(255, 31, 9, 231),
                            fontSize: 15),
                      ),
                    )
                  ],
                )),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                  onPressed: () {
                    if (emailController.text.trim().isEmpty ||
                        passwordController.text.trim().isEmpty) {
                      return eroroAlertIsEmpty(context);
                    } else {
                      // snackbarSucses();
                      login();
                      if (passwordController.text.isNotEmpty &
                          emailController.text.isNotEmpty) {
                        for (var i = 0; i < dataAuth.length; i++) {
                          // print(dataAuth[i].email);
                          if (emailController.text == dataAuth[i].email &&
                              passwordController.text == dataAuth[i].password) {
                            if (dataAuth[i].uid == null) {
                              dataAuth[i].uid = datalogin?.uid.toString();
                              // databaseAuth.tambahdataId(ite)
                              // FirebaseFirestore.instance
                              //     .collection("users")
                              //     .where("email", isEqualTo: dataAuth[i].email)
                              //     .orderBy(field)
                            }
                            setState(() {
                              saveAuth.email = dataAuth[i].email.toString();
                              saveAuth.password =
                                  dataAuth[i].password.toString();
                              saveAuth.gender = dataAuth[i].gender.toString();
                              saveAuth.pekerjaan =
                                  dataAuth[i].pekerjaan.toString();
                              saveAuth.namaLengkap =
                                  dataAuth[i].namaLengkap.toString();
                              saveAuth.usia = dataAuth[i].usia.toString();
                              saveAuth.noTelp = dataAuth[i].noTelp.toString();
                              saveAuth.status = dataAuth[i].status.toString();
                              saveAuth.domisili =
                                  dataAuth[i].domisili.toString();
                              saveAuth.uid = dataAuth[i].uid.toString();
                            });
                            storeSession();
                            // getsesions();
                            // print(nama);
                            // print(email);
                            // getsession();
                            // print(data.password);

                            AnimatedSnackBar.rectangle(
                              'Success',
                              'This is a success Login in Apps',
                              type: AnimatedSnackBarType.success,
                              brightness: Brightness.dark,
                            ).show(
                              context,
                            );
                            SharedPref.save("user", saveAuth);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PageMainAdmin()));
                            // break;
                          } else {
                            // erorsnackbar(
                            //     "failed \n usernaame pasword yang anda masukkan salah");
                          }
                        }
                      }

                      // else// print(dataAuth);
                    }
                    // LOGIN();
                  },
                  child: Text(
                    'Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  )),
            ),
            ElevatedButton(
                onPressed: () {
                  // signInWithGoogle();
                  FirebaseAuth.instance.signOut();
                  // signInWithGoogle();
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => PageMain()));
                  // AutsignInWithGoogle();
                },
                child: Text("Sign In")),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'sudah memiliki akun..?',
                    textAlign: TextAlign.center,
                  ),
                  TextButton(
                    onPressed: () {
                      // loaduser();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PageSignUp()));
                    },
                    child: Text(
                      'register',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class userlogin {
  static void savedata(String key, String value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, jsonEncode(value));
  }

  static void readdata(String key, String value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, jsonEncode(value));
  }

  static Future<void> dellet(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(key);
  }
}
