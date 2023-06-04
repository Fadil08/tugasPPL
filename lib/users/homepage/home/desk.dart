import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  final String name, description, bannerurl;

  const Description({
    super.key,
    required this.name,
    required this.description,
    required this.bannerurl,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      // backgroundColor: Colors.black,
      body: Container(
          child: ListView(
        children: [
          Container(
              height: 250,
              child: Stack(children: [
                Positioned(
                  child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      bannerurl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ])),
          SizedBox(height: 15),
          Container(
              padding: EdgeInsets.all(10),
              child: Text(
                name != null ? name : 'Not Loaded',
                style: TextStyle(fontSize: 20),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              description,
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      )),
    );
  }
}
