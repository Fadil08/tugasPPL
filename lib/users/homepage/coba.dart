import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'dart:math';

class EventClass{
  String? owner;
  String? description;
  String? city;
  String? state;
  String? place;
}

class EventsListing extends StatefulWidget {
  @override
  EventsListingState createState() => new EventsListingState();
}

class EventsListingState extends State<EventsListing> {
  late List<EventClass> events;

  @override
  void initState() {
    super.initState();
    
  }

  void buildEventClass(DocumentSnapshot doc) async {
    EventClass oneEvent = new EventClass();

    DocumentReference document = FirebaseFirestore.instance.collection("users").doc(doc["userid"]);

    document.get().then((DocumentSnapshot snapshot){
      oneEvent.owner = snapshot["name"].toString();
    });
    oneEvent.description = doc["description"];
    oneEvent.place       = doc["place"];
    oneEvent.city        = doc["city"];
    oneEvent.state       = doc["state"];
    events.add(oneEvent);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Events'), 
      ),
      body: new StreamBuilder(
        stream: FirebaseFirestore.instance.collection("events").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (snapshot.connectionState == ConnectionState.waiting)
            return Text("Loading...");

          return ListView(
            padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
            children: snapshot.data!.docs.map((document){
               buildEventClass(document);
               return events.length == 0 ? new Card() : item(events.last);
              }).toList()
          );
        },
      ),
      floatingActionButton: new FloatingActionButton(
        tooltip: 'New',
        child: new Icon(Icons.add),
        onPressed: () async {
  
         },
      ),
    );
  }

  Widget item(EventClass oneEvent) {
    return new Card(
      elevation: 4.0,
      child: new Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Column(
                children: <Widget>[
                  new Text(oneEvent.owner.toString(),
                    style: TextStyle(fontSize: 20.0),
                    overflow: TextOverflow.ellipsis,),
                ],
              ),
              new Column(
                children: <Widget>[

                ],
              )
            ],
          ),
          new Container(
            color: Colors.blue,
            height: 150.0,
          ),
          new Row(
            children: <Widget>[
              new Row( 
                children: <Widget>[
                  new Text(oneEvent.description.toString(), 
                    style: TextStyle(fontSize: 20.0),
                    overflow: TextOverflow.ellipsis,),
                ],
              ),
              new Row( 
                children: <Widget>[
                  new Text(oneEvent.place.toString(), 
                    style: TextStyle(color: Colors.grey[350]),
                    overflow: TextOverflow.ellipsis,),
                ],
              ),
              new Row( 
                children: <Widget>[
                  new Text(oneEvent.city.toString() +' - '+ oneEvent.state.toString(), 
                    style: TextStyle(color: Colors.grey[350]),
                    overflow: TextOverflow.ellipsis,),
                ],
              )
            ]
          )          
        ],
      )
    );
  }
}