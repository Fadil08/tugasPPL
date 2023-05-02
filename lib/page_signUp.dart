import 'package:flutter/material.dart';

class PageSignIn extends StatelessWidget {
  PageSignIn({super.key});
  final controlEmail = TextEditingController();
  final controlPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 100, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // SizedBox(height: 50,),
            Container(
              width: 650,
              margin: EdgeInsets.only(left: 20, bottom: 20),
              child: Text("GONDUR",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 40,
                      fontFamily: "Poppins")),
            ),
            Text(
              "Sistem Informasi Untuk Membantu \n       Proses Manajemen Pertanian",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
            Container(
              color: Color.fromARGB(255, 221, 215, 196),
              width: size.width,
              height: 350,
              margin: EdgeInsets.only(top: 50, bottom: 10, right: 20, left: 20),
              padding: EdgeInsets.only(left: 10, top: 10, right: 10),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Username",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.greenAccent[600],
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  TextFieldContainer(
                    child: TextFormField(
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return ("Data tidak boleh kosong");
                        }
                        return null;
                      }),
                      controller: controlEmail,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        hintText: "E-mail",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Text(
                    "Password",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.greenAccent[600],
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  TextFieldContainer(
                      child: TextFormField(
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return ("Data tidak boleh kosong");
                      }
                      if (controlPassword.text != controlPassword.text) {
                        return "Password Berbeda";
                      }
                      return null;
                    }),
                    controller: controlPassword,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Password",
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.lock,
                          color: Colors.black,
                        ),
                        suffixIcon:
                            Icon(Icons.visibility, color: Colors.black)),
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Login'),
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      child: Text('SIgnUp'),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(50, 10),
                        enabledMouseCursor: MouseCursor.defer,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 5),
      width: size.width * 0.5,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: Color.fromARGB(153, 3, 151, 16),
          borderRadius: BorderRadius.circular(15)),
      child: child,
    );
  }
}
