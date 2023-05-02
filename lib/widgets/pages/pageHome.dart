import 'package:flutter/material.dart';


import '../../service/auth.dart';
import '../../services/auth.dart';


class PageHome extends StatefulWidget {
  const PageHome({super.key});

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.backspace_outlined),
          onPressed: () => AuthPage(),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text('Helo Home'),
      ),
    );
  }
}
