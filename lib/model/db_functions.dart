import 'package:bookingapp2/model/event_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('events');
//import 'package:flutter/material.dart';

// ValueNotifier<List<EventModel>> eventsListNotifier = ValueNotifier([]);
// above, variable eventsListNotifier is an object of class valuenotifier
// .value gives the value of the list
// addEvent(EventModel event) {
//   eventsListNotifier.value.add(event);
// }
List<EventModel> eventsList = [];
addEvent(EventModel event) async {
  //print(event);
  //FirebaseFirestore.instance.collection("events");
  await _mainCollection
      .add(event.toJson())
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
  //eventsList.add(event);
}

Future<List> getAllevents() async {
  QuerySnapshot querySnapshot = await _mainCollection.get();
  // final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  //print(allData);

  return allData;
}
