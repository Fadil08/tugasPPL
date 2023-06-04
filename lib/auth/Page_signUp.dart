import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:belajar_firebase/utils/componen.dart';
// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:belajar_firebase/auth/Page_SIgnIn.dart';
import 'package:belajar_firebase/admin/tambahTanaman/listdata.dart';

import '../services/auth.dart';
import '../utils/theme.dart';
import 'auth.dart';
import 'landingPage.dart';

class PageSignUp extends StatefulWidget {
  final Auth? dataauth;
  const PageSignUp({super.key, this.dataauth});
  @override
  State<PageSignUp> createState() => _PageSignUpState();
}

enum Genderoption { pria, wanita }

String? userCRDSL;

class _PageSignUpState extends State<PageSignUp> {
  Genderoption? _character = Genderoption.pria;
  final _emailcontroler = TextEditingController();
  final _passwordcontroler = TextEditingController();
  final controlernamalengkap = TextEditingController();
  final pekerjaanControler = TextEditingController();

  bool _registring = false;
  // final Userlogin = FirebaseAuth.instance.currentUser;
  String? status;
  var image;
  final firestrordb = FirebaseFirestore.instance.collection("users");

  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference data = FirebaseFirestore.instance.collection('users');

  @override
  void dispose() {
    // TODO: implement dispose
    _emailcontroler.dispose();
    _passwordcontroler.dispose();
    pekerjaanControler.dispose();
    controlernamalengkap.dispose();
    image.dispose();
    super.dispose();
  }

  void initState() {
    // TODO: implement initState
    _emailcontroler.text = widget.dataauth?.email ?? "";
    _passwordcontroler.text = widget.dataauth?.password ?? "";
    pekerjaanControler.text = widget.dataauth?.pekerjaan ?? "";
    controlernamalengkap.text = widget.dataauth?.namaLengkap ?? "";
    getstatus();
    super.initState();
  }

  @override
  void erorsnackbar(eror) {
    AnimatedSnackBar.material(
      '$eror',
      type: AnimatedSnackBarType.info,
    ).show(context);
  }

  void snackbarSucses() {
    AnimatedSnackBar.rectangle(
      'Success',
      'This is a success SignUp in Apps',
      type: AnimatedSnackBarType.success,
      brightness: Brightness.dark,
    ).show(
      context,
    );
  }

  getstatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      status = pref.getString("status") ?? "Status not fond";
    });
  }

  Future<void> SignUp() async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    String value = _character.toString().split('.').last;
    try {
      print('ok');
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailcontroler.text.trim(),
              password: _passwordcontroler.text.trim());
      userCRDSL = userCredential.user?.uid;
      final updata = Auth(
          namaLengkap: controlernamalengkap.text.trim(),
          email: _emailcontroler.text,
          password: _passwordcontroler.text,
          status: status.toString(),
          pekerjaan: pekerjaanControler.text,
          gender: value,
          image: image,
          uid: userCredential.user?.uid,
          addtime: DateTime.timestamp().toUtc().timeZoneName);
      tambahData(item: updata);
      controlernamalengkap.clear();
      _emailcontroler.clear();
      _passwordcontroler.clear();
      pekerjaanControler.clear();
      // snackbarSucses();
    } on FirebaseAuthException catch (e) {
      print(e);
      return erorsnackbar(e.toString());
      // catch (e) {
    }
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
              width: size.width * 1,
              height: size.height * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'GONDUR',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    'Sistem Informasi',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  Text(
                    'Management Tanaman Pertanian',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  )
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  color: ColorPelatte.primaryColor)),
          Container(
            margin: EdgeInsets.only(top: 15, bottom: 10),
            child: Text(
              'Register',
              style: TextStyle(
                  color: ColorPelatte.fontcolor1,
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            padding: EdgeInsets.all(10),
            child: TextFormField(
              keyboardType: TextInputType.name,
              controller: controlernamalengkap,
              // maxLines: 6,
              decoration: InputDecoration(
                hintText: 'namalengkap',
                labelText: 'namalengkap',
                border: OutlineInputBorder(),
                fillColor: ColorPelatte.primaryColor,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            padding: EdgeInsets.all(10),
            child: TextFormField(
              keyboardType: TextInputType.name,
              controller: pekerjaanControler,
              // maxLines: 6,
              decoration: InputDecoration(
                hintText: 'pekerjaan',
                labelText: 'pekerjaan',
                border: OutlineInputBorder(),
                fillColor: ColorPelatte.primaryColor,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            padding: EdgeInsets.all(10),
            child: TextFormField(
              keyboardType: TextInputType.name,
              controller: _emailcontroler,
              decoration: InputDecoration(
                hintText: 'Masukkan Email',
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            padding: EdgeInsets.all(10),
            child: TextFormField(
                keyboardType: TextInputType.name,
                maxLength: 8,
                obscureText: true,
                controller: _passwordcontroler,
                decoration: InputDecoration(
                  hintText: 'Password',
                  labelText: 'password',
                  border: OutlineInputBorder(),
                )),
          ),
          Text(
            "Jenis Kelamin",
            style: TextStyle(
                color: Color.fromARGB(255, 77, 76, 76),
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          Column(
            children: <Widget>[
              ListTile(
                title: const Text('Laki-laki'),
                leading: Radio<Genderoption>(
                  activeColor: Colors.green,
                  value: Genderoption.pria,
                  groupValue: _character,
                  onChanged: (Genderoption? value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Perempuan'),
                leading: Radio<Genderoption>(
                  activeColor: Colors.green,
                  value: Genderoption.wanita,
                  groupValue: _character,
                  onChanged: (Genderoption? value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
              ),
            ],
          ),
          Textfield(
            hintText: 'Select Your Photo',
            icon: Icons.person,
            onTap: () async {
              image = await databaseAuth.selectImage(context);
            },
          ),
          Container(
            margin: EdgeInsets.only(bottom: 5),
            width: size.width * 0.5,
            color: ColorPelatte.secondary,
            child: ElevatedButton(
              onPressed: () {
                print(status.toString());

                if (_emailcontroler.text.isEmpty &&
                    _passwordcontroler.text.isEmpty &&
                    controlernamalengkap.text.isEmpty) {
                  return erorsnackbar(context);
                } else {
                  if (_emailcontroler.text.isNotEmpty &&
                      controlernamalengkap.text.isNotEmpty &&
                      _passwordcontroler.text.isNotEmpty &&
                      pekerjaanControler.text.isNotEmpty) {
                    print("oke");

                    SignUp();
                    // tambahData(item: updata);
                  }
                } // print(status.toString());
              },
              child: Text('Register'),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sudah Memiliki Akun?',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: ColorPelatte.fontcolor1),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return pageLogin();
                      }));
                    },
                    child: Text(
                      'Masuk',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: ColorPelatte.secondary),
                    ))
              ],
            ),
          ),
        ]),
      ),
    );
  }

  // final useradd = FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)

  void tambahData({required Auth item}) async {
    DocumentReference docRef = data.doc(item.uid);
    await docRef
        .set(item.toJson())
        .whenComplete(() => print("data berhasil diinput"))
        .catchError((e) => print(e));
    snackbarSucses();
    controlernamalengkap.clear();
    _emailcontroler.clear();
    _passwordcontroler.clear();
    pekerjaanControler.clear();
    image = null;
  }
}
