import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class mypembayaranUser extends StatefulWidget {
  const mypembayaranUser({super.key});

  @override
  State<mypembayaranUser> createState() => _mypembayaranUserState();
}

class _mypembayaranUserState extends State<mypembayaranUser> {
  Future selectImage(context) async {
    final storage = FirebaseStorage.instance;
    String? url;
    bool premium = false;

    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('File Uploading.......'),
            content: Center(
              child: CircularProgressIndicator(
                color: Colors.indigo,
              ),
            ),
          );
        });
    try {
      final uploaded = await storage.ref(image!.name).putFile(File(image.path));
      var u = await uploaded.ref.getDownloadURL();
      url = u;
    } catch (e) {}

    Navigator.pop(context);

    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        
      ),
    );
  }
}
