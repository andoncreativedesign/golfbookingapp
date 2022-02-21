//import 'package:bookingapp2/model/event_model.dart';
import 'package:flutter/material.dart';
import 'model/homelist.dart';
import 'package:bookingapp2/model/db_functions.dart';
//import 'package:intl/intl.dart';

//import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:bookingapp/main.dart';
import 'package:bookingapp2/createevent.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  HomeScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  List<HomeList> homeList = HomeList.homeList;
  //List<EventModel> eventsListfetched = eventsList;
  AnimationController? animationController;
  List<dynamic>? eventsListfetched;
  bool multiple = true;

  Future<bool> getData() async {
    //getAllevents();
    //EventModel(eventsListfetched2[0]).toJson();
    // print(eventsListfetched2);
    eventsListfetched = await getAllevents();
    //print(eventsListfetched?.length);
    // await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SafeArea(
        child: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return SizedBox();
            } else {
              return Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 0, left: 16, right: 16, bottom: 20),
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    //print("clicked");
                                    // DatabaseReference _testRef =
                                    //     FirebaseDatabase.instance
                                    //         .ref()
                                    //         .child("test2");
                                    // _testRef.set("Hello");
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(builder: (ctx) {
                                      return CreateEvent();
                                    }));
                                  },
                                  child: Text("Create Event",
                                      style: TextStyle(fontSize: 15))),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 0, left: 16, right: 16, bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Upcoming Events",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                          ],
                        ),
                      ),
                      Expanded(
                          child: FutureBuilder<bool>(
                              future: getData(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<bool> snapshot) {
                                // print(eventsListfetched);
                                if (!snapshot.hasData) {
                                  return const SizedBox();
                                } else {
                                  return GridView(
                                    physics: const BouncingScrollPhysics(),
                                    padding: const EdgeInsets.only(
                                        top: 0, left: 12, right: 12),
                                    scrollDirection: Axis.vertical,
                                    children: List<Widget>.generate(
                                        eventsListfetched!.length, (int index) {
                                      final int count =
                                          eventsListfetched!.length;
                                      final Animation<double> animation =
                                          Tween<double>(begin: 0.0, end: 1.0)
                                              .animate(
                                        CurvedAnimation(
                                          parent: animationController!,
                                          curve: Interval(
                                              (1 / count) * index, 1.0,
                                              curve: Curves.fastOutSlowIn),
                                        ),
                                      );

                                      animationController?.forward();

                                      return HomeListView(
                                        animation: animation,
                                        animationController:
                                            animationController,
                                        eventsListfetched:
                                            eventsListfetched?[index],
                                        callBack: () {
                                          Navigator.push<dynamic>(
                                            context,
                                            MaterialPageRoute<dynamic>(
                                              builder: (BuildContext context) =>
                                                  eventsListfetched?[index]
                                                      .navigateScreen!,
                                            ),
                                          );
                                        },
                                      );
                                    }),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: multiple ? 2 : 1,
                                      mainAxisSpacing: 12.0,
                                      crossAxisSpacing: 12.0,
                                      childAspectRatio: 1.5,
                                    ),
                                  );
                                }
                              }))
                    ]),
              );
            }
          },
        ),
      ),
    );
  }
}

class HomeListView extends StatelessWidget {
  HomeListView(
      {Key? key,
      this.eventsListfetched,
      this.callBack,
      this.animationController,
      this.animation})
      : super(key: key);

  //final EventModel? eventsListfetched;
  final dynamic eventsListfetched;
  final VoidCallback? callBack;
  final AnimationController? animationController;
  final Animation<double>? animation;

  //final DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: AspectRatio(
              aspectRatio: 1.5,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                child: Stack(
                  // alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Positioned.fill(
                        child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16.0)),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(eventsListfetched['eventName'],
                                textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text((eventsListfetched['eventDate'])),
                            Text(eventsListfetched['eventNotes']),
                          ],
                        ),
                      ),
                    )
                        // child: Image.asset(
                        //   listData!.imagePath,
                        //   fit: BoxFit.cover,
                        // ),
                        ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.grey.withOpacity(0.2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                        onTap: callBack,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
