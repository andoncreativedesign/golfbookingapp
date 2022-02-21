import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:bookingapp2/model/event_model.dart';
import 'package:bookingapp2/model/db_functions.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//mport 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({Key? key}) : super(key: key);

  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime? _dateTime = DateTime.now();
  final _eventNameEC = TextEditingController();
  final _emailEC = TextEditingController();

  final _datTextController = TextEditingController();
  final _eventNotesEC = TextEditingController();
  List<String>? _selectedVal;
  String dropdownValue = 'AM';
  int _inviteOthers = 1;
  // List<Widget>? _phoneWidgets;
  int teetimeCnt = 1;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Create Event")),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'Enter your name',
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelText: 'Name'),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: _eventNameEC,
                      ),
                      TextFormField(
                          decoration: const InputDecoration(
                              hintText: 'Enter your email',
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              labelText: 'Email'),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          controller: _emailEC),
                      TextFormField(
                        controller: _datTextController,
                        decoration: const InputDecoration(
                            hintText: 'Choose date',
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelText: 'Choose date'),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());

                          showDemoDialog(context);
                        },
                      ),
                      TextFormField(
                          decoration: const InputDecoration(
                              hintText: 'Event notes',
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              labelText: 'Event notes'),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          controller: _eventNotesEC),
                      ...showTeeTime(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          children: [
                            Text("Invite others: "),
                            ToggleSwitch(
                              minWidth: 90.0,
                              cornerRadius: 20.0,
                              activeBgColors: [
                                [Colors.green[800]!],
                                [Colors.red[800]!]
                              ],
                              activeFgColor: Colors.white,
                              inactiveBgColor: Colors.grey,
                              inactiveFgColor: Colors.white,
                              initialLabelIndex: 1,
                              totalSwitches: 2,
                              labels: ['Yes', 'No'],
                              radiusStyle: true,
                              onToggle: (index) {
                                _inviteOthers = index!;
                                //  print('switched to: $index');
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // Validate will return true if the form is valid, or false if
                            // the form is invalid.
                            if (_formKey.currentState!.validate()) {
                              // Process data.
                              // print(_eventNameEC.text);
                              // print(_emailEC.text);
                              // print(_datTextController.text);
                              // print(_eventNotesEC.text);
                              // print(_inviteOthers);
                              final event = EventModel(
                                eventName: _eventNameEC.text,
                                emailId: _emailEC.text,
                                eventDate: _datTextController.text,
                                eventNotes: _eventNotesEC.text,
                                inviteOthers: _inviteOthers,
                                // teeTimes: [null]);
                              );

                              addEvent(event);
                              //print(eventsList);
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  List<Widget> showTeeTime() {
    List<Widget> _getTeetimes = [];

    for (int i = 0; i < teetimeCnt; i++) {
      _getTeetimes.add(Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: TextFormField(
                decoration: const InputDecoration(
                    hintText: 'Tee Time',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    labelText: 'Tee Time'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: 15),
            SizedBox(
                width: 60,
                height: 72,
                child: Padding(
                  padding: const EdgeInsets.only(top: 14.0),
                  child: DropdownButtonFormField(
                    value: _selectedVal?[i],
                    icon: const Icon(Icons.expand_more),
                    // elevation: 20,
                    autofocus: true,
                    items: <String>['AM', 'PM']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedVal?[i] = newValue!;
                        print(_selectedVal?[i]);
                        // _selectedVal[] = newValue.toString();
                      });
                    },
                  ),
                )),
            SizedBox(width: 180, child: _addRemoveButton(i == teetimeCnt - 1))
          ]));
    }
    return _getTeetimes;
  }

  Widget _addRemoveButton(add) {
    //bool add = true;
    // print(add);
    return InkWell(
      onTap: () {
        //print("tapped");
        if (add) {
          teetimeCnt = teetimeCnt + 1;
        } else {
          teetimeCnt = teetimeCnt - 1;
        }
        setState(() {});
      },
      child: (add)
          ? Icon(Icons.add, color: Colors.green)
          : Icon(Icons.remove, color: Colors.redAccent),
    );
  }

  void showDemoDialog(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2001),
            lastDate: DateTime(2030))
        .then((date) {
      setState(() {
        _dateTime = date;
        _datTextController.text = _dateTime.toString();
      });
    });
  }
}
