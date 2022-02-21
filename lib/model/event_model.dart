import 'package:flutter/widgets.dart';
import '../homescreen.dart';

class EventModel {
  EventModel({
    this.eventName,
    this.emailId,
    this.eventDate,
    this.eventNotes,
    this.inviteOthers,
    // this.teeTimes,
    this.navigateScreen,
  });

  String? eventName;
  String? emailId;
  String? eventDate;
  String? eventNotes;
  int? inviteOthers;
  // List<void>? teeTimes;
  Widget? navigateScreen = HomeScreen(title: "Golf Booking App");

  EventModel.fromJson(Map<String, dynamic> json) {
    eventName = json['eventName'];
    emailId = json['emailId'];
    eventDate = json['eventDate'];
    eventNotes = json['eventNotes'];
    inviteOthers = json['inviteOthers'];
    navigateScreen = json['navigateScreen'];
    // List<void>? teeTimes;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['eventName'] = this.eventName;
    data['emailId'] = this.emailId;
    data['eventDate'] = this.eventDate;
    data['eventNotes'] = this.eventNotes;
    data['inviteOthers'] = this.inviteOthers;
    data['navigateScreen'] = this.navigateScreen;
    return data;
  }
}
