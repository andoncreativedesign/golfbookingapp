//import 'package:best_flutter_ui_templates/design_course/home_design_course.dart';
// import 'package:best_flutter_ui_templates/fitness_app/fitness_app_home_screen.dart';
// import 'package:best_flutter_ui_templates/hotel_booking/hotel_home_screen.dart';
// import 'package:best_flutter_ui_templates/introduction_animation/introduction_animation_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:bookingapp2/homescreen.dart';

class HomeList {
  HomeList({
    this.navigateScreen,
    this.golfCourse = '',
    this.eventDate = '',
    this.teeTime = '',
  });

  Widget? navigateScreen;
  //String imagePath;
  String golfCourse;
  String eventDate;
  String teeTime;

  static List<HomeList> homeList = [
    HomeList(
      golfCourse: 'JGE FIRE',
      eventDate: 'Sat, Feb 5',
      teeTime: '1:00pm',
      // imagePath: 'assets/introduction_animation/introduction_animation.png',
      navigateScreen: HomeScreen(title: "test"),
    ),
    HomeList(
      //imagePath: 'assets/hotel/hotel_booking.png',\
      golfCourse: 'JGE EARTH',
      eventDate: 'Sat, Feb 12',
      teeTime: '1:00pm',
      navigateScreen: HomeScreen(title: "JGE EARTH"),
    ),
    HomeList(
      // imagePath: 'assets/fitness_app/fitness_app.png',
      golfCourse: 'Captains Day',
      eventDate: 'Sat, Feb 19',
      teeTime: '1:00pm',
      navigateScreen: HomeScreen(title: "Captains Day"),
    ),
    HomeList(
      //imagePath: 'assets/design_course/design_course.png',
      golfCourse: 'JGE EARTH',
      eventDate: 'Sat, Feb 5',
      teeTime: '1:00pm',
      navigateScreen: HomeScreen(title: "test"),
    ),
  ];
}
