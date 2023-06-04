import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_tawk/flutter_tawk.dart';

class Mychatt extends StatefulWidget {
  const Mychatt({super.key});

  @override
  State<Mychatt> createState() => _MychattState();
}

class _MychattState extends State<Mychatt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Tawk(
        directChatLink:
            'https://tawk.to/chat/644c897731ebfa0fe7fb06a2/1gv5fhvof',
        visitor: TawkVisitor(
          name: 'Ayou',
          email: 'rohmatfadhil86@gmail.com',
        ),
        onLoad: () {
          print('Hello Tawk!');
        },
        onLinkTap: (String url) {
          print(url);
        },
        placeholder: const Center(
          child: Text('Loading...'),
        ),
      ),
    );
  }
}
