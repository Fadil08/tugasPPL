import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  final String? name, description, bannerurl, posterurl;

  const Description({
    super.key,
    this.name,
    this.description,
    this.bannerurl,
    this.posterurl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
          child: ListView(children: [
        Container(
            height: 250,
            child: Stack(children: [
              Positioned(
                child: Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    "${bannerurl.toString()}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                  bottom: 10,
                  child: Text(
                    "${name != null ? name : 'Not loader'}",
                    style: TextStyle(fontSize: 20),
                  ))
            ])),
        SizedBox(height: 15),
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
            "${name != null ? name : 'Not loader'}",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Container(
            padding: EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Container(
                  height: 200,
                  width: 100,
                  child: Image.network("${posterurl.toString()}"),
                ),
                Flexible(
                  child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text(description.toString())),
                )
              ],
            ))
      ])),
    );
  }
}
