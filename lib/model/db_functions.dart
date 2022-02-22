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
      .catchError((error) => print("Failed to add event: $error"));
  //eventsList.add(event);
}

updateEvent(EventModel event, id) async {
  await _mainCollection
      .doc(id)
      .update(event.toJson())
      .then((value) => print("user Updated"))
      .catchError((error) => print("Failed to update event: $error"));
}

Future<List> getAllevents() async {
  Map<String, dynamic> eventMap;
  QuerySnapshot querySnapshot = await _mainCollection.get();
  //final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  //print(querySnapshot.docs[0].data().runtimeType);
  final mapped = querySnapshot.docs.map((doc) {
    eventMap = doc.data() as Map<String, dynamic>; //{};
    eventMap['id'] = doc.id;
    return eventMap;
  });
  final allData = mapped.toList();
  return allData;
}
